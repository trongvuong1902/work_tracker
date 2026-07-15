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

  /// Schedules (or cancels) the checkout-reminder notification for the
  /// day's attendance row. Fires [settings.leadMinutes] before the user's
  /// real expected checkout time — the schedule's raw end time shifted
  /// forward by however late they checked in — not the raw schedule end
  /// time itself.
  Future<void> _evaluate(Attendance? attendance) async {
    if (attendance == null || attendance.checkOut != null) {
      await _notificationService.cancel(kCheckoutReminderNotificationId);
      return;
    }
    if (attendance.checkIn == null) return;

    final settings = await getSettings();
    if (!settings.enabled) return;

    if (attendance.expectedEndMinute <= attendance.expectedStartMinute) {
      await _notificationService.cancel(kCheckoutReminderNotificationId);
      return;
    }

    final shiftedExpectedEndMinute =
        attendance.expectedEndMinute + attendance.lateMinutes;
    final fireAt = attendance.workDate
        .add(Duration(minutes: shiftedExpectedEndMinute))
        .subtract(Duration(minutes: settings.leadMinutes));

    if (fireAt.isAfter(DateTime.now())) {
      await _notificationService.scheduleAt(
        id: kCheckoutReminderNotificationId,
        title: '⏰ Time to check out',
        body: "Don't forget to check out at the machine.",
        scheduledDate: fireAt,
      );
    } else {
      await _notificationService.cancel(kCheckoutReminderNotificationId);
    }
  }
}
