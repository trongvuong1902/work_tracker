/// Domain-level view of a single scheduled-notification log row — see
/// [LeaveReminderRepository.getNotificationLog]. Plain (non-freezed) model,
/// mirroring [NotificationLogEntity] field-for-field; debug-only.
class NotificationLogEntry {
  const NotificationLogEntry({
    required this.notificationId,
    required this.title,
    required this.body,
    required this.scheduledAt,
  });

  final int notificationId;
  final String title;
  final String body;
  final DateTime scheduledAt;
}
