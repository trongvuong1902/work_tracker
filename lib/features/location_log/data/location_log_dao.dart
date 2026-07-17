import 'package:injectable/injectable.dart' hide Order;

import '../../../database/location_log/location_log_entity.dart';
import '../../../database/objectbox.g.dart';

abstract class LocationLogDao {
  void insert(LocationLogEntity entity);

  /// Rows for [dayKey], in insertion order.
  List<LocationLogEntity> getByDayKey(int dayKey);

  /// Most-recent-first rows (ordered by [LocationLogEntity.timestamp]
  /// descending), capped at [limit].
  List<LocationLogEntity> getRecent({required int limit});

  /// Rows whose [LocationLogEntity.dayKey] falls within
  /// `[startDayKey, endDayKey]` (inclusive).
  List<LocationLogEntity> getByDayKeyRange({
    required int startDayKey,
    required int endDayKey,
  });
}

@LazySingleton(as: LocationLogDao)
class LocationLogDaoImpl implements LocationLogDao {
  final Box<LocationLogEntity> _box;

  LocationLogDaoImpl(this._box);

  @override
  void insert(LocationLogEntity entity) => _box.put(entity); // id stays 0 -> always an insert

  @override
  List<LocationLogEntity> getByDayKey(int dayKey) {
    final query = _box
        .query(LocationLogEntity_.dayKey.equals(dayKey))
        .order(LocationLogEntity_.timestamp)
        .build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  @override
  List<LocationLogEntity> getRecent({required int limit}) {
    final query = _box
        .query()
        .order(LocationLogEntity_.timestamp, flags: Order.descending)
        .build();
    query.limit = limit;
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  @override
  List<LocationLogEntity> getByDayKeyRange({
    required int startDayKey,
    required int endDayKey,
  }) {
    final query = _box
        .query(LocationLogEntity_.dayKey.between(startDayKey, endDayKey))
        .build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }
}
