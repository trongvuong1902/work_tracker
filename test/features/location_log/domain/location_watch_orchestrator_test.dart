import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:workmanager/workmanager.dart';
import 'package:work_tracker/features/attendance/domain/attendance_repository.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';
import 'package:work_tracker/features/leave_reminder/domain/leave_reminder_repository.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/geo_point.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/leave_reminder_prompt_trigger.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/leave_reminder_settings.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/notification_log_entry.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/tomorrow_preview.dart';
import 'package:work_tracker/features/location_log/data/location_watch_service.dart';
import 'package:work_tracker/features/location_log/domain/location_log_repository.dart';
import 'package:work_tracker/features/location_log/domain/location_watch_orchestrator.dart';
import 'package:work_tracker/features/location_log/domain/models/location_log.dart';
import 'package:work_tracker/features/location_log/domain/models/location_log_type.dart';
import 'package:work_tracker/features/schedule/domain/models/work_schedule.dart';
import 'package:work_tracker/features/schedule/domain/work_schedule_repository.dart';

/// Hand-written fakes, matching this project's established convention (see
/// test/features/schedule/presentation/cubit/setting_schedule_cubit_test.dart)
/// of small in-memory fakes rather than mocktail/bloc_test, which are not in
/// pubspec.yaml.

/// Captures the onInside/onOutside callbacks passed to [start] so the test
/// can invoke them on demand, standing in for real Geolocator position
/// updates.
class FakeLocationWatchService implements LocationWatchService {
  int startCount = 0;
  int stopCount = 0;
  double? lastCenterLat;
  double? lastCenterLng;
  int? lastRadiusMeters;

  void Function()? _onInside;
  void Function()? _onOutside;

  @override
  void start({
    required double centerLat,
    required double centerLng,
    required int radiusMeters,
    required void Function() onInside,
    required void Function() onOutside,
  }) {
    startCount++;
    lastCenterLat = centerLat;
    lastCenterLng = centerLng;
    lastRadiusMeters = radiusMeters;
    _onInside = onInside;
    _onOutside = onOutside;
  }

  @override
  void stop() {
    stopCount++;
  }

  /// Simulates the device entering the work-location radius, using
  /// whichever `onInside` was registered by the most recent [start] call.
  void triggerInside() => _onInside?.call();

  /// Simulates the device leaving the work-location radius, using whichever
  /// `onOutside` was registered by the most recent [start] call.
  void triggerOutside() => _onOutside?.call();
}

class FakeLocationLogRepository implements LocationLogRepository {
  FakeLocationLogRepository({this.enabled = true});

  bool enabled;
  final List<LocationLog> arrivals = [];
  final List<LocationLog> departures = [];

  @override
  Future<bool> isEnabled() async => enabled;

  @override
  Future<void> setEnabled(bool value) async => enabled = value;

  @override
  Future<LocationLog> recordArrival({
    required DateTime at,
    double? lat,
    double? lng,
  }) async {
    final log = LocationLog(
      dayKey: _dayKey(at),
      type: LocationLogType.arrival,
      timestamp: at,
      latitude: lat,
      longitude: lng,
    );
    arrivals.add(log);
    return log;
  }

  @override
  Future<LocationLog> recordDeparture({
    required DateTime at,
    double? lat,
    double? lng,
  }) async {
    final log = LocationLog(
      dayKey: _dayKey(at),
      type: LocationLogType.departure,
      timestamp: at,
      latitude: lat,
      longitude: lng,
    );
    departures.add(log);
    return log;
  }

  @override
  Future<List<LocationLog>> getLogsForDay(DateTime day) async => [];

  @override
  Future<List<LocationLog>> getLogsForDayRange({
    required DateTime start,
    required DateTime end,
  }) async => [];

  @override
  Future<List<LocationLog>> getRecentLogs({int limit = 20}) async => [];

  @override
  Stream<List<LocationLog>> watchLogsChanges() => const Stream.empty();

  int _dayKey(DateTime d) => d.year * 10000 + d.month * 100 + d.day;
}

class FakeAttendanceRepository implements AttendanceRepository {
  FakeAttendanceRepository({Attendance? initial}) : _current = initial;

  Attendance? _current;
  final StreamController<Attendance?> _controller =
      StreamController<Attendance?>.broadcast();

  int checkInCallCount = 0;
  int checkOutCallCount = 0;
  Object? checkInError;
  Object? checkOutError;

  Attendance? get current => _current;

  /// Directly overwrites in-memory state without going through [checkIn]/
  /// [checkOut] — used to simulate attendance changes made through some
  /// other path (e.g. a manual edit from the Calendar tab) without
  /// incrementing this fake's call counters.
  void setCurrent(Attendance? attendance) => _current = attendance;

  @override
  Future<Attendance?> getTodayAttendance() async => _current;

  @override
  Future<Attendance> checkIn(DateTime time) async {
    checkInCallCount++;
    final error = checkInError;
    if (error != null) throw error;
    _current = (_current ?? _blank()).copyWith(checkIn: time);
    _controller.add(_current);
    return _current!;
  }

  @override
  Future<Attendance> checkOut(DateTime time) async {
    checkOutCallCount++;
    final error = checkOutError;
    if (error != null) throw error;
    _current = (_current ?? _blank()).copyWith(checkOut: time);
    _controller.add(_current);
    return _current!;
  }

  @override
  Stream<Attendance?> watchAttendanceChanges() => _controller.stream;

  @override
  Future<List<Attendance>> getRecentAttendances({int limit = 10}) async => [];

  @override
  Future<Map<int, Attendance>> getAttendanceForMonth({
    required int year,
    required int month,
  }) async => {};

  @override
  void clearTodayAttendance() => _current = null;

  Attendance _blank() => Attendance(
    workDate: DateTime.now(),
    dayKey: 0,
    expectedStartMinute: 0,
    expectedEndMinute: 0,
    lunchMinutes: 0,
    expectedLunchStartMinute: 0,
  );
}

class FakeWorkScheduleRepository implements WorkScheduleRepository {
  FakeWorkScheduleRepository({required this.schedule, this.workingDay = true});

  WorkSchedule? schedule;
  bool workingDay;

  @override
  Future<WorkSchedule?> getCurrentActiveSchedule() async => schedule;

  @override
  Future<void> saveWorkSchedule(WorkSchedule workSchedule) async {
    schedule = workSchedule;
  }

  @override
  bool isWorkingDay(DateTime dateTime) => workingDay;
}

/// Only [getSettings] is exercised by [LocationWatchOrchestrator]; every
/// other member throws if accidentally called by production code under
/// test, so a test would fail loudly instead of silently passing.
class FakeLeaveReminderRepository implements LeaveReminderRepository {
  FakeLeaveReminderRepository({required this.settings});

  LeaveReminderSettings settings;

  @override
  Future<LeaveReminderSettings> getSettings() async => settings;

  @override
  Future<EnableLeaveReminderResult> setEnabled(bool enabled) =>
      throw UnimplementedError();

  @override
  Future<LeaveReminderSettings> setHomeLocation(GeoPoint point) =>
      throw UnimplementedError();

  @override
  Future<LeaveReminderSettings> setWorkLocation(GeoPoint point) =>
      throw UnimplementedError();

  @override
  Future<LeaveReminderSettings> setHeadsUpLeadMinutes(int minutes) =>
      throw UnimplementedError();

  @override
  Future<LeaveReminderSettings> setWorkRadiusMeters(int meters) =>
      throw UnimplementedError();

  @override
  Future<void> scheduleTodayReminders() => throw UnimplementedError();

  @override
  Future<LeaveReminderSettings> addWaypoint(GeoPoint point) =>
      throw UnimplementedError();

  @override
  Future<LeaveReminderSettings> removeWaypointAt(int index) =>
      throw UnimplementedError();

  @override
  Future<LeaveReminderSettings> setWaypointEnabledAt(
    int index,
    bool enabled,
  ) => throw UnimplementedError();

  @override
  Future<LeaveReminderSettings> setWaypointLocationAt(
    int index,
    GeoPoint point,
  ) => throw UnimplementedError();

  @override
  Future<int?> getAverageCommuteMinutes() => throw UnimplementedError();

  @override
  Future<DateTime?> getLeaveTime() => throw UnimplementedError();

  @override
  Future<DateTime?> getEstimatedArrivalTime() => throw UnimplementedError();

  @override
  Future<LeaveReminderPromptTrigger?> checkIntroPromptTrigger() =>
      throw UnimplementedError();

  @override
  Future<TomorrowPreview?> getTomorrowPreview() => throw UnimplementedError();

  @override
  Future<List<NotificationLogEntry>> getNotificationLog() =>
      throw UnimplementedError();
}

/// [Workmanager]'s default platform instance throws `UnimplementedError` for
/// every method when no platform-specific plugin package is registered
/// (there's no real Android/iOS host in a `flutter test` run). Production
/// code (`_handleDepartureDetected`/`_scheduleMidnightStop`, via
/// `scheduleNextArrivalWatch`) calls `Workmanager()` unconditionally on
/// every path, so exercising those code paths at all requires swapping in a
/// fake platform implementation. This uses `workmanager`'s own official
/// plugin_platform_interface test seam (`WorkmanagerPlatform.instance`
/// setter) — already a transitive dependency of `workmanager`, itself
/// already a direct dependency — rather than adding any new test package.
class FakeWorkmanagerPlatform extends WorkmanagerPlatform {
  final List<String> calls = [];

  @override
  Future<void> cancelByUniqueName(String uniqueName) async {
    calls.add('cancelByUniqueName');
  }

  @override
  Future<void> registerOneOffTask(
    String uniqueName,
    String taskName, {
    Map<String, dynamic>? inputData,
    Duration? initialDelay,
    Constraints? constraints,
    ExistingWorkPolicy? existingWorkPolicy,
    BackoffPolicy? backoffPolicy,
    Duration? backoffPolicyDelay,
    String? tag,
    OutOfQuotaPolicy? outOfQuotaPolicy,
  }) async {
    calls.add('registerOneOffTask');
  }
}

/// A schedule whose arrival-watch cutoff (`endMinuteOfDay` minus 60 minutes)
/// already lies in the past relative to "now" — this drives
/// `startArrivalWatchIfScheduled`'s `delay.isNegative ? Duration.zero :
/// delay` clamp down to `Duration.zero`, letting `_cutoffTimer` fire
/// deterministically without a real wait or a fake_async/clock dependency.
WorkSchedule _scheduleWithCutoffAlreadyDue() {
  final now = DateTime.now();
  return WorkSchedule(
    startMinuteOfDay: 0,
    endMinuteOfDay: now.hour * 60 + now.minute,
    lunchMinutes: 0,
    lunchStartMinuteOfDay: 0,
    reminderMinutes: 0,
  );
}

/// A schedule whose cutoff is hours away, so `_cutoffTimer` never fires
/// during a test — used whenever the cutoff path would otherwise race with
/// the behavior actually under test.
WorkSchedule _scheduleWithCutoffFarAway() {
  final now = DateTime.now();
  return WorkSchedule(
    startMinuteOfDay: 0,
    endMinuteOfDay: now.hour * 60 + now.minute + 300,
    lunchMinutes: 0,
    lunchStartMinuteOfDay: 0,
    reminderMinutes: 0,
  );
}

LeaveReminderSettings _settingsWithWork() => const LeaveReminderSettings(
  work: GeoPoint(latitude: 1.23, longitude: 4.56),
  workRadiusMeters: 150,
);

void main() {
  setUp(() {
    WorkmanagerPlatform.instance = FakeWorkmanagerPlatform();
  });

  group('startArrivalWatchIfScheduled — isolate-keepalive completer', () {
    test(
      'does not complete merely because the watch was started',
      () async {
        final locationWatchService = FakeLocationWatchService();
        final orchestrator = LocationWatchOrchestrator(
          locationWatchService,
          FakeLocationLogRepository(),
          FakeAttendanceRepository(),
          FakeWorkScheduleRepository(schedule: _scheduleWithCutoffFarAway()),
          FakeLeaveReminderRepository(settings: _settingsWithWork()),
        );

        var completed = false;
        final future = orchestrator.startArrivalWatchIfScheduled();
        unawaited(future.then((_) => completed = true));

        await pumpEventQueue();

        // The watch was actually started...
        expect(locationWatchService.startCount, 1);
        // ...but the awaited Future backing the Workmanager callback is
        // still pending — i.e. the isolate is being kept alive. Before the
        // fix, this method returned almost immediately after `start()`,
        // which would have let `completed` flip to true here.
        expect(completed, isFalse);
      },
    );

    test(
      'cutoff timer completes the future when neither arrival nor manual '
      'check-in is observed',
      () async {
        final locationWatchService = FakeLocationWatchService();
        final attendanceRepository = FakeAttendanceRepository();
        final orchestrator = LocationWatchOrchestrator(
          locationWatchService,
          FakeLocationLogRepository(),
          attendanceRepository,
          FakeWorkScheduleRepository(schedule: _scheduleWithCutoffAlreadyDue()),
          FakeLeaveReminderRepository(settings: _settingsWithWork()),
        );

        var completed = false;
        final future = orchestrator.startArrivalWatchIfScheduled();
        unawaited(future.then((_) => completed = true));

        await pumpEventQueue();

        expect(completed, isTrue);
        expect(locationWatchService.stopCount, greaterThanOrEqualTo(1));
        expect(attendanceRepository.checkInCallCount, 0);

        // The returned future itself resolves without hanging.
        await future.timeout(const Duration(seconds: 1));
      },
    );

    test(
      'manual check-in observed via the attendance stream also transitions '
      'to the departure watch (and does not complete early)',
      () async {
        final locationWatchService = FakeLocationWatchService();
        final attendanceRepository = FakeAttendanceRepository();
        final orchestrator = LocationWatchOrchestrator(
          locationWatchService,
          FakeLocationLogRepository(),
          attendanceRepository,
          FakeWorkScheduleRepository(schedule: _scheduleWithCutoffFarAway()),
          FakeLeaveReminderRepository(settings: _settingsWithWork()),
        );

        var completed = false;
        final future = orchestrator.startArrivalWatchIfScheduled();
        unawaited(future.then((_) => completed = true));
        await pumpEventQueue();
        expect(locationWatchService.startCount, 1);

        // User manually checks in from elsewhere in the app while the
        // arrival watch is running.
        await attendanceRepository.checkIn(DateTime.now());
        await pumpEventQueue();

        // Guards cancelled, departure watch started — but still no
        // terminal event, so still pending.
        expect(locationWatchService.startCount, 2);
        expect(completed, isFalse);
      },
    );
  });

  group('arrival -> departure sequence', () {
    test(
      'arrival then departure completes the future and checks in/out '
      'exactly once each',
      () async {
        final locationWatchService = FakeLocationWatchService();
        final locationLogRepository = FakeLocationLogRepository();
        final attendanceRepository = FakeAttendanceRepository();
        final orchestrator = LocationWatchOrchestrator(
          locationWatchService,
          locationLogRepository,
          attendanceRepository,
          FakeWorkScheduleRepository(schedule: _scheduleWithCutoffFarAway()),
          FakeLeaveReminderRepository(settings: _settingsWithWork()),
        );

        var completed = false;
        final future = orchestrator.startArrivalWatchIfScheduled();
        unawaited(future.then((_) => completed = true));
        await pumpEventQueue();
        expect(locationWatchService.startCount, 1);

        locationWatchService.triggerInside();
        await pumpEventQueue();

        expect(attendanceRepository.checkInCallCount, 1);
        expect(locationLogRepository.arrivals, hasLength(1));
        // Restarted for the departure watch.
        expect(locationWatchService.startCount, 2);
        expect(completed, isFalse);

        locationWatchService.triggerOutside();
        await pumpEventQueue();

        expect(attendanceRepository.checkOutCallCount, 1);
        expect(locationLogRepository.departures, hasLength(1));
        expect(completed, isTrue);

        await future.timeout(const Duration(seconds: 1));
      },
    );

    test(
      'arrival detected does not check in again if already checked in '
      '(idempotent)',
      () async {
        final now = DateTime.now();
        final locationWatchService = FakeLocationWatchService();
        final attendanceRepository = FakeAttendanceRepository(
          initial: Attendance(
            workDate: now,
            dayKey: 0,
            checkIn: now.subtract(const Duration(minutes: 5)),
            expectedStartMinute: 0,
            expectedEndMinute: 0,
            lunchMinutes: 0,
            expectedLunchStartMinute: 0,
          ),
        );
        final orchestrator = LocationWatchOrchestrator(
          locationWatchService,
          FakeLocationLogRepository(),
          attendanceRepository,
          FakeWorkScheduleRepository(schedule: _scheduleWithCutoffFarAway()),
          FakeLeaveReminderRepository(settings: _settingsWithWork()),
        );

        unawaited(orchestrator.startArrivalWatchIfScheduled());
        await pumpEventQueue();

        locationWatchService.triggerInside();
        await pumpEventQueue();

        expect(attendanceRepository.checkInCallCount, 0);
        // Still transitions to the departure watch regardless.
        expect(locationWatchService.startCount, 2);
      },
    );

    test(
      'departure detected does not check out again if already checked out '
      '(idempotent)',
      () async {
        final locationWatchService = FakeLocationWatchService();
        final attendanceRepository = FakeAttendanceRepository();
        final orchestrator = LocationWatchOrchestrator(
          locationWatchService,
          FakeLocationLogRepository(),
          attendanceRepository,
          FakeWorkScheduleRepository(schedule: _scheduleWithCutoffFarAway()),
          FakeLeaveReminderRepository(settings: _settingsWithWork()),
        );

        unawaited(orchestrator.startArrivalWatchIfScheduled());
        await pumpEventQueue();
        locationWatchService.triggerInside();
        await pumpEventQueue();
        expect(attendanceRepository.checkInCallCount, 1);

        // Simulate a checkout already recorded through some other path
        // (e.g. a manual edit) while the departure watch is running.
        final withCheckout = attendanceRepository.current!.copyWith(
          checkOut: DateTime.now(),
        );
        attendanceRepository.setCurrent(withCheckout);

        locationWatchService.triggerOutside();
        await pumpEventQueue();

        expect(attendanceRepository.checkOutCallCount, 0);
      },
    );

    test(
      'departure detected skips check-out (but still completes the watch) '
      'if attendance was cleared out from under it',
      () async {
        final locationWatchService = FakeLocationWatchService();
        final attendanceRepository = FakeAttendanceRepository();
        final orchestrator = LocationWatchOrchestrator(
          locationWatchService,
          FakeLocationLogRepository(),
          attendanceRepository,
          FakeWorkScheduleRepository(schedule: _scheduleWithCutoffFarAway()),
          FakeLeaveReminderRepository(settings: _settingsWithWork()),
        );

        var completed = false;
        final future = orchestrator.startArrivalWatchIfScheduled();
        unawaited(future.then((_) => completed = true));
        await pumpEventQueue();
        locationWatchService.triggerInside();
        await pumpEventQueue();
        expect(attendanceRepository.checkInCallCount, 1);

        // e.g. the user clears today's attendance from the Calendar tab
        // while the departure watch is still running in the background.
        attendanceRepository.clearTodayAttendance();

        locationWatchService.triggerOutside();
        await pumpEventQueue();

        expect(attendanceRepository.checkOutCallCount, 0);
        // The watch still finalizes/completes even though check-out was
        // skipped.
        expect(completed, isTrue);
      },
    );

    test(
      'a StateError from checkIn is swallowed without crashing the watch',
      () async {
        final locationWatchService = FakeLocationWatchService();
        final attendanceRepository = FakeAttendanceRepository()
          ..checkInError = StateError('boundary-timing edge case');
        final orchestrator = LocationWatchOrchestrator(
          locationWatchService,
          FakeLocationLogRepository(),
          attendanceRepository,
          FakeWorkScheduleRepository(schedule: _scheduleWithCutoffFarAway()),
          FakeLeaveReminderRepository(settings: _settingsWithWork()),
        );

        unawaited(orchestrator.startArrivalWatchIfScheduled());
        await pumpEventQueue();

        locationWatchService.triggerInside();
        await pumpEventQueue();

        // No uncaught exception reached the test zone (this test would
        // otherwise fail with an unhandled error), and the watch still
        // proceeded to the departure phase.
        expect(attendanceRepository.checkInCallCount, 1);
        expect(locationWatchService.startCount, 2);
      },
    );

    test(
      'a StateError from checkOut is swallowed and the watch still '
      'completes',
      () async {
        final locationWatchService = FakeLocationWatchService();
        final attendanceRepository = FakeAttendanceRepository()
          ..checkOutError = StateError('boundary-timing edge case');
        final orchestrator = LocationWatchOrchestrator(
          locationWatchService,
          FakeLocationLogRepository(),
          attendanceRepository,
          FakeWorkScheduleRepository(schedule: _scheduleWithCutoffFarAway()),
          FakeLeaveReminderRepository(settings: _settingsWithWork()),
        );

        var completed = false;
        final future = orchestrator.startArrivalWatchIfScheduled();
        unawaited(future.then((_) => completed = true));
        await pumpEventQueue();
        locationWatchService.triggerInside();
        await pumpEventQueue();
        expect(attendanceRepository.checkInCallCount, 1);

        locationWatchService.triggerOutside();
        await pumpEventQueue();

        expect(attendanceRepository.checkOutCallCount, 1);
        // No uncaught exception, and the completer still fires.
        expect(completed, isTrue);

        await future.timeout(const Duration(seconds: 1));
      },
    );
  });
}
