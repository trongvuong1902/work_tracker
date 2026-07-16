import 'models/checkout_reminder_settings.dart';

enum EnableCheckoutReminderResult { success, notificationPermissionDenied }

abstract class CheckoutReminderRepository {
  Future<CheckoutReminderSettings> getSettings();
  Future<EnableCheckoutReminderResult> setEnabled(bool enabled);
  Future<CheckoutReminderSettings> setLeadMinutes(int minutes);

  /// Read-only recomputation of the checkout-reminder fire time from
  /// today's attendance + current settings, without scheduling or
  /// cancelling anything. Returns `null` when there's nothing to compute:
  /// no attendance, already checked out, no check-in yet, reminders
  /// disabled, or an invalid schedule. Unlike `_evaluate`'s scheduling
  /// decision, this does NOT return `null` just because the computed time
  /// has already passed — it always reports the actual computed instant,
  /// which is what debug/inspection callers want to see.
  Future<DateTime?> getScheduledFireTime();
}
