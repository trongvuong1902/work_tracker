import 'package:injectable/injectable.dart';
import 'package:objectbox/objectbox.dart';

import '../../../database/work_schedule/work_schedule_entity.dart';

abstract class WorkScheduleDao {
  void save(WorkScheduleEntity entity);
  WorkScheduleEntity? get();
  void delete();
}

@LazySingleton(as: WorkScheduleDao)
class WorkScheduleDaoImpl implements WorkScheduleDao {
  final Box<WorkScheduleEntity> _box;

  WorkScheduleDaoImpl(this._box);

  @override
  void save(WorkScheduleEntity entity) {
    // A user has exactly one active work schedule. ObjectBox requires id=0
    // to insert a new object (it assigns the id itself); reusing an existing
    // row's real id turns the put into an update of that same singleton row.
    entity.id = get()?.id ?? 0;
    _box.put(entity);
  }

  @override
  WorkScheduleEntity? get() {
    final all = _box.getAll();
    return all.isEmpty ? null : all.first;
  }

  @override
  void delete() {
    final existing = get();
    if (existing != null) {
      _box.remove(existing.id);
    }
  }
}
