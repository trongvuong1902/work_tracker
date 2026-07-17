import 'package:injectable/injectable.dart';

import '../../../core/notifications/notification_service.dart';
import '../../attendance/domain/attendance_repository.dart';
import '../../attendance/domain/models/attendance.dart';
import '../checkout_reminder_constants.dart';
import '../data/checkout_reminder_datasource.dart';
import 'checkout_reminder_repository.dart';
import 'models/checkout_reminder_settings.dart';

@LazySingleton(as: CheckoutReminderRepository)
class CheckoutReminderRepositoryImpl implements CheckoutReminderRepository {
  final CheckoutReminderDatasource _datasource;
  final NotificationService _notificationService;
  final AttendanceRepository _attendanceRepository;

  CheckoutReminderRepositoryImpl(
    this._datasource,
    this._notificationService,
    this._attendanceRepository,
  ) {
    // App-lifetime singleton (never disposed), so the subscription lives for
    // the whole app and is intentionally not retained/cancelled. Reminders are
    // (re)scheduled by _evaluate whenever attendance actually changes — i.e. at
    // check-in/out (which emit), and OS-scheduled notifications persist across
    // relaunches — so no per-launch re-evaluation is needed.
    _attendanceRepository.watchAttendanceChanges().listen(_evaluate);
  }

  @override
  Future<CheckoutReminderSettings> getSettings() => _datasource.getSettings();

  @override
  Future<EnableCheckoutReminderResult> setEnabled(bool enabled) async {
    if (enabled) {
      final granted = await _notificationService.requestPermission();
      if (!granted) {
        return EnableCheckoutReminderResult.notificationPermissionDenied;
      }

      final settings = await getSettings();
      await _datasource.saveSettings(settings.copyWith(enabled: true));
      await _evaluate(await _attendanceRepository.getTodayAttendance());
      return EnableCheckoutReminderResult.success;
    }

    await _notificationService.cancel(kCheckoutReminderNotificationId);
    await _notificationService.cancel(kEndOfWorkNotificationId);
    final settings = await getSettings();
    await _datasource.saveSettings(settings.copyWith(enabled: false));
    return EnableCheckoutReminderResult.success;
  }

  @override
  Future<CheckoutReminderSettings> setLeadMinutes(int minutes) async {
    final settings = await getSettings();
    final updated = settings.copyWith(leadMinutes: minutes);
    await _datasource.saveSettings(updated);
    await _evaluate(await _attendanceRepository.getTodayAttendance());
    return updated;
  }

  /// Schedules (or cancels) both the checkout-reminder and end-of-work
  /// notifications for the day's attendance row. The checkout reminder
  /// fires [settings.leadMinutes] before the user's real expected checkout
  /// time — the schedule's raw end time shifted forward by however late
  /// they checked in — not the raw schedule end time itself. The
  /// end-of-work notification fires exactly at that shifted expected
  /// checkout time, with no lead time subtracted.
  Future<void> _evaluate(Attendance? attendance) async {
    if (attendance == null || attendance.checkOut != null) {
      await _notificationService.cancel(kCheckoutReminderNotificationId);
      await _notificationService.cancel(kEndOfWorkNotificationId);
      return;
    }
    if (attendance.checkIn == null) return;

    final settings = await getSettings();
    if (!settings.enabled) return;

    if (attendance.expectedEndMinute <= attendance.expectedStartMinute) {
      await _notificationService.cancel(kCheckoutReminderNotificationId);
      await _notificationService.cancel(kEndOfWorkNotificationId);
      return;
    }

    final fireAt = _computeFireAt(attendance, settings);
    if (fireAt != null && fireAt.isAfter(DateTime.now())) {
      await _notificationService.scheduleAt(
        id: kCheckoutReminderNotificationId,
        title: '⏰ Time to check out',
        body: "Don't forget to check out at the machine.",
        scheduledDate: fireAt,
      );
    } else {
      await _notificationService.cancel(kCheckoutReminderNotificationId);
    }

    final endOfWorkAt = _shiftedEndOfWorkTime(attendance);
    if (endOfWorkAt.isAfter(DateTime.now())) {
      await _notificationService.scheduleAt(
        id: kEndOfWorkNotificationId,
        title: '🔔 End of work',
        body: "Your scheduled work day is over — don't forget to check out!",
        scheduledDate: endOfWorkAt,
        bypassSilentMode: true,
      );
    } else {
      await _notificationService.cancel(kEndOfWorkNotificationId);
    }
  }

  @override
  Future<DateTime?> getScheduledFireTime() async {
    final attendance = await _attendanceRepository.getTodayAttendance();
    if (attendance == null || attendance.checkOut != null) return null;
    if (attendance.checkIn == null) return null;

    final settings = await getSettings();
    if (!settings.enabled) return null;

    if (attendance.expectedEndMinute <= attendance.expectedStartMinute) {
      return null;
    }

    return _computeFireAt(attendance, settings);
  }

  @override
  Future<DateTime?> getScheduledEndOfWorkTime() async {
    final attendance = await _attendanceRepository.getTodayAttendance();
    if (attendance == null || attendance.checkOut != null) return null;
    if (attendance.checkIn == null) return null;

    final settings = await getSettings();
    if (!settings.enabled) return null;

    if (attendance.expectedEndMinute <= attendance.expectedStartMinute) {
      return null;
    }

    return _shiftedEndOfWorkTime(attendance);
  }

  /// Pure computation of the checkout-reminder fire time from [attendance]
  /// + [settings], returning `null` only if an input is missing. Does not
  /// check whether the time has already passed — callers deciding whether
  /// to actually schedule/keep a notification (`_evaluate`) must check
  /// `isAfter(DateTime.now())` themselves; callers just inspecting/
  /// displaying the computed time (e.g. the debug card via
  /// [getScheduledFireTime]) want the raw value even once it's elapsed,
  /// rather than a misleading "nothing computed" result. Does not perform
  /// any of the validity checks that gate whether this should even be
  /// computed (no attendance/checkout/check-in/disabled/invalid schedule)
  /// — callers are responsible for those.
  DateTime? _computeFireAt(
    Attendance? attendance,
    CheckoutReminderSettings? settings,
  ) {
    if (attendance == null || settings == null) return null;

    return _shiftedEndOfWorkTime(
      attendance,
    ).subtract(Duration(minutes: settings.leadMinutes));
  }

  /// Pure computation of the user's shifted expected checkout time — the
  /// schedule's raw end time shifted forward by however late they checked
  /// in, with no lead time subtracted. This is the instant the end-of-work
  /// notification fires at exactly, and also the anchor the checkout
  /// reminder's lead time is subtracted from. Does not check whether the
  /// time has already passed — same contract as [_computeFireAt].
  DateTime _shiftedEndOfWorkTime(Attendance attendance) {
    final shiftedExpectedEndMinute =
        attendance.expectedEndMinute + attendance.lateMinutes;
    return attendance.workDate.add(Duration(minutes: shiftedExpectedEndMinute));
  }
}
