import 'package:injectable/injectable.dart';

import '../../../database/objectbox.g.dart';
import '../../../database/work_item/work_item_time_log_entity.dart';

abstract class WorkItemTimeLogDao {
  List<WorkItemTimeLogEntity> getAll();

  /// All rows whose [WorkItemTimeLogEntity.day] falls on the same calendar day as
  /// [day] (matched on the exact day-normalized value).
  List<WorkItemTimeLogEntity> getByDay(DateTime day);

  /// The single row for [taskId] on [day], or null if none — used to decide
  /// increment-vs-insert.
  WorkItemTimeLogEntity? findByTaskAndDay(int taskId, DateTime day);

  /// Inserts (id 0) or updates, returning the assigned id.
  int put(WorkItemTimeLogEntity entity);

  WorkItemTimeLogEntity? getById(int id);

  void remove(int id);

  /// Removes every log row for [taskId] — used when its task is deleted.
  void removeForTask(int taskId);
}

@LazySingleton(as: WorkItemTimeLogDao)
class TaskTimeLogDaoImpl implements WorkItemTimeLogDao {
  TaskTimeLogDaoImpl(this._box);

  final Box<WorkItemTimeLogEntity> _box;

  @override
  List<WorkItemTimeLogEntity> getAll() => _box.getAll();

  @override
  List<WorkItemTimeLogEntity> getByDay(DateTime day) {
    final query = _box
        .query(WorkItemTimeLogEntity_.day.equalsDate(day))
        .build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  @override
  WorkItemTimeLogEntity? findByTaskAndDay(int taskId, DateTime day) {
    final query = _box
        .query(
          WorkItemTimeLogEntity_.taskId
              .equals(taskId)
              .and(WorkItemTimeLogEntity_.day.equalsDate(day)),
        )
        .build();
    try {
      return query.findFirst();
    } finally {
      query.close();
    }
  }

  @override
  int put(WorkItemTimeLogEntity entity) => _box.put(entity);

  @override
  WorkItemTimeLogEntity? getById(int id) => _box.get(id);

  @override
  void remove(int id) => _box.remove(id);

  @override
  void removeForTask(int taskId) {
    final query = _box.query(WorkItemTimeLogEntity_.taskId.equals(taskId)).build();
    try {
      _box.removeMany(query.findIds());
    } finally {
      query.close();
    }
  }
}
