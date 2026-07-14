import 'package:injectable/injectable.dart' hide Order;

import '../../../database/attendance/attendance_entity.dart';
import '../../../database/objectbox.g.dart';

abstract class AttendanceDao {
  AttendanceEntity? getByDayKey(int dayKey);
  void save(AttendanceEntity entity);
  void deleteByDayKey(int dayKey);

  /// Most-recent-first rows (ordered by [AttendanceEntity.workDate]
  /// descending), capped at [limit].
  List<AttendanceEntity> getRecent({required int limit});
}

@LazySingleton(as: AttendanceDao)
class AttendanceDaoImpl implements AttendanceDao {
  final Box<AttendanceEntity> _box;

  AttendanceDaoImpl(this._box);

  @override
  AttendanceEntity? getByDayKey(int dayKey) {
    final query = _box.query(AttendanceEntity_.dayKey.equals(dayKey)).build();
    try {
      return query.findFirst();
    } finally {
      query.close();
    }
  }

  @override
  void save(AttendanceEntity entity) {
    // Reuse the existing row's real id for today's dayKey (update), or 0 for a
    // genuinely new row (insert) — same ObjectBox id-sequence rule as WorkScheduleDao.
    entity.id = getByDayKey(entity.dayKey)?.id ?? 0;
    _box.put(entity);
  }

  @override
  void deleteByDayKey(int dayKey) {
    final entity = getByDayKey(dayKey);
    if (entity != null) {
      _box.remove(entity.id);
    }
  }

  @override
  List<AttendanceEntity> getRecent({required int limit}) {
    final query = _box
        .query()
        .order(AttendanceEntity_.workDate, flags: Order.descending)
        .build();
    query.limit = limit;
    try {
      return query.find();
    } finally {
      query.close();
    }
  }
}
