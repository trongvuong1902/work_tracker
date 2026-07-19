import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../../../core/notifications/notification_service.dart';
import '../../../database/leave_reminder/commute_sample_entity.dart';
import '../../../database/leave_reminder/notification_log_entity.dart';
import '../../attendance/domain/attendance_repository.dart';
import '../../schedule/domain/models/work_schedule.dart';
import '../../schedule/domain/work_schedule_repository.dart';
import '../data/commute_routing_client.dart';
import '../data/commute_sample_dao.dart';
import '../data/leave_reminder_datasource.dart';
import '../data/notification_log_dao.dart';
import '../data/weather_client.dart';
import '../leave_reminder_constants.dart';
import 'models/commute_estimate.dart';
import 'models/commute_waypoint.dart';
import 'models/geo_point.dart';
import 'models/leave_reminder_prompt_trigger.dart';
import 'models/leave_reminder_settings.dart';
import 'models/notification_log_entry.dart';
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
  final NotificationLogDao _notificationLogDao;

  LeaveReminderRepositoryImpl(
    this._datasource,
    this._routingClient,
    this._weatherClient,
    this._notificationService,
    this._prefs,
    this._workScheduleRepository,
    this._attendanceRepository,
    this._commuteSampleDao,
    this._notificationLogDao,
  );

  // Broadcasts whenever leave-time-relevant state changes so reactive
  // consumers (e.g. the Home hero card) can re-read the computed leave/arrival
  // time. This repo is an app-lifetime @LazySingleton, so — like the attendance
  // stream — the controller is intentionally never closed.
  final _leaveInfoController = StreamController<void>.broadcast();

  @override
  Stream<void> watchLeaveInfoChanges() => _leaveInfoController.stream;

  void _notifyLeaveInfoChanged() => _leaveInfoController.add(null);

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

      _notifyLeaveInfoChanged();
      await scheduleTodayReminders();
      return EnableLeaveReminderResult.success;
    }

    await Workmanager().cancelByUniqueName(kLeaveReminderWorkmanagerTaskName);
    await _notificationService.cancel(kHeadsUpNotificationId);
    await _notificationService.cancel(kLeaveNowNotificationId);

    final settings = await getSettings();
    await _datasource.saveSettings(settings.copyWith(enabled: false));
    _notifyLeaveInfoChanged();
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
    _notifyLeaveInfoChanged();
    return updated;
  }

  @override
  Future<LeaveReminderSettings> setWorkLocation(GeoPoint point) async {
    final settings = await getSettings();
    final updated = settings.copyWith(work: point);
    await _datasource.saveSettings(updated);
    _commuteSampleDao.deleteAll();
    _notifyLeaveInfoChanged();
    return updated;
  }

  @override
  Future<LeaveReminderSettings> addWaypoint(GeoPoint point) async {
    final settings = await getSettings();
    if (settings.waypoints.length >= kMaxCommuteWaypoints) {
      return settings; // already at the cap — no-op.
    }
    final updated = settings.copyWith(
      waypoints: [
        ...settings.waypoints,
        CommuteWaypoint(location: point),
      ],
    );
    await _datasource.saveSettings(updated);
    _commuteSampleDao.deleteAll();
    _notifyLeaveInfoChanged();
    return updated;
  }

  @override
  Future<LeaveReminderSettings> removeWaypointAt(int index) async {
    // Reload fresh (not from stale in-memory state) so rapid taps racing
    // each other can't clobber one another's changes.
    final settings = await getSettings();
    if (index < 0 || index >= settings.waypoints.length) return settings;
    final updatedWaypoints = [...settings.waypoints]..removeAt(index);
    final updated = settings.copyWith(waypoints: updatedWaypoints);
    await _datasource.saveSettings(updated);
    _commuteSampleDao.deleteAll();
    _notifyLeaveInfoChanged();
    return updated;
  }

  @override
  Future<LeaveReminderSettings> setWaypointEnabledAt(
    int index,
    bool enabled,
  ) async {
    final settings = await getSettings();
    if (index < 0 || index >= settings.waypoints.length) return settings;
    final updatedWaypoints = [...settings.waypoints];
    updatedWaypoints[index] = updatedWaypoints[index].copyWith(
      enabled: enabled,
    );
    final updated = settings.copyWith(waypoints: updatedWaypoints);
    await _datasource.saveSettings(updated);
    _commuteSampleDao.deleteAll();
    _notifyLeaveInfoChanged();
    return updated;
  }

  @override
  Future<LeaveReminderSettings> setWaypointLocationAt(
    int index,
    GeoPoint point,
  ) async {
    final settings = await getSettings();
    if (index < 0 || index >= settings.waypoints.length) return settings;
    final updatedWaypoints = [...settings.waypoints];
    updatedWaypoints[index] = updatedWaypoints[index].copyWith(location: point);
    final updated = settings.copyWith(waypoints: updatedWaypoints);
    await _datasource.saveSettings(updated);
    _commuteSampleDao.deleteAll();
    _notifyLeaveInfoChanged();
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
  Future<LeaveReminderSettings> setWorkRadiusMeters(int meters) async {
    final settings = await getSettings();
    final updated = settings.copyWith(workRadiusMeters: meters);
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
      estimate = await _fetchTotalCommuteEstimate(settings);
      await _datasource.saveCommuteCache(
        estimate.durationInTrafficMinutes,
        DateTime.now(),
      );
      // Fresh commute cached → leave/arrival time is now computable; notify
      // reactive consumers (e.g. the Home hero card).
      _notifyLeaveInfoChanged();

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
      const headsUpTitle = '🌅 Time to plan your commute';
      final headsUpBody = lines.join('\n');
      await _notificationService.scheduleAt(
        id: kHeadsUpNotificationId,
        title: headsUpTitle,
        body: headsUpBody,
        scheduledDate: headsUpTime,
      );
      _logScheduledNotification(
        notificationId: kHeadsUpNotificationId,
        title: headsUpTitle,
        body: headsUpBody,
        scheduledAt: headsUpTime,
      );
    } else {
      await _notificationService.cancel(kHeadsUpNotificationId);
    }

    if (leaveTime.isAfter(now)) {
      const leaveNowTitle = '🚗 Time to leave';
      final leaveNowBody =
          'Your commute is about $commuteMinutes min — leave now.';
      await _notificationService.scheduleAt(
        id: kLeaveNowNotificationId,
        title: leaveNowTitle,
        body: leaveNowBody,
        scheduledDate: leaveTime,
      );
      _logScheduledNotification(
        notificationId: kLeaveNowNotificationId,
        title: leaveNowTitle,
        body: leaveNowBody,
        scheduledAt: leaveTime,
      );
    } else {
      await _notificationService.cancel(kLeaveNowNotificationId);
    }

    _notificationLogDao.deleteOlderThan(
      DateTime.now().subtract(kNotificationLogWindow),
    );
  }

  /// Logs that [notificationId] was just scheduled to fire at
  /// [scheduledAt], skipping the write if the most recent log entry for
  /// this id already reflects the identical fire time (recomputing and
  /// rescheduling today's reminders every ~6h shouldn't spam the log with
  /// duplicate rows when nothing actually changed).
  void _logScheduledNotification({
    required int notificationId,
    required String title,
    required String body,
    required DateTime scheduledAt,
  }) {
    final latest = _notificationLogDao.mostRecentFor(notificationId);
    if (latest != null && latest.scheduledAt.isAtSameMomentAs(scheduledAt)) {
      return;
    }
    _notificationLogDao.insert(
      NotificationLogEntity(
        notificationId: notificationId,
        title: title,
        body: body,
        scheduledAt: scheduledAt,
      ),
    );
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

  @override
  Future<List<NotificationLogEntry>> getNotificationLog() async {
    final entities = _notificationLogDao.getSince(
      DateTime.now().subtract(kNotificationLogWindow),
    );
    return entities
        .map(
          (e) => NotificationLogEntry(
            notificationId: e.notificationId,
            title: e.title,
            body: e.body,
            scheduledAt: e.scheduledAt,
          ),
        )
        .toList();
  }

  /// Fetches the total commute estimate for the full route — Home, then
  /// every *enabled* stop in add-order, then Work — by calling
  /// [_routingClient] once per consecutive leg and summing durations. With
  /// zero enabled waypoints this is exactly one call, identical to the
  /// single-leg Home -> Work behavior from before waypoints existed.
  Future<CommuteEstimate> _fetchTotalCommuteEstimate(
    LeaveReminderSettings settings,
  ) async {
    final route = [
      settings.home!,
      ...settings.waypoints.where((w) => w.enabled).map((w) => w.location),
      settings.work!,
    ];

    var totalMinutes = 0;
    var totalMinutesInTraffic = 0;
    for (var i = 0; i < route.length - 1; i++) {
      final leg = await _routingClient.fetchCommuteEstimate(
        from: route[i],
        to: route[i + 1],
      );
      totalMinutes += leg.durationMinutes;
      totalMinutesInTraffic += leg.durationInTrafficMinutes;
    }

    return CommuteEstimate(
      durationMinutes: totalMinutes,
      durationInTrafficMinutes: totalMinutesInTraffic,
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
