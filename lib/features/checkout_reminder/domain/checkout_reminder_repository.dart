import 'models/checkout_reminder_settings.dart';

enum EnableCheckoutReminderResult { success, notificationPermissionDenied }

abstract class CheckoutReminderRepository {
  Future<CheckoutReminderSettings> getSettings();
  Future<EnableCheckoutReminderResult> setEnabled(bool enabled);
  Future<CheckoutReminderSettings> setLeadMinutes(int minutes);
}
