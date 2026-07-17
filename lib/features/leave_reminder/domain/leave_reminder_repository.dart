import 'models/geo_point.dart';
import 'models/leave_reminder_prompt_trigger.dart';
import 'models/leave_reminder_settings.dart';
import 'models/tomorrow_preview.dart';

enum EnableLeaveReminderResult { success, notificationPermissionDenied }

abstract class LeaveReminderRepository {
  Future<LeaveReminderSettings> getSettings();
  Future<EnableLeaveReminderResult> setEnabled(bool enabled);
  Future<LeaveReminderSettings> setHomeLocation(GeoPoint point);
  Future<LeaveReminderSettings> setWorkLocation(GeoPoint point);
  Future<LeaveReminderSettings> setHeadsUpLeadMinutes(int minutes);
  Future<void> scheduleTodayReminders();

  /// Rolling average commute duration (minutes) over the recent sample
  /// history, or `null` until at least two samples have been recorded.
  Future<int?> getAverageCommuteMinutes();

  /// Time to leave home to arrive on schedule, based on the last known
  /// commute duration. `null` if reminders are disabled, there's no active
  /// schedule, today isn't a working day, or no commute estimate exists yet.
  Future<DateTime?> getLeaveTime();

  /// Estimated arrival time at work if leaving at [getLeaveTime] — i.e. the
  /// leave time plus the last known commute duration. `null` under the same
  /// conditions as [getLeaveTime].
  Future<DateTime?> getEstimatedArrivalTime();

  /// Evaluates the discovery-prompt condition and, if it fires, marks the
  /// one-time "shown" flag right away (not after the user acts on it) so a
  /// crash or dismiss mid-flow can never cause a repeat.
  Future<LeaveReminderPromptTrigger?> checkIntroPromptTrigger();

  /// Preview of tomorrow's commute heads-up notification, computed ahead of
  /// time using the rolling average commute duration (no live traffic data
  /// exists yet for a time this far out). `null` if reminders are disabled,
  /// home/work aren't set, tomorrow isn't a working day, there's no active
  /// schedule, or fewer than two commute samples exist yet.
  Future<TomorrowPreview?> getTomorrowPreview();
}
