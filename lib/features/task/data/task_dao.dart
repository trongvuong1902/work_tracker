import 'package:injectable/injectable.dart';

import '../../../database/objectbox.g.dart';
import '../../../database/task/task_entity.dart';

abstract class TaskDao {
  /// Inserts [entity] (its `id` must be 0) and returns it with the assigned
  /// id set.
  TaskEntity insert(TaskEntity entity);
  void update(TaskEntity entity);
  List<TaskEntity> getAll();
  TaskEntity? getById(int id);

  /// The single task linked to Zentao bug [bugId], or null if none is —
  /// used by the bulk bug sync to decide insert-vs-update.
  TaskEntity? findByZentaoBugId(int bugId);
  void remove(int id);
}

@LazySingleton(as: TaskDao)
class TaskDaoImpl implements TaskDao {
  TaskDaoImpl(this._box);

  final Box<TaskEntity> _box;

  @override
  TaskEntity insert(TaskEntity entity) {
    entity.id = _box.put(entity);
    return entity;
  }

  @override
  void update(TaskEntity entity) => _box.put(entity);

  @override
  List<TaskEntity> getAll() => _box.getAll();

  @override
  TaskEntity? getById(int id) => _box.get(id);

  @override
  TaskEntity? findByZentaoBugId(int bugId) {
    final query = _box.query(TaskEntity_.zentaoBugId.equals(bugId)).build();
    try {
      return query.findFirst();
    } finally {
      query.close();
    }
  }

  @override
  void remove(int id) => _box.remove(id);
}
