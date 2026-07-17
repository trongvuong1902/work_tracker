import 'package:injectable/injectable.dart' hide Order;

import '../../../database/leave_reminder/notification_log_entity.dart';
import '../../../database/objectbox.g.dart';

abstract class NotificationLogDao {
  void insert(NotificationLogEntity entity);

  /// Log rows with `scheduledAt >= [since]`, most-recent-first.
  List<NotificationLogEntity> getSince(DateTime since);

  /// The most recently logged row for [notificationId], or `null` if none
  /// exists.
  NotificationLogEntity? mostRecentFor(int notificationId);

  /// Deletes all rows with `scheduledAt < [before]`. Used for pruning.
  void deleteOlderThan(DateTime before);
}

@LazySingleton(as: NotificationLogDao)
class NotificationLogDaoImpl implements NotificationLogDao {
  final Box<NotificationLogEntity> _box;

  NotificationLogDaoImpl(this._box);

  @override
  void insert(NotificationLogEntity entity) => _box.put(entity); // id stays 0 -> always an insert

  @override
  List<NotificationLogEntity> getSince(DateTime since) {
    final query = _box
        .query(NotificationLogEntity_.scheduledAt.greaterOrEqualDate(since))
        .order(NotificationLogEntity_.scheduledAt, flags: Order.descending)
        .build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  @override
  NotificationLogEntity? mostRecentFor(int notificationId) {
    final query = _box
        .query(NotificationLogEntity_.notificationId.equals(notificationId))
        .order(NotificationLogEntity_.scheduledAt, flags: Order.descending)
        .build();
    try {
      return query.findFirst();
    } finally {
      query.close();
    }
  }

  @override
  void deleteOlderThan(DateTime before) {
    final query = _box
        .query(NotificationLogEntity_.scheduledAt.lessThanDate(before))
        .build();
    try {
      _box.removeMany(query.findIds());
    } finally {
      query.close();
    }
  }
}
