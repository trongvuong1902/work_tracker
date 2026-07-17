import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:work_tracker/core/notifications/notification_service.dart';
import 'package:work_tracker/features/attendance/domain/attendance_repository.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';
import 'package:work_tracker/features/checkout_reminder/checkout_reminder_constants.dart';
import 'package:work_tracker/features/checkout_reminder/data/checkout_reminder_datasource.dart';
import 'package:work_tracker/features/checkout_reminder/domain/checkout_reminder_repository.dart';
import 'package:work_tracker/features/checkout_reminder/domain/checkout_reminder_repository_impl.dart';
import 'package:work_tracker/features/checkout_reminder/domain/models/checkout_reminder_settings.dart';

/// Minimal hand-written fakes, matching this project's established
/// convention (see setting_schedule_cubit_test.dart): no mocktail/bloc_test
/// dependency is present in pubspec.yaml yet, and these interfaces are small
/// enough that fakes are straightforward and don't require adding one.
class FakeNotificationService implements NotificationService {
  bool permissionGranted = true;

  final List<({int id, DateTime scheduledDate})> scheduledCalls = [];
  final List<int> cancelledIds = [];

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> requestPermission() async => permissionGranted;

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

class FakeAttendanceRepository implements AttendanceRepository {
  FakeAttendanceRepository({this.todayAttendance});

  Attendance? todayAttendance;
  final _controller = StreamController<Attendance?>.broadcast();

  @override
  Future<Attendance?> getTodayAttendance() async => todayAttendance;

  @override
  Stream<Attendance?> watchAttendanceChanges() => _controller.stream;

  @override
  Future<Attendance> checkIn(DateTime time) => throw UnimplementedError();

  @override
  Future<Attendance> checkOut(DateTime time) => throw UnimplementedError();

  @override
  Future<List<Attendance>> getRecentAttendances({int limit = 10}) async => [];

  @override
  Future<Map<int, Attendance>> getAttendanceForMonth({
    required int year,
    required int month,
  }) async => {};

  @override
  void clearTodayAttendance() {}
}

class FakeCheckoutReminderDatasource implements CheckoutReminderDatasource {
  FakeCheckoutReminderDatasource({CheckoutReminderSettings? initial})
    : _settings = initial ?? const CheckoutReminderSettings();

  CheckoutReminderSettings _settings;

  @override
  Future<CheckoutReminderSettings> getSettings() async => _settings;

  @override
  Future<void> saveSettings(CheckoutReminderSettings settings) async {
    _settings = settings;
  }
}

/// Builds a today-dated [Attendance] row with sensible defaults, letting
/// tests override just the fields relevant to the checkout-reminder
/// computation.
Attendance buildAttendance({
  DateTime? workDate,
  DateTime? checkIn,
  // `checkIn` itself can't distinguish "not provided" from "explicitly
  // null" once it's a named nullable parameter, so a separate flag is used
  // for tests that need `checkIn` to actually be null on the built row.
  bool hasCheckIn = true,
  DateTime? checkOut,
  int expectedStartMinute = 540, // 09:00
  int expectedEndMinute = 1080, // 18:00
  int lateMinutes = 0,
}) {
  final date = workDate ?? DateTime(2026, 7, 17);
  final resolvedCheckIn = hasCheckIn
      ? (checkIn ?? date.add(const Duration(minutes: 540)))
      : null;
  return Attendance(
    workDate: date,
    dayKey: 20260717,
    checkIn: resolvedCheckIn,
    checkOut: checkOut,
    expectedStartMinute: expectedStartMinute,
    expectedEndMinute: expectedEndMinute,
    lunchMinutes: 60,
    expectedLunchStartMinute: 720,
    lateMinutes: lateMinutes,
  );
}

void main() {
  late FakeCheckoutReminderDatasource datasource;
  late FakeNotificationService notificationService;
  late FakeAttendanceRepository attendanceRepository;
  late CheckoutReminderRepositoryImpl repository;

  /// Builds the repository with reminders already enabled in the
  /// datasource, so calling [CheckoutReminderRepositoryImpl.setLeadMinutes]
  /// re-triggers `_evaluate()` against [attendanceRepository.todayAttendance]
  /// without going through the permission-request path exercised by
  /// `setEnabled(true)`.
  void setUpEnabledRepository({int leadMinutes = 15, Attendance? attendance}) {
    datasource = FakeCheckoutReminderDatasource(
      initial: CheckoutReminderSettings(
        enabled: true,
        leadMinutes: leadMinutes,
      ),
    );
    notificationService = FakeNotificationService();
    attendanceRepository = FakeAttendanceRepository(
      todayAttendance: attendance,
    );
    repository = CheckoutReminderRepositoryImpl(
      datasource,
      notificationService,
      attendanceRepository,
    );
  }

  group('_evaluate via setLeadMinutes — cancellation branches', () {
    test('no attendance -> cancels both notifications', () async {
      setUpEnabledRepository(attendance: null);

      await repository.setLeadMinutes(15);

      expect(
        notificationService.cancelledIds,
        containsAll([kCheckoutReminderNotificationId, kEndOfWorkNotificationId]),
      );
      expect(notificationService.scheduledCalls, isEmpty);
    });

    test('already checked out -> cancels both notifications', () async {
      final attendance = buildAttendance(
        checkOut: DateTime(2026, 7, 17, 18, 5),
      );
      setUpEnabledRepository(attendance: attendance);

      await repository.setLeadMinutes(15);

      expect(
        notificationService.cancelledIds,
        containsAll([kCheckoutReminderNotificationId, kEndOfWorkNotificationId]),
      );
      expect(notificationService.scheduledCalls, isEmpty);
    });

    test(
      'no check-in yet -> does nothing (no cancel/schedule calls) — '
      'documents that this branch differs from the other three guard '
      'branches, since nothing could have been scheduled for a row that '
      'never had a check-in in the first place',
      () async {
        final attendance = buildAttendance(hasCheckIn: false);
        setUpEnabledRepository(attendance: attendance);

        await repository.setLeadMinutes(15);

        expect(notificationService.cancelledIds, isEmpty);
        expect(notificationService.scheduledCalls, isEmpty);
      },
    );

    test(
      'invalid schedule (expectedEndMinute <= expectedStartMinute) -> '
      'cancels both notifications',
      () async {
        final attendance = buildAttendance(
          expectedStartMinute: 540,
          expectedEndMinute: 540, // equal -> invalid
        );
        setUpEnabledRepository(attendance: attendance);

        await repository.setLeadMinutes(15);

        expect(
          notificationService.cancelledIds,
          containsAll([
            kCheckoutReminderNotificationId,
            kEndOfWorkNotificationId,
          ]),
        );
        expect(notificationService.scheduledCalls, isEmpty);
      },
    );
  });

  group('_evaluate via setLeadMinutes — valid attendance scheduling', () {
    test(
      'schedules checkout-reminder at shifted-end-minus-lead and '
      'end-of-work at the shifted end time, both in the future',
      () async {
        // Anchor everything off "now" so the computed fire times land a
        // safe distance in the future/past regardless of when the test
        // suite runs.
        final now = DateTime.now();
        final workDate = DateTime(now.year, now.month, now.day);
        final minutesSinceMidnight = now.difference(workDate).inMinutes;

        const lateMinutes = 10;
        const leadMinutes = 5;
        // shiftedEnd = expectedEndMinute + lateMinutes = now + 30 minutes.
        final expectedEndMinute = minutesSinceMidnight + 30 - lateMinutes;

        final attendance = buildAttendance(
          workDate: workDate,
          expectedStartMinute: 0,
          expectedEndMinute: expectedEndMinute,
          lateMinutes: lateMinutes,
        );
        setUpEnabledRepository(leadMinutes: leadMinutes, attendance: attendance);

        await repository.setLeadMinutes(leadMinutes);

        final expectedShiftedEnd = workDate.add(
          Duration(minutes: expectedEndMinute + lateMinutes),
        );
        final expectedFireAt = expectedShiftedEnd.subtract(
          const Duration(minutes: leadMinutes),
        );

        expect(notificationService.cancelledIds, isEmpty);
        expect(notificationService.scheduledCalls, hasLength(2));

        final checkoutCall = notificationService.scheduledCalls.firstWhere(
          (c) => c.id == kCheckoutReminderNotificationId,
        );
        expect(checkoutCall.scheduledDate, expectedFireAt);

        final endOfWorkCall = notificationService.scheduledCalls.firstWhere(
          (c) => c.id == kEndOfWorkNotificationId,
        );
        expect(endOfWorkCall.scheduledDate, expectedShiftedEnd);
      },
    );

    test(
      'checkout-reminder fire time already past -> cancels it, but still '
      'schedules end-of-work when its own (later) fire time is still in '
      'the future',
      () async {
        final now = DateTime.now();
        final workDate = DateTime(now.year, now.month, now.day);
        final minutesSinceMidnight = now.difference(workDate).inMinutes;

        // shiftedEnd = now + 10 minutes (future).
        // fireAt = shiftedEnd - 20 lead minutes = now - 10 minutes (past).
        const leadMinutes = 20;
        final expectedEndMinute = minutesSinceMidnight + 10;

        final attendance = buildAttendance(
          workDate: workDate,
          expectedStartMinute: 0,
          expectedEndMinute: expectedEndMinute,
          lateMinutes: 0,
        );
        setUpEnabledRepository(leadMinutes: leadMinutes, attendance: attendance);

        await repository.setLeadMinutes(leadMinutes);

        expect(
          notificationService.cancelledIds,
          [kCheckoutReminderNotificationId],
        );
        expect(
          notificationService.scheduledCalls.map((c) => c.id),
          [kEndOfWorkNotificationId],
        );
      },
    );

    test(
      'end-of-work fire time already past -> cancels both notifications '
      '(the checkout-reminder fire time is always <= the end-of-work fire '
      'time, since it is that same instant minus a non-negative lead, so '
      'end-of-work being past implies checkout-reminder is past too)',
      () async {
        final now = DateTime.now();
        final workDate = DateTime(now.year, now.month, now.day);
        final minutesSinceMidnight = now.difference(workDate).inMinutes;

        const leadMinutes = 5;
        // shiftedEnd = now - 30 minutes (past).
        final expectedEndMinute = minutesSinceMidnight - 30;

        final attendance = buildAttendance(
          workDate: workDate,
          expectedStartMinute: 0,
          expectedEndMinute: expectedEndMinute,
          lateMinutes: 0,
        );
        setUpEnabledRepository(leadMinutes: leadMinutes, attendance: attendance);

        await repository.setLeadMinutes(leadMinutes);

        expect(
          notificationService.cancelledIds,
          containsAll([
            kCheckoutReminderNotificationId,
            kEndOfWorkNotificationId,
          ]),
        );
        expect(notificationService.scheduledCalls, isEmpty);
      },
    );
  });

  group('setEnabled(false)', () {
    test('cancels both notification ids', () async {
      setUpEnabledRepository(attendance: buildAttendance());

      final result = await repository.setEnabled(false);

      expect(result, EnableCheckoutReminderResult.success);
      expect(
        notificationService.cancelledIds,
        containsAll([
          kCheckoutReminderNotificationId,
          kEndOfWorkNotificationId,
        ]),
      );
      final settings = await datasource.getSettings();
      expect(settings.enabled, isFalse);
    });
  });
}
