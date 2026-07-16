/// Generic local-notification plumbing. Holds no feature-specific copy or
/// timing logic — that lives in the features that use it (e.g.
/// `LeaveReminderRepository`).
abstract class NotificationService {
  Future<void> initialize();

  /// Requests permission to post notifications. Returns whether it was
  /// granted.
  Future<bool> requestPermission();

  /// Requests the Android `SCHEDULE_EXACT_ALARM` permission needed to fire
  /// notifications at an exact time while the device is idle. No-op (and
  /// returns true) on platforms that don't need it.
  Future<bool> ensureExactAlarmPermission();

  /// Schedules a one-off notification at [scheduledDate]. Falls back to an
  /// inexact schedule when [exact] is true but the exact-alarm permission
  /// hasn't been granted.
  Future<void> scheduleAt({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    bool exact = true,
  });

  Future<void> cancel(int id);

  /// Currently pending (OS-scheduled) local notifications — for debug
  /// inspection of what will actually fire, as opposed to what the app
  /// intended to schedule.
  Future<List<ScheduledNotificationInfo>> pendingNotifications();
}

/// Snapshot of one notification the OS currently has scheduled.
class ScheduledNotificationInfo {
  const ScheduledNotificationInfo({required this.id, this.title, this.body});

  final int id;
  final String? title;
  final String? body;
}
