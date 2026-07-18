import 'package:injectable/injectable.dart';

import '../../../database/objectbox.g.dart';
import '../../../database/task/task_time_session_entity.dart';

abstract class TaskTimeSessionDao {
  List<TaskTimeSessionEntity> getAll();

  /// All sessions whose [TaskTimeSessionEntity.start] falls on the same
  /// calendar day as [day] (matched on the [dayStart, nextMidnight) range).
  List<TaskTimeSessionEntity> getByDay(DateTime day);

  int put(TaskTimeSessionEntity entity);

  /// Removes every session for [taskId] — used when its task is deleted.
  void removeForTask(int taskId);
}

@LazySingleton(as: TaskTimeSessionDao)
class TaskTimeSessionDaoImpl implements TaskTimeSessionDao {
  TaskTimeSessionDaoImpl(this._box);

  final Box<TaskTimeSessionEntity> _box;

  @override
  List<TaskTimeSessionEntity> getAll() => _box.getAll();

  @override
  List<TaskTimeSessionEntity> getByDay(DateTime day) {
    final dayStart = DateTime(day.year, day.month, day.day);
    final nextMidnight = dayStart.add(const Duration(days: 1));
    final query = _box
        .query(
          TaskTimeSessionEntity_.start
              .greaterOrEqualDate(dayStart)
              .and(TaskTimeSessionEntity_.start.lessThanDate(nextMidnight)),
        )
        .build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  @override
  int put(TaskTimeSessionEntity entity) => _box.put(entity);

  @override
  void removeForTask(int taskId) {
    final query = _box
        .query(TaskTimeSessionEntity_.taskId.equals(taskId))
        .build();
    try {
      _box.removeMany(query.findIds());
    } finally {
      query.close();
    }
  }
}
