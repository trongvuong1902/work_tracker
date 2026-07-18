import 'package:injectable/injectable.dart';

import '../../../database/objectbox.g.dart';
import '../../../database/task/task_time_log_entity.dart';

abstract class TaskTimeLogDao {
  List<TaskTimeLogEntity> getAll();

  /// All rows whose [TaskTimeLogEntity.day] falls on the same calendar day as
  /// [day] (matched on the exact day-normalized value).
  List<TaskTimeLogEntity> getByDay(DateTime day);

  /// The single row for [taskId] on [day], or null if none — used to decide
  /// increment-vs-insert.
  TaskTimeLogEntity? findByTaskAndDay(int taskId, DateTime day);

  /// Inserts (id 0) or updates, returning the assigned id.
  int put(TaskTimeLogEntity entity);

  TaskTimeLogEntity? getById(int id);

  void remove(int id);

  /// Removes every log row for [taskId] — used when its task is deleted.
  void removeForTask(int taskId);
}

@LazySingleton(as: TaskTimeLogDao)
class TaskTimeLogDaoImpl implements TaskTimeLogDao {
  TaskTimeLogDaoImpl(this._box);

  final Box<TaskTimeLogEntity> _box;

  @override
  List<TaskTimeLogEntity> getAll() => _box.getAll();

  @override
  List<TaskTimeLogEntity> getByDay(DateTime day) {
    final query = _box
        .query(TaskTimeLogEntity_.day.equalsDate(day))
        .build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  @override
  TaskTimeLogEntity? findByTaskAndDay(int taskId, DateTime day) {
    final query = _box
        .query(
          TaskTimeLogEntity_.taskId
              .equals(taskId)
              .and(TaskTimeLogEntity_.day.equalsDate(day)),
        )
        .build();
    try {
      return query.findFirst();
    } finally {
      query.close();
    }
  }

  @override
  int put(TaskTimeLogEntity entity) => _box.put(entity);

  @override
  TaskTimeLogEntity? getById(int id) => _box.get(id);

  @override
  void remove(int id) => _box.remove(id);

  @override
  void removeForTask(int taskId) {
    final query = _box.query(TaskTimeLogEntity_.taskId.equals(taskId)).build();
    try {
      _box.removeMany(query.findIds());
    } finally {
      query.close();
    }
  }
}
