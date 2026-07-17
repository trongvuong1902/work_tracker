import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_tracker/core/notifications/notification_service.dart';
import 'package:work_tracker/database/leave_reminder/commute_sample_entity.dart';
import 'package:work_tracker/database/leave_reminder/notification_log_entity.dart';
import 'package:work_tracker/features/attendance/domain/attendance_repository.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';
import 'package:work_tracker/features/leave_reminder/data/commute_routing_client.dart';
import 'package:work_tracker/features/leave_reminder/data/commute_sample_dao.dart';
import 'package:work_tracker/features/leave_reminder/data/leave_reminder_datasource.dart';
import 'package:work_tracker/features/leave_reminder/data/notification_log_dao.dart';
import 'package:work_tracker/features/leave_reminder/data/weather_client.dart';
import 'package:work_tracker/features/leave_reminder/domain/leave_reminder_repository_impl.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/commute_estimate.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/geo_point.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/leave_reminder_prompt_trigger.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/leave_reminder_settings.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/weather_snapshot.dart';
import 'package:work_tracker/features/schedule/domain/models/work_schedule.dart';
import 'package:work_tracker/features/schedule/domain/work_schedule_repository.dart';

// Skipped from this test file (see final report for rationale):
// - `setEnabled(true/false)` and `scheduleTodayReminders()`: both call the
//   real `Workmanager()` singleton, which requires a platform channel not
//   available under plain `flutter_test` (no mockable seam exists on the
//   repository's dependencies for it), and `scheduleTodayReminders()` also
//   drives the live `CommuteRoutingClient`/`WeatherClient` HTTP calls.
// - The HTTP-fetching portion of `getTomorrowPreview()`/`scheduleTodayReminders()`
//   (`_fetchTotalCommuteEstimate`, live weather) — only the
//   network-independent computation is exercised here, using a
//   `WeatherClient` fake that throws (exercising the existing try/catch
//   fallback) rather than a fake that fabricates network data.

/// Minimal hand-written fakes, matching this project's established
/// convention (see setting_schedule_cubit_test.dart): no mocktail/bloc_test
/// dependency is present in pubspec.yaml yet, and these interfaces are small
/// enough that fakes are straightforward and don't require adding one.
class FakeLeaveReminderDatasource implements LeaveReminderDatasource {
  FakeLeaveReminderDatasource({LeaveReminderSettings? initial})
    : _settings = initial ?? const LeaveReminderSettings();

  LeaveReminderSettings _settings;
  int? lastCommuteCacheMinutes;
  DateTime? lastCommuteCacheUpdatedAt;

  @override
  Future<LeaveReminderSettings> getSettings() async => _settings;

  @override
  Future<void> saveSettings(LeaveReminderSettings settings) async {
    _settings = settings;
  }

  @override
  Future<void> saveCommuteCache(int minutes, DateTime updatedAt) async {
    lastCommuteCacheMinutes = minutes;
    lastCommuteCacheUpdatedAt = updatedAt;
  }
}

class FakeCommuteRoutingClient implements CommuteRoutingClient {
  @override
  Future<CommuteEstimate> fetchCommuteEstimate({
    required GeoPoint from,
    required GeoPoint to,
  }) => throw UnimplementedError(
    'Not exercised: live routing HTTP calls are out of scope for these tests.',
  );
}

/// Always throws, exercising the same try/catch fallback path a real
/// offline/API-failure would — without fabricating fake network data.
class ThrowingFakeWeatherClient implements WeatherClient {
  @override
  Future<WeatherSnapshot> fetchWeatherSnapshot(GeoPoint location) =>
      throw Exception('offline');
}

class FakeNotificationService implements NotificationService {
  final List<({int id, DateTime scheduledDate})> scheduledCalls = [];
  final List<int> cancelledIds = [];

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<bool> ensureExactAlarmPermission() async => true;

  @override
  Future<void> scheduleAt({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    bool exact = true,
    bool bypassSilentMode = false,
  }) async {
    scheduledCalls.add((id: id, scheduledDate: scheduledDate));
  }

  @override
  Future<void> show({
    required int id,
    required String title,
    required String body,
  }) async {}

  @override
  Future<void> cancel(int id) async {
    cancelledIds.add(id);
  }

  @override
  Future<List<ScheduledNotificationInfo>> pendingNotifications() async => [];
}

class FakeWorkScheduleRepository implements WorkScheduleRepository {
  FakeWorkScheduleRepository({this.schedule, this.workingDayResult = true});

  WorkSchedule? schedule;
  bool workingDayResult;

  @override
  Future<WorkSchedule?> getCurrentActiveSchedule() async => schedule;

  @override
  Future<void> saveWorkSchedule(WorkSchedule workSchedule) async {
    schedule = workSchedule;
  }

  @override
  bool isWorkingDay(DateTime dateTime) => workingDayResult;
}

class FakeAttendanceRepository implements AttendanceRepository {
  FakeAttendanceRepository({this.recentAttendances = const []});

  List<Attendance> recentAttendances;

  @override
  Future<Attendance?> getTodayAttendance() async => null;

  @override
  Future<Attendance> checkIn(DateTime time) => throw UnimplementedError();

  @override
  Future<Attendance> checkOut(DateTime time) => throw UnimplementedError();

  @override
  Stream<Attendance?> watchAttendanceChanges() => const Stream.empty();

  @override
  Future<List<Attendance>> getRecentAttendances({int limit = 10}) async =>
      recentAttendances.take(limit).toList();

  @override
  Future<Map<int, Attendance>> getAttendanceForMonth({
    required int year,
    required int month,
  }) async => {};

  @override
  void clearTodayAttendance() {}
}

class FakeCommuteSampleDao implements CommuteSampleDao {
  final List<CommuteSampleEntity> _samples = [];

  @override
  void insert(CommuteSampleEntity entity) => _samples.add(entity);

  @override
  List<CommuteSampleEntity> getSince(DateTime since) => _samples
      .where((s) => !s.capturedAt.isBefore(since))
      .toList()
    ..sort((a, b) => b.capturedAt.compareTo(a.capturedAt));

  @override
  void deleteOlderThan(DateTime before) =>
      _samples.removeWhere((s) => s.capturedAt.isBefore(before));

  @override
  void deleteAll() => _samples.clear();
}

class FakeNotificationLogDao implements NotificationLogDao {
  final List<NotificationLogEntity> _entries = [];

  @override
  void insert(NotificationLogEntity entity) => _entries.add(entity);

  @override
  List<NotificationLogEntity> getSince(DateTime since) => _entries
      .where((e) => !e.scheduledAt.isBefore(since))
      .toList()
    ..sort((a, b) => b.scheduledAt.compareTo(a.scheduledAt));

  @override
  NotificationLogEntity? mostRecentFor(int notificationId) {
    final matches = _entries.where((e) => e.notificationId == notificationId).toList()
      ..sort((a, b) => b.scheduledAt.compareTo(a.scheduledAt));
    return matches.isEmpty ? null : matches.first;
  }

  @override
  void deleteOlderThan(DateTime before) =>
      _entries.removeWhere((e) => e.scheduledAt.isBefore(before));
}

Attendance buildAttendance({int lateMinutes = 0}) => Attendance(
  workDate: DateTime(2026, 7, 17),
  dayKey: 20260717,
  checkIn: DateTime(2026, 7, 17, 9, lateMinutes),
  expectedStartMinute: 540,
  expectedEndMinute: 1080,
  lunchMinutes: 60,
  expectedLunchStartMinute: 720,
  lateMinutes: lateMinutes,
);

void main() {
  late FakeLeaveReminderDatasource datasource;
  late FakeWorkScheduleRepository workScheduleRepository;
  late FakeAttendanceRepository attendanceRepository;
  late FakeCommuteSampleDao commuteSampleDao;
  late FakeNotificationLogDao notificationLogDao;
  late LeaveReminderRepositoryImpl repository;

  Future<void> setUpRepository({
    LeaveReminderSettings? settings,
    WorkSchedule? schedule,
    bool workingDayResult = true,
    List<Attendance> recentAttendances = const [],
    SharedPreferences? prefs,
  }) async {
    datasource = FakeLeaveReminderDatasource(initial: settings);
    workScheduleRepository = FakeWorkScheduleRepository(
      schedule: schedule,
      workingDayResult: workingDayResult,
    );
    attendanceRepository = FakeAttendanceRepository(
      recentAttendances: recentAttendances,
    );
    commuteSampleDao = FakeCommuteSampleDao();
    notificationLogDao = FakeNotificationLogDao();
    repository = LeaveReminderRepositoryImpl(
      datasource,
      FakeCommuteRoutingClient(),
      ThrowingFakeWeatherClient(),
      FakeNotificationService(),
      prefs ?? await SharedPreferences.getInstance(),
      workScheduleRepository,
      attendanceRepository,
      commuteSampleDao,
      notificationLogDao,
    );
  }

  const schedule = WorkSchedule(
    startMinuteOfDay: 540, // 09:00
    endMinuteOfDay: 1080, // 18:00
    lunchMinutes: 60,
    lunchStartMinuteOfDay: 720,
    reminderMinutes: 10,
  );

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('waypoint/location settings CRUD', () {
    test('setHomeLocation saves and resets commute sample history', () async {
      await setUpRepository();
      commuteSampleDao.insert(
        CommuteSampleEntity(minutes: 30, capturedAt: DateTime.now()),
      );

      final point = const GeoPoint(latitude: 1, longitude: 2);
      final updated = await repository.setHomeLocation(point);

      expect(updated.home, point);
      expect(commuteSampleDao.getSince(DateTime(2000)), isEmpty);
    });

    test('setWorkLocation saves and resets commute sample history', () async {
      await setUpRepository();
      commuteSampleDao.insert(
        CommuteSampleEntity(minutes: 30, capturedAt: DateTime.now()),
      );

      final point = const GeoPoint(latitude: 3, longitude: 4);
      final updated = await repository.setWorkLocation(point);

      expect(updated.work, point);
      expect(commuteSampleDao.getSince(DateTime(2000)), isEmpty);
    });

    test('addWaypoint appends in add-order', () async {
      await setUpRepository();
      final a = const GeoPoint(latitude: 1, longitude: 1);
      final b = const GeoPoint(latitude: 2, longitude: 2);

      await repository.addWaypoint(a);
      final updated = await repository.addWaypoint(b);

      expect(updated.waypoints.map((w) => w.location), [a, b]);
      expect(updated.waypoints.every((w) => w.enabled), isTrue);
    });

    test('addWaypoint is a no-op once at the max cap', () async {
      await setUpRepository();
      for (var i = 0; i < 3; i++) {
        await repository.addWaypoint(GeoPoint(latitude: i.toDouble(), longitude: 0));
      }
      final atCap = await datasource.getSettings();
      expect(atCap.waypoints, hasLength(3));

      final result = await repository.addWaypoint(
        const GeoPoint(latitude: 99, longitude: 99),
      );

      expect(result.waypoints, hasLength(3)); // unchanged
    });

    test('removeWaypointAt removes and shifts remaining down', () async {
      await setUpRepository();
      final a = const GeoPoint(latitude: 1, longitude: 1);
      final b = const GeoPoint(latitude: 2, longitude: 2);
      await repository.addWaypoint(a);
      await repository.addWaypoint(b);

      final updated = await repository.removeWaypointAt(0);

      expect(updated.waypoints.map((w) => w.location), [b]);
    });

    test('removeWaypointAt with an out-of-range index is a no-op', () async {
      await setUpRepository();
      await repository.addWaypoint(const GeoPoint(latitude: 1, longitude: 1));

      final updated = await repository.removeWaypointAt(5);

      expect(updated.waypoints, hasLength(1));
    });

    test('setWaypointEnabledAt toggles without changing location', () async {
      await setUpRepository();
      final point = const GeoPoint(latitude: 1, longitude: 1);
      await repository.addWaypoint(point);

      final updated = await repository.setWaypointEnabledAt(0, false);

      expect(updated.waypoints.single.enabled, isFalse);
      expect(updated.waypoints.single.location, point);
    });

    test('setWaypointLocationAt replaces location without changing index/enabled', () async {
      await setUpRepository();
      await repository.addWaypoint(const GeoPoint(latitude: 1, longitude: 1));
      await repository.setWaypointEnabledAt(0, false);

      final newLocation = const GeoPoint(latitude: 9, longitude: 9);
      final updated = await repository.setWaypointLocationAt(0, newLocation);

      expect(updated.waypoints.single.location, newLocation);
      expect(updated.waypoints.single.enabled, isFalse);
    });

    test('setHeadsUpLeadMinutes persists the new value', () async {
      await setUpRepository();
      final updated = await repository.setHeadsUpLeadMinutes(25);
      expect(updated.headsUpLeadMinutes, 25);
    });

    test('setWorkRadiusMeters persists the new value', () async {
      await setUpRepository();
      final updated = await repository.setWorkRadiusMeters(300);
      expect(updated.workRadiusMeters, 300);
    });
  });

  group('getLeaveTime', () {
    test('null when reminders are disabled', () async {
      await setUpRepository(
        settings: const LeaveReminderSettings(enabled: false, lastCommuteMinutes: 30),
        schedule: schedule,
      );
      expect(await repository.getLeaveTime(), isNull);
    });

    test('null when no commute estimate exists yet', () async {
      await setUpRepository(
        settings: const LeaveReminderSettings(enabled: true, lastCommuteMinutes: null),
        schedule: schedule,
      );
      expect(await repository.getLeaveTime(), isNull);
    });

    test('null when there is no active schedule', () async {
      await setUpRepository(
        settings: const LeaveReminderSettings(enabled: true, lastCommuteMinutes: 30),
        schedule: null,
      );
      expect(await repository.getLeaveTime(), isNull);
    });

    test('null when today is not a working day', () async {
      await setUpRepository(
        settings: const LeaveReminderSettings(enabled: true, lastCommuteMinutes: 30),
        schedule: schedule,
        workingDayResult: false,
      );
      expect(await repository.getLeaveTime(), isNull);
    });

    test(
      'computes leave time as schedule start minus (reminderMinutes + commuteMinutes)',
      () async {
        await setUpRepository(
          settings: const LeaveReminderSettings(enabled: true, lastCommuteMinutes: 40),
          schedule: schedule, // startMinuteOfDay: 540, reminderMinutes: 10
        );

        final leaveTime = await repository.getLeaveTime();

        final today = DateTime.now();
        final expected = DateTime(today.year, today.month, today.day)
            .add(const Duration(minutes: 540))
            .subtract(const Duration(minutes: 10 + 40));
        expect(leaveTime, expected);
      },
    );
  });

  group('getEstimatedArrivalTime', () {
    test('null when getLeaveTime is null', () async {
      await setUpRepository(
        settings: const LeaveReminderSettings(enabled: false, lastCommuteMinutes: 30),
        schedule: schedule,
      );
      expect(await repository.getEstimatedArrivalTime(), isNull);
    });

    test('is leave time plus commute minutes', () async {
      await setUpRepository(
        settings: const LeaveReminderSettings(enabled: true, lastCommuteMinutes: 40),
        schedule: schedule,
      );

      final leaveTime = await repository.getLeaveTime();
      final arrival = await repository.getEstimatedArrivalTime();

      expect(arrival, leaveTime!.add(const Duration(minutes: 40)));
    });
  });

  group('getAverageCommuteMinutes', () {
    test('null with fewer than 2 samples', () async {
      await setUpRepository();
      commuteSampleDao.insert(
        CommuteSampleEntity(minutes: 30, capturedAt: DateTime.now()),
      );
      expect(await repository.getAverageCommuteMinutes(), isNull);
    });

    test('rounds the mean of recent samples', () async {
      await setUpRepository();
      final now = DateTime.now();
      commuteSampleDao.insert(CommuteSampleEntity(minutes: 30, capturedAt: now));
      commuteSampleDao.insert(CommuteSampleEntity(minutes: 31, capturedAt: now));
      commuteSampleDao.insert(CommuteSampleEntity(minutes: 32, capturedAt: now));
      // (30+31+32)/3 = 31.0
      expect(await repository.getAverageCommuteMinutes(), 31);
    });

    test('ignores samples outside the history window', () async {
      await setUpRepository();
      final now = DateTime.now();
      commuteSampleDao.insert(
        CommuteSampleEntity(
          minutes: 999,
          capturedAt: now.subtract(const Duration(days: 30)),
        ),
      );
      commuteSampleDao.insert(CommuteSampleEntity(minutes: 30, capturedAt: now));
      // Only 1 sample within the (default 14-day) window -> null.
      expect(await repository.getAverageCommuteMinutes(), isNull);
    });
  });

  group('checkIntroPromptTrigger', () {
    test('null when the intro prompt was already shown', () async {
      SharedPreferences.setMockInitialValues({
        'leave_reminder_intro_prompt_shown': true,
      });
      final prefs = await SharedPreferences.getInstance();
      await setUpRepository(
        prefs: prefs,
        recentAttendances: [buildAttendance(lateMinutes: 5)],
      );
      expect(await repository.checkIntroPromptTrigger(), isNull);
    });

    test('null when reminders are already enabled', () async {
      await setUpRepository(
        settings: const LeaveReminderSettings(enabled: true),
        recentAttendances: [buildAttendance(lateMinutes: 5)],
      );
      expect(await repository.checkIntroPromptTrigger(), isNull);
    });

    test('null when there is no attendance history', () async {
      await setUpRepository(recentAttendances: []);
      expect(await repository.checkIntroPromptTrigger(), isNull);
    });

    test(
      'firstLateCheckIn when the latest check-in is late and no prior one was',
      () async {
        await setUpRepository(
          recentAttendances: [
            buildAttendance(lateMinutes: 5), // most recent: late
            buildAttendance(lateMinutes: 0),
            buildAttendance(lateMinutes: 0),
          ],
        );

        final trigger = await repository.checkIntroPromptTrigger();

        expect(trigger, LeaveReminderPromptTrigger.firstLateCheckIn);
      },
    );

    test(
      'null (not firstLateCheckIn) when a prior check-in was also late',
      () async {
        await setUpRepository(
          recentAttendances: [
            buildAttendance(lateMinutes: 5), // most recent: late
            buildAttendance(lateMinutes: 3), // prior: also late
            buildAttendance(lateMinutes: 0),
          ],
        );

        final trigger = await repository.checkIntroPromptTrigger();

        expect(trigger, isNot(LeaveReminderPromptTrigger.firstLateCheckIn));
      },
    );

    test(
      'onTimeStreak when the most recent kOnTimeStreakTarget check-ins are all on time',
      () async {
        await setUpRepository(
          recentAttendances: [
            buildAttendance(lateMinutes: 0),
            buildAttendance(lateMinutes: 0),
            buildAttendance(lateMinutes: 0),
          ],
        );

        final trigger = await repository.checkIntroPromptTrigger();

        expect(trigger, LeaveReminderPromptTrigger.onTimeStreak);
      },
    );

    test('marks the intro prompt as shown once a trigger fires', () async {
      final prefs = await SharedPreferences.getInstance();
      await setUpRepository(
        prefs: prefs,
        recentAttendances: [
          buildAttendance(lateMinutes: 0),
          buildAttendance(lateMinutes: 0),
          buildAttendance(lateMinutes: 0),
        ],
      );

      expect(prefs.getBool('leave_reminder_intro_prompt_shown'), isNull);
      await repository.checkIntroPromptTrigger();
      expect(prefs.getBool('leave_reminder_intro_prompt_shown'), isTrue);
    });

    test('does not mark the flag when no trigger fires', () async {
      final prefs = await SharedPreferences.getInstance();
      await setUpRepository(
        prefs: prefs,
        recentAttendances: [buildAttendance(lateMinutes: 0)], // no streak, no late
      );

      await repository.checkIntroPromptTrigger();

      expect(prefs.getBool('leave_reminder_intro_prompt_shown'), isNot(true));
    });
  });

  group('getTomorrowPreview (network-independent branches only)', () {
    test('null when reminders are disabled', () async {
      await setUpRepository(
        settings: const LeaveReminderSettings(enabled: false),
        schedule: schedule,
      );
      expect(await repository.getTomorrowPreview(), isNull);
    });

    test('null when home/work are not both set', () async {
      await setUpRepository(
        settings: const LeaveReminderSettings(
          enabled: true,
          home: GeoPoint(latitude: 1, longitude: 1),
          work: null,
        ),
        schedule: schedule,
      );
      expect(await repository.getTomorrowPreview(), isNull);
    });

    test('null when tomorrow is not a working day', () async {
      await setUpRepository(
        settings: LeaveReminderSettings(
          enabled: true,
          home: const GeoPoint(latitude: 1, longitude: 1),
          work: const GeoPoint(latitude: 2, longitude: 2),
        ),
        schedule: schedule,
        workingDayResult: false,
      );
      expect(await repository.getTomorrowPreview(), isNull);
    });

    test('null when there is no active schedule', () async {
      await setUpRepository(
        settings: LeaveReminderSettings(
          enabled: true,
          home: const GeoPoint(latitude: 1, longitude: 1),
          work: const GeoPoint(latitude: 2, longitude: 2),
        ),
        schedule: null,
      );
      expect(await repository.getTomorrowPreview(), isNull);
    });

    test('null when there is no average commute yet (< 2 samples)', () async {
      await setUpRepository(
        settings: LeaveReminderSettings(
          enabled: true,
          home: const GeoPoint(latitude: 1, longitude: 1),
          work: const GeoPoint(latitude: 2, longitude: 2),
        ),
        schedule: schedule,
      );
      commuteSampleDao.insert(
        CommuteSampleEntity(minutes: 30, capturedAt: DateTime.now()),
      );
      expect(await repository.getTomorrowPreview(), isNull);
    });

    test(
      'computes tomorrow leave time from average commute when the weather '
      'fetch fails (falls back gracefully, no weather fields set)',
      () async {
        await setUpRepository(
          settings: LeaveReminderSettings(
            enabled: true,
            home: const GeoPoint(latitude: 1, longitude: 1),
            work: const GeoPoint(latitude: 2, longitude: 2),
          ),
          schedule: schedule, // startMinuteOfDay: 540, reminderMinutes: 10
        );
        final now = DateTime.now();
        commuteSampleDao.insert(CommuteSampleEntity(minutes: 30, capturedAt: now));
        commuteSampleDao.insert(CommuteSampleEntity(minutes: 40, capturedAt: now));
        // avg = 35

        final preview = await repository.getTomorrowPreview();

        expect(preview, isNotNull);
        expect(preview!.averageCommuteMinutes, 35);
        expect(preview.weatherCode, isNull);
        expect(preview.temperature, isNull);

        final tomorrow = DateTime.now().add(const Duration(days: 1));
        final expectedLeaveTime =
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day)
                .add(const Duration(minutes: 540))
                .subtract(const Duration(minutes: 10 + 35));
        expect(preview.leaveTime, expectedLeaveTime);
        expect(preview.bodyText, contains('35 min'));
      },
    );
  });
}
