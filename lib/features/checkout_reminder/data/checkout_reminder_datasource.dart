import '../domain/models/checkout_reminder_settings.dart';

abstract class CheckoutReminderDatasource {
  Future<CheckoutReminderSettings> getSettings();
  Future<void> saveSettings(CheckoutReminderSettings settings);
}
