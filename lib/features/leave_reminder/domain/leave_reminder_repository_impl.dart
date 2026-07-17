import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../../../core/notifications/notification_service.dart';
import '../../../database/leave_reminder/commute_sample_entity.dart';
import '../../attendance/domain/attendance_repository.dart';
import '../../schedule/domain/models/work_schedule.dart';
import '../../schedule/domain/work_schedule_repository.dart';
import '../data/commute_routing_client.dart';
import '../data/commute_sample_dao.dart';
import '../data/leave_reminder_datasource.dart';
import '../data/weather_client.dart';
import '../leave_reminder_constants.dart';
import 'models/commute_estimate.dart';
import 'models/geo_point.dart';
import 'models/leave_reminder_prompt_trigger.dart';
import 'models/leave_reminder_settings.dart';
import 'models/tomorrow_preview.dart';
import 'models/weather_snapshot.dart';
import 'leave_reminder_repository.dart';
import 'traffic_copy.dart';
import 'weather_copy.dart';
import 'weather_forecast_lookup.dart';

@LazySingleton(as: LeaveReminderRepository)
class LeaveReminderRepositoryImpl implements LeaveReminderRepository {
  final LeaveReminderDatasource _datasource;
  final CommuteRoutingClient _routingClient;
  final WeatherClient _weatherClient;
  final NotificationService _notificationService;
  final SharedPreferences _prefs;
  final WorkScheduleRepository _workScheduleRepository;
  final AttendanceRepository _attendanceRepository;
  final CommuteSampleDao _commuteSampleDao;

  LeaveReminderRepositoryImpl(
    this._datasource,
    this._routingClient,
    this._weatherClient,
    this._notificationService,
    this._prefs,
    this._workScheduleRepository,
    this._attendanceRepository,
    this._commuteSampleDao,
  );

  @override
  Future<LeaveReminderSettings> getSettings() => _datasource.getSettings();

  @override
  Future<EnableLeaveReminderResult> setEnabled(bool enabled) async {
    if (enabled) {
      final granted = await _notificationService.requestPermission();
      if (!granted) {
        return EnableLeaveReminderResult.notificationPermissionDenied;
      }

      final settings = await getSettings();
      await _datasource.saveSettings(settings.copyWith(enabled: true));

      await Workmanager().registerPeriodicTask(
        kLeaveReminderWorkmanagerTaskName,
        kLeaveReminderWorkmanagerTaskName,
        frequency: const Duration(hours: 6),
      );

      await scheduleTodayReminders();
      return EnableLeaveReminderResult.success;
    }

    await Workmanager().cancelByUniqueName(kLeaveReminderWorkmanagerTaskName);
    await _notificationService.cancel(kHeadsUpNotificationId);
    await _notificationService.cancel(kLeaveNowNotificationId);

    final settings = await getSettings();
    await _datasource.saveSettings(settings.copyWith(enabled: false));
    return EnableLeaveReminderResult.success;
  }

  @override
  Future<LeaveReminderSettings> setHomeLocation(GeoPoint point) async {
    final settings = await getSettings();
    final updated = settings.copyWith(home: point);
    await _datasource.saveSettings(updated);
    // An average spanning a location change is meaningless — reset history
    // whenever either endpoint is set, even to the same point.
    _commuteSampleDao.deleteAll();
    return updated;
  }

  @override
  Future<LeaveReminderSettings> setWorkLocation(GeoPoint point) async {
    final settings = await getSettings();
    final updated = settings.copyWith(work: point);
    await _datasource.saveSettings(updated);
    _commuteSampleDao.deleteAll();
    return updated;
  }

  @override
  Future<LeaveReminderSettings> setHeadsUpLeadMinutes(int minutes) async {
    final settings = await getSettings();
    final updated = settings.copyWith(headsUpLeadMinutes: minutes);
    await _datasource.saveSettings(updated);
    return updated;
  }

  @override
  Future<void> scheduleTodayReminders() async {
    final schedule = await _workScheduleRepository.getCurrentActiveSchedule();
    final settings = await getSettings();

    if (schedule == null ||
        !settings.enabled ||
        settings.home == null ||
        settings.work == null ||
        !_workScheduleRepository.isWorkingDay(DateTime.now())) {
      await _notificationService.cancel(kHeadsUpNotificationId);
      await _notificationService.cancel(kLeaveNowNotificationId);
      return;
    }

    CommuteEstimate? estimate;
    try {
      estimate = await _routingClient.fetchCommuteEstimate(
        from: settings.home!,
        to: settings.work!,
      );
      await _datasource.saveCommuteCache(
        estimate.durationInTrafficMinutes,
        DateTime.now(),
      );

      final recent = _commuteSampleDao.getSince(
        DateTime.now().subtract(kCommuteSampleCooldown),
      );
      if (recent.isEmpty) {
        _commuteSampleDao.insert(
          CommuteSampleEntity(
            minutes: estimate.durationInTrafficMinutes,
            capturedAt: DateTime.now(),
          ),
        );
        _commuteSampleDao.deleteOlderThan(
          DateTime.now().subtract(kCommuteHistoryWindow),
        );
      }
    } catch (e) {
      debugPrint('Failed to fetch commute estimate: $e');
      // Offline / API failure: fall back to the cached lastCommuteMinutes,
      // handled below via `commuteMinutes`.
    }

    final commuteMinutes =
        estimate?.durationInTrafficMinutes ?? settings.lastCommuteMinutes;
    if (commuteMinutes == null) {
      // Nothing to schedule yet — never had a successful commute estimate.
      return;
    }

    final leaveTime = _computeLeaveTime(schedule, commuteMinutes);
    final headsUpTime = leaveTime.subtract(
      Duration(minutes: settings.headsUpLeadMinutes),
    );

    final now = DateTime.now();
    final leaveTimeText = _formatTime(leaveTime);

    WeatherSnapshot? weatherSnapshot;
    try {
      weatherSnapshot = await _weatherClient.fetchWeatherSnapshot(
        settings.work!,
      );
    } catch (e) {
      debugPrint('Failed to fetch weather snapshot: $e');
      weatherSnapshot = null;
    }

    final lines = <String>[
      estimate != null
          ? '🚦 ${trafficHeadline(estimate)} — leave at $leaveTimeText to arrive on time.'
          : '🚗 Leave at $leaveTimeText to arrive on time.',
    ];

    if (weatherSnapshot != null) {
      lines.add(
        '${weatherHeadline(weatherSnapshot.currentWeatherCode)}, '
        '${weatherSnapshot.currentTemperature.round()}°C right now.',
      );

      if (schedule.lunchMinutes > 0) {
        final lunchTime = _todayAt(schedule.lunchStartMinuteOfDay);
        final reading = weatherReadingAt(weatherSnapshot, lunchTime);
        if (reading != null) {
          lines.add(
            '🍽️ ${weatherEmoji(reading.weatherCode)} '
            '${reading.temperature.round()}°C expected at break time.',
          );
        }
      }

      final leaveReading = weatherReadingAt(weatherSnapshot, leaveTime);
      if (leaveReading != null) {
        lines.add(
          '${weatherEmoji(leaveReading.weatherCode)} ${leaveReading.temperature.round()}°C expected when you leave.',
        );
      }
    }

    if (headsUpTime.isAfter(now)) {
      await _notificationService.scheduleAt(
        id: kHeadsUpNotificationId,
        title: '🌅 Time to plan your commute',
        body: lines.join('\n'),
        scheduledDate: headsUpTime,
      );
    } else {
      await _notificationService.cancel(kHeadsUpNotificationId);
    }

    if (leaveTime.isAfter(now)) {
      await _notificationService.scheduleAt(
        id: kLeaveNowNotificationId,
        title: '🚗 Time to leave',
        body: 'Your commute is about $commuteMinutes min — leave now.',
        scheduledDate: leaveTime,
      );
    } else {
      await _notificationService.cancel(kLeaveNowNotificationId);
    }
  }

  @override
  Future<int?> getAverageCommuteMinutes() async {
    final since = DateTime.now().subtract(kCommuteHistoryWindow);
    final samples = _commuteSampleDao.getSince(since);
    if (samples.length < 2) return null; // no average until 2+ samples
    final avg =
        samples.map((s) => s.minutes).reduce((a, b) => a + b) / samples.length;
    return avg.round();
  }

  @override
  Future<DateTime?> getLeaveTime() async {
    final settings = await getSettings();
    if (!settings.enabled) return null;

    final commuteMinutes = settings.lastCommuteMinutes;
    if (commuteMinutes == null) return null;

    final schedule = await _workScheduleRepository.getCurrentActiveSchedule();
    if (schedule == null ||
        !_workScheduleRepository.isWorkingDay(DateTime.now())) {
      return null;
    }

    return _computeLeaveTime(schedule, commuteMinutes);
  }

  @override
  Future<DateTime?> getEstimatedArrivalTime() async {
    final settings = await getSettings();
    final commuteMinutes = settings.lastCommuteMinutes;
    final leaveTime = await getLeaveTime();
    if (leaveTime == null || commuteMinutes == null) return null;

    return leaveTime.add(Duration(minutes: commuteMinutes));
  }

  @override
  Future<LeaveReminderPromptTrigger?> checkIntroPromptTrigger() async {
    if (_prefs.getBool(kIntroPromptShownKey) ?? false) return null;

    final settings = await getSettings();
    if (settings.enabled) return null; // already using it, no need to pitch it

    final recent = await _attendanceRepository.getRecentAttendances(
      limit: kOnTimeStreakTarget + 2,
    ); // most-recent-first
    if (recent.isEmpty) return null;

    LeaveReminderPromptTrigger? trigger;
    final priorLate = recent.skip(1).any((a) => a.lateMinutes > 0);
    if (recent.first.lateMinutes > 0 && !priorLate) {
      trigger = LeaveReminderPromptTrigger.firstLateCheckIn;
    } else if (recent.length >= kOnTimeStreakTarget &&
        recent.take(kOnTimeStreakTarget).every((a) => a.lateMinutes <= 0)) {
      trigger = LeaveReminderPromptTrigger.onTimeStreak;
    }

    if (trigger != null) await _prefs.setBool(kIntroPromptShownKey, true);
    return trigger;
  }

  @override
  Future<TomorrowPreview?> getTomorrowPreview() async {
    final settings = await getSettings();
    if (!settings.enabled || settings.home == null || settings.work == null) {
      return null;
    }

    final tomorrow = DateTime.now().add(const Duration(days: 1));
    if (!_workScheduleRepository.isWorkingDay(tomorrow)) return null;

    final schedule = await _workScheduleRepository.getCurrentActiveSchedule();
    if (schedule == null) return null;

    final avgCommute = await getAverageCommuteMinutes();
    if (avgCommute == null) return null;

    final leaveTime = _leaveTimeFor(tomorrow, schedule, avgCommute);
    final leaveTimeText = _formatTime(leaveTime);

    WeatherSnapshot? weatherSnapshot;
    try {
      weatherSnapshot = await _weatherClient.fetchWeatherSnapshot(
        settings.work!,
      );
    } catch (e) {
      debugPrint('Failed to fetch weather snapshot for tomorrow preview: $e');
    }

    final reading = weatherSnapshot != null
        ? weatherReadingAt(weatherSnapshot, leaveTime)
        : null;

    final lines = <String>[
      '🚗 Avg commute ~$avgCommute min — leave around $leaveTimeText to arrive on time.',
    ];
    if (reading != null) {
      lines.add(
        '${weatherEmoji(reading.weatherCode)} ${reading.temperature.round()}°C expected when you leave.',
      );
    }

    return TomorrowPreview(
      leaveTime: leaveTime,
      averageCommuteMinutes: avgCommute,
      weatherCode: reading?.weatherCode,
      temperature: reading?.temperature,
      bodyText: lines.join('\n'),
    );
  }

  /// Pure computation of the time to leave home on [date] for [schedule],
  /// given [commuteMinutes] — the scheduled start time shifted back by the
  /// schedule's reminder buffer and the commute duration. Does not check
  /// whether the time has already passed or whether reminders are enabled
  /// — callers are responsible for those.
  DateTime _leaveTimeFor(
    DateTime date,
    WorkSchedule schedule,
    int commuteMinutes,
  ) => _dateTimeAt(
    date,
    schedule.startMinuteOfDay,
  ).subtract(Duration(minutes: schedule.reminderMinutes + commuteMinutes));

  DateTime _computeLeaveTime(WorkSchedule schedule, int commuteMinutes) =>
      _leaveTimeFor(DateTime.now(), schedule, commuteMinutes);

  DateTime _dateTimeAt(DateTime date, int minuteOfDay) => DateTime(
    date.year,
    date.month,
    date.day,
  ).add(Duration(minutes: minuteOfDay));

  DateTime _todayAt(int minuteOfDay) =>
      _dateTimeAt(DateTime.now(), minuteOfDay);

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
