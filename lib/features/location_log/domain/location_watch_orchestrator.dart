import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:workmanager/workmanager.dart';

import '../../attendance/domain/attendance_repository.dart';
import '../../attendance/domain/models/attendance.dart';
import '../../leave_reminder/domain/leave_reminder_repository.dart';
import '../../schedule/domain/work_schedule_repository.dart';
import '../data/location_watch_service.dart';
import '../location_log_constants.dart';
import 'location_log_repository.dart';

/// Owns the arrival-watch -> departure-watch state machine: starts a bounded
/// [LocationWatchService] window ~30 minutes before the scheduled check-in
/// time, auto-assigns check-in/check-out on first arrival/departure, and
/// reschedules the next day's Workmanager trigger once the departure watch
/// ends. Registered `@singleton` so GetIt keeps exactly one instance — its
/// internal subscription/timer state must never be duplicated.
@singleton
class LocationWatchOrchestrator {
  final LocationWatchService _locationWatchService;
  final LocationLogRepository _locationLogRepository;
  final AttendanceRepository _attendanceRepository;
  final WorkScheduleRepository _workScheduleRepository;
  final LeaveReminderRepository _leaveReminderRepository;

  LocationWatchOrchestrator(
    this._locationWatchService,
    this._locationLogRepository,
    this._attendanceRepository,
    this._workScheduleRepository,
    this._leaveReminderRepository,
  );

  /// How long before the scheduled start time the arrival watch begins.
  static const Duration _arrivalLeadTime = Duration(minutes: 30);

  /// How long before the scheduled end time the arrival watch gives up if
  /// neither arrival nor a manual check-in was observed.
  static const Duration _arrivalCutoffLeadTime = Duration(minutes: 60);

  StreamSubscription<Attendance?>? _attendanceSubscription;
  Timer? _cutoffTimer;
  Timer? _midnightTimer;

  // Keeps [startArrivalWatchIfScheduled]'s returned Future unresolved until
  // the watch's terminal event fires. This method runs inside the
  // Workmanager background isolate, which is torn down the instant its
  // callback returns — without this, the watch (and the Geolocator stream
  // subscription/timers backing it) would be destroyed within moments of
  // being started, since starting the watch is near-instantaneous but
  // detecting arrival/departure can take anywhere from minutes to hours.
  // Null/no-op when the watch is resumed from the main isolate instead (see
  // [resumeIfNeeded]), which isn't at risk of being torn down this way.
  Completer<void>? _watchCompleter;

  // The work location last used to start a watch — the position stream
  // callbacks carry no position of their own, so this is the best available
  // coordinate to attach to the resulting log entry (it's guaranteed to be
  // within the configured radius of it by definition of the callback firing).
  double? _centerLat;
  double? _centerLng;

  /// Starts the bounded arrival watch, if today qualifies. Called by the
  /// Workmanager trigger ~30 minutes before the scheduled check-in time.
  Future<void> startArrivalWatchIfScheduled() async {
    if (!await _locationLogRepository.isEnabled()) return;
    if (!_workScheduleRepository.isWorkingDay(DateTime.now())) return;

    final settings = await _leaveReminderRepository.getSettings();
    final work = settings.work;
    if (work == null) return;

    final schedule = await _workScheduleRepository.getCurrentActiveSchedule();
    if (schedule == null) return;

    // Re-entrancy guard: if a watch is already active (e.g. an OS-fired
    // trigger overlapping the resumeIfNeeded path), release its stream
    // subscription, cutoff timer and suspended completer before starting a
    // fresh one. This is a never-disposed @singleton, so a duplicated
    // subscription/timer would leak for the whole app/isolate lifetime.
    _cancelArrivalWatchGuards();
    _completeWatch();

    _centerLat = work.latitude;
    _centerLng = work.longitude;

    final completer = Completer<void>();
    _watchCompleter = completer;

    _locationWatchService.start(
      centerLat: work.latitude,
      centerLng: work.longitude,
      radiusMeters: settings.workRadiusMeters,
      onInside: () {
        unawaited(_handleArrivalDetected());
      },
      onOutside: () {}, // not relevant during the arrival watch.
    );

    _attendanceSubscription = _attendanceRepository.watchAttendanceChanges().listen((
      attendance,
    ) {
      if (attendance?.checkIn != null) {
        _cancelArrivalWatchGuards();
        unawaited(_transitionToDepartureWatch());
      }
    });

    final cutoff = _dateTimeAt(
      DateTime.now(),
      schedule.endMinuteOfDay,
    ).subtract(_arrivalCutoffLeadTime);
    final delay = cutoff.difference(DateTime.now());
    _cutoffTimer = Timer(delay.isNegative ? Duration.zero : delay, () {
      _locationWatchService.stop();
      _cancelArrivalWatchGuards();
      // No log, nothing scheduled again — wait for tomorrow's trigger.
      _completeWatch();
    });

    await completer.future;
  }

  /// Completes [_watchCompleter] (if any) so a suspended
  /// [startArrivalWatchIfScheduled] call returns, letting the Workmanager
  /// callback that's awaiting it proceed to tear down the isolate. Safe
  /// no-op when called from the main-isolate resume path
  /// ([resumeIfNeeded]/[_transitionToDepartureWatch] via that path), where
  /// no completer was ever set.
  void _completeWatch() {
    final completer = _watchCompleter;
    if (completer != null && !completer.isCompleted) {
      completer.complete();
    }
    _watchCompleter = null;
  }

  /// Resumes a departure watch already in progress after a process restart
  /// (e.g. the app was killed mid-day while checked in).
  Future<void> resumeIfNeeded() async {
    if (!await _locationLogRepository.isEnabled()) return;

    final attendance = await _attendanceRepository.getTodayAttendance();
    if (attendance != null &&
        attendance.checkIn != null &&
        attendance.checkOut == null) {
      await _transitionToDepartureWatch();
    }
  }

  /// Schedules the daily one-off Workmanager task that fires
  /// [startArrivalWatchIfScheduled] ~30 minutes before the next scheduled
  /// check-in time. No-ops (cancelling any pending task) if the feature is
  /// disabled, no work location is set, or the computed trigger date isn't a
  /// working day.
  Future<void> scheduleNextArrivalWatch() async {
    if (!await _locationLogRepository.isEnabled()) {
      await Workmanager().cancelByUniqueName(kLocationWatchWorkmanagerTaskName);
      return;
    }

    final settings = await _leaveReminderRepository.getSettings();
    if (settings.work == null) {
      await Workmanager().cancelByUniqueName(kLocationWatchWorkmanagerTaskName);
      return;
    }

    final schedule = await _workScheduleRepository.getCurrentActiveSchedule();
    if (schedule == null) {
      await Workmanager().cancelByUniqueName(kLocationWatchWorkmanagerTaskName);
      return;
    }

    var triggerDate = DateTime.now();
    var triggerTime = _dateTimeAt(
      triggerDate,
      schedule.startMinuteOfDay,
    ).subtract(_arrivalLeadTime);
    if (!triggerTime.isAfter(DateTime.now())) {
      triggerDate = triggerDate.add(const Duration(days: 1));
      triggerTime = _dateTimeAt(
        triggerDate,
        schedule.startMinuteOfDay,
      ).subtract(_arrivalLeadTime);
    }

    if (!_workScheduleRepository.isWorkingDay(triggerDate)) {
      await Workmanager().cancelByUniqueName(kLocationWatchWorkmanagerTaskName);
      return;
    }

    await Workmanager().registerOneOffTask(
      kLocationWatchWorkmanagerTaskName,
      kLocationWatchWorkmanagerTaskName,
      initialDelay: triggerTime.difference(DateTime.now()),
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }

  Future<void> _handleArrivalDetected() async {
    _cancelArrivalWatchGuards();

    // Captured once so the log entry and any resulting check-in share the
    // exact same timestamp — the Location Activity UI matches a log row to
    // its attendance record by timestamp equality.
    final now = DateTime.now();
    await _locationLogRepository.recordArrival(
      at: now,
      lat: _centerLat,
      lng: _centerLng,
    );

    try {
      final attendance = await _attendanceRepository.getTodayAttendance();
      if (attendance == null || attendance.checkIn == null) {
        await _attendanceRepository.checkIn(now);
      }
    } on StateError {
      // Boundary-timing edge case — never let this crash the watch.
    }

    await _transitionToDepartureWatch();
  }

  Future<void> _transitionToDepartureWatch() async {
    final settings = await _leaveReminderRepository.getSettings();
    final work = settings.work;
    if (work == null) return;

    _centerLat = work.latitude;
    _centerLng = work.longitude;

    _locationWatchService.start(
      centerLat: work.latitude,
      centerLng: work.longitude,
      radiusMeters: settings.workRadiusMeters,
      onInside: () {}, // not relevant during the departure watch.
      onOutside: () {
        unawaited(_handleDepartureDetected());
      },
    );

    _scheduleMidnightStop();
  }

  Future<void> _handleDepartureDetected() async {
    _midnightTimer?.cancel();
    _midnightTimer = null;

    // Captured once — see the matching comment in [_handleArrivalDetected].
    final now = DateTime.now();
    await _locationLogRepository.recordDeparture(
      at: now,
      lat: _centerLat,
      lng: _centerLng,
    );

    try {
      final attendance = await _attendanceRepository.getTodayAttendance();
      if (attendance != null &&
          attendance.checkIn != null &&
          attendance.checkOut == null) {
        await _attendanceRepository.checkOut(now);
      }
    } on StateError {
      // Boundary-timing edge case — never let this crash the watch.
    }

    // Single-departure design — stop, don't restart watching today.
    _locationWatchService.stop();
    await scheduleNextArrivalWatch();
    _completeWatch();
  }

  /// Stops the departure watch at the upcoming local midnight if departure
  /// was never detected, so it never bleeds into the next day.
  void _scheduleMidnightStop() {
    _midnightTimer?.cancel();
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    _midnightTimer = Timer(nextMidnight.difference(now), () {
      _locationWatchService.stop();
      _midnightTimer = null;
      unawaited(scheduleNextArrivalWatch());
      _completeWatch();
    });
  }

  void _cancelArrivalWatchGuards() {
    _cutoffTimer?.cancel();
    _cutoffTimer = null;
    _attendanceSubscription?.cancel();
    _attendanceSubscription = null;
  }

  DateTime _dateTimeAt(DateTime date, int minuteOfDay) => DateTime(
    date.year,
    date.month,
    date.day,
  ).add(Duration(minutes: minuteOfDay));
}
