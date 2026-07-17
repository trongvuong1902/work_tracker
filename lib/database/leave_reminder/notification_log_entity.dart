import 'package:objectbox/objectbox.dart';

/// A record of a scheduled heads-up/leave-now notification — written every
/// time [scheduleTodayReminders] actually schedules one (not when it's
/// skipped/cancelled), and pruned past [kNotificationLogWindow]. Debug-only:
/// lets developers see, after the fact, whether a notification was ever
/// scheduled and for what time, since the OS's pending-notifications list
/// only reflects what's still upcoming, not what already fired.
@Entity()
class NotificationLogEntity {
  @Id()
  int id = 0;

  int notificationId; // kHeadsUpNotificationId or kLeaveNowNotificationId

  String title;

  String body;

  @Property(type: PropertyType.date)
  DateTime scheduledAt;

  NotificationLogEntity({
    required this.notificationId,
    required this.title,
    required this.body,
    required this.scheduledAt,
  });
}
