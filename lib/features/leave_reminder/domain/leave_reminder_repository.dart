import 'models/geo_point.dart';
import 'models/leave_reminder_prompt_trigger.dart';
import 'models/leave_reminder_settings.dart';
import 'models/notification_log_entry.dart';
import 'models/tomorrow_preview.dart';

enum EnableLeaveReminderResult { success, notificationPermissionDenied }

abstract class LeaveReminderRepository {
  Future<LeaveReminderSettings> getSettings();

  /// Emits whenever leave-time-relevant state changes (home/work location,
  /// enabled toggle, waypoints, or a freshly cached commute estimate) so
  /// screens showing the computed leave/arrival time (e.g. the Home hero
  /// card) can re-read [getLeaveTime]/[getEstimatedArrivalTime] reactively.
  Stream<void> watchLeaveInfoChanges();
  Future<EnableLeaveReminderResult> setEnabled(bool enabled);
  Future<LeaveReminderSettings> setHomeLocation(GeoPoint point);
  Future<LeaveReminderSettings> setWorkLocation(GeoPoint point);
  Future<LeaveReminderSettings> setHeadsUpLeadMinutes(int minutes);
  Future<LeaveReminderSettings> setWorkRadiusMeters(int meters);
  Future<void> scheduleTodayReminders();

  /// Appends a new enabled waypoint (stop) to the commute route, in
  /// add-order. No-ops (returns the unchanged settings) if there are already
  /// 3 waypoints — the maximum supported.
  Future<LeaveReminderSettings> addWaypoint(GeoPoint point);

  /// Removes the waypoint at [index]. Remaining waypoints after it shift
  /// down to close the gap (route order is always add-order).
  Future<LeaveReminderSettings> removeWaypointAt(int index);

  /// Toggles whether the waypoint at [index] counts toward the total
  /// commute duration, without removing it or changing its location.
  Future<LeaveReminderSettings> setWaypointEnabledAt(int index, bool enabled);

  /// Replaces the location of the waypoint at [index] in place — its
  /// position in the route and enabled/disabled state are unchanged.
  Future<LeaveReminderSettings> setWaypointLocationAt(
    int index,
    GeoPoint point,
  );

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

  /// Recent scheduled-notification history — both already-fired entries and
  /// still-upcoming ones. Callers distinguish the two via
  /// `entry.scheduledAt.isAfter(DateTime.now())`. Debug-only.
  Future<List<NotificationLogEntry>> getNotificationLog();
}
