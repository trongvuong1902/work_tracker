import 'package:injectable/injectable.dart';

import '../../../database/objectbox.g.dart';
import '../../../database/work_item/work_item_entity.dart';

abstract class WorkItemDao {
  /// Inserts [entity] (its `id` must be 0) and returns it with the assigned
  /// id set.
  WorkItemEntity insert(WorkItemEntity entity);
  void update(WorkItemEntity entity);
  List<WorkItemEntity> getAll();
  WorkItemEntity? getById(int id);

  /// The single task linked to Zentao bug [bugId], or null if none is —
  /// used by the bulk bug sync to decide insert-vs-update.
  WorkItemEntity? findByZentaoBugId(int bugId);
  void remove(int id);
}

@LazySingleton(as: WorkItemDao)
class TaskDaoImpl implements WorkItemDao {
  TaskDaoImpl(this._box);

  final Box<WorkItemEntity> _box;

  @override
  WorkItemEntity insert(WorkItemEntity entity) {
    entity.id = _box.put(entity);
    return entity;
  }

  @override
  void update(WorkItemEntity entity) => _box.put(entity);

  @override
  List<WorkItemEntity> getAll() => _box.getAll();

  @override
  WorkItemEntity? getById(int id) => _box.get(id);

  @override
  WorkItemEntity? findByZentaoBugId(int bugId) {
    final query = _box.query(WorkItemEntity_.zentaoBugId.equals(bugId)).build();
    try {
      return query.findFirst();
    } finally {
      query.close();
    }
  }

  @override
  void remove(int id) => _box.remove(id);
}
