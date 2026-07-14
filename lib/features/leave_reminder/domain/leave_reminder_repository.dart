import 'models/geo_point.dart';
import 'models/leave_reminder_prompt_trigger.dart';
import 'models/leave_reminder_settings.dart';

enum EnableLeaveReminderResult { success, notificationPermissionDenied }

abstract class LeaveReminderRepository {
  Future<LeaveReminderSettings> getSettings();
  Future<EnableLeaveReminderResult> setEnabled(bool enabled);
  Future<LeaveReminderSettings> setHomeLocation(GeoPoint point);
  Future<LeaveReminderSettings> setWorkLocation(GeoPoint point);
  Future<void> scheduleTodayReminders();

  /// Evaluates the discovery-prompt condition and, if it fires, marks the
  /// one-time "shown" flag right away (not after the user acts on it) so a
  /// crash or dismiss mid-flow can never cause a repeat.
  Future<LeaveReminderPromptTrigger?> checkIntroPromptTrigger();
}
