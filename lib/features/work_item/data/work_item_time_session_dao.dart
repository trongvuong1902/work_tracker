import 'package:injectable/injectable.dart';

import '../../../database/objectbox.g.dart';
import '../../../database/work_item/work_item_time_session_entity.dart';

abstract class WorkItemTimeSessionDao {
  List<WorkItemTimeSessionEntity> getAll();

  /// All sessions whose [WorkItemTimeSessionEntity.start] falls on the same
  /// calendar day as [day] (matched on the [dayStart, nextMidnight) range).
  List<WorkItemTimeSessionEntity> getByDay(DateTime day);

  int put(WorkItemTimeSessionEntity entity);

  /// Removes every session for [taskId] — used when its task is deleted.
  void removeForTask(int taskId);
}

@LazySingleton(as: WorkItemTimeSessionDao)
class TaskTimeSessionDaoImpl implements WorkItemTimeSessionDao {
  TaskTimeSessionDaoImpl(this._box);

  final Box<WorkItemTimeSessionEntity> _box;

  @override
  List<WorkItemTimeSessionEntity> getAll() => _box.getAll();

  @override
  List<WorkItemTimeSessionEntity> getByDay(DateTime day) {
    final dayStart = DateTime(day.year, day.month, day.day);
    final nextMidnight = dayStart.add(const Duration(days: 1));
    final query = _box
        .query(
          WorkItemTimeSessionEntity_.start
              .greaterOrEqualDate(dayStart)
              .and(WorkItemTimeSessionEntity_.start.lessThanDate(nextMidnight)),
        )
        .build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  @override
  int put(WorkItemTimeSessionEntity entity) => _box.put(entity);

  @override
  void removeForTask(int taskId) {
    final query = _box
        .query(WorkItemTimeSessionEntity_.taskId.equals(taskId))
        .build();
    try {
      _box.removeMany(query.findIds());
    } finally {
      query.close();
    }
  }
}
