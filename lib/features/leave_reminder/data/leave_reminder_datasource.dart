import '../domain/models/leave_reminder_settings.dart';

abstract class LeaveReminderDatasource {
  Future<LeaveReminderSettings> getSettings();
  Future<void> saveSettings(LeaveReminderSettings settings);
  Future<void> saveCommuteCache(int minutes, DateTime updatedAt);
}
