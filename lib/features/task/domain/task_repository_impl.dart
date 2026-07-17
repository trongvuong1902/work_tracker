import 'package:injectable/injectable.dart';

import '../../../database/task/task_entity.dart';
import '../../zentao/domain/models/zentao_bug.dart';
import '../../zentao/domain/models/zentao_product.dart';
import '../../zentao/domain/models/zentao_task.dart';
import '../../zentao/domain/zentao_repository.dart';
import '../data/task_dao.dart';
import 'models/task.dart';
import 'task_repository.dart';

@LazySingleton(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl(this._dao, this._zentaoRepository);

  final TaskDao _dao;
  final ZentaoRepository _zentaoRepository;

  @override
  Future<Task> createManual({
    required String title,
    String? description,
  }) async {
    final entity = TaskEntity(
      title: title,
      description: description,
      done: false,
      createdAt: DateTime.now(),
      elapsedSeconds: 0,
    );
    _dao.insert(entity);
    return _toModel(entity);
  }

  @override
  Future<Task> importFromZentao(ZentaoTask task) async {
    final entity = TaskEntity(
      title: task.name,
      done: false,
      createdAt: DateTime.now(),
      zentaoTaskId: task.id,
      zentaoStatus: task.status,
      zentaoLastSyncedAt: DateTime.now(),
      elapsedSeconds: 0,
    );
    _dao.insert(entity);
    return _toModel(entity);
  }

  @override
  Future<Task> importBugFromZentao(ZentaoBug bug, {ZentaoProduct? product}) async {
    final entity = TaskEntity(
      title: bug.title,
      done: false,
      createdAt: DateTime.now(),
      zentaoBugId: bug.id,
      zentaoStatus: bug.status,
      elapsedSeconds: 0,
    );
    _applyBugFields(entity, bug, product);
    _dao.insert(entity);
    return _toModel(entity);
  }

  @override
  Future<BugUpsertOutcome> upsertBugFromZentao(
    ZentaoBug bug, {
    ZentaoProduct? product,
  }) async {
    final existing = _dao.findByZentaoBugId(bug.id);
    if (existing != null) {
      // Refresh the Zentao-sourced fields; leave local state
      // (done/elapsedSeconds/timerStartedAt/createdAt) untouched.
      _applyBugFields(existing, bug, product);
      _dao.update(existing);
      return BugUpsertOutcome.updated;
    }

    final entity = TaskEntity(
      title: bug.title,
      done: false,
      createdAt: DateTime.now(),
      zentaoBugId: bug.id,
      zentaoStatus: bug.status,
      elapsedSeconds: 0,
    );
    _applyBugFields(entity, bug, product);
    _dao.insert(entity);
    return BugUpsertOutcome.added;
  }

  /// Copies the mutable Zentao bug fields (and optional [product] context)
  /// onto [entity], stamping the sync time. Shared by import and upsert so a
  /// bug's persisted fields never drift between the two paths.
  void _applyBugFields(TaskEntity entity, ZentaoBug bug, ZentaoProduct? product) {
    entity.title = bug.title;
    entity.description = bug.description;
    entity.zentaoStatus = bug.status;
    entity.zentaoPriority = bug.priority;
    entity.zentaoSeverity = bug.severity;
    entity.zentaoProductId = product?.id;
    entity.zentaoProductName = product?.name;
    entity.zentaoProductPriority = product?.priority;
    entity.zentaoLastSyncedAt = DateTime.now();
  }

  @override
  Future<List<Task>> getAll() async {
    final entities = _dao.getAll()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return entities.map(_toModel).toList();
  }

  @override
  Future<Task?> getById(int id) async {
    final entity = _dao.getById(id);
    return entity == null ? null : _toModel(entity);
  }

  @override
  Future<void> toggleDone(int id) async {
    final entity = _dao.getById(id);
    if (entity == null) return;
    entity.done = !entity.done;
    _dao.update(entity);
  }

  @override
  Future<void> startTimer(int id) async {
    final entity = _dao.getById(id);
    if (entity == null || entity.timerStartedAt != null) return;
    entity.timerStartedAt = DateTime.now();
    _dao.update(entity);
  }

  @override
  Future<void> stopTimer(int id) async {
    final entity = _dao.getById(id);
    final startedAt = entity?.timerStartedAt;
    if (entity == null || startedAt == null) return;
    entity.elapsedSeconds += DateTime.now().difference(startedAt).inSeconds;
    entity.timerStartedAt = null;
    _dao.update(entity);
  }

  @override
  Future<Task> refreshFromZentao(int id) async {
    final entity = _dao.getById(id);
    if (entity == null) throw Exception('Task not found: $id');

    final zentaoTaskId = entity.zentaoTaskId;
    final zentaoBugId = entity.zentaoBugId;

    if (zentaoTaskId != null) {
      final refreshed = await _zentaoRepository.refreshTask(zentaoTaskId);
      if (refreshed != null) {
        entity.zentaoStatus = refreshed.status;
        entity.zentaoLastSyncedAt = DateTime.now();
        _dao.update(entity);
      }
    } else if (zentaoBugId != null) {
      final refreshed = await _zentaoRepository.refreshBug(zentaoBugId);
      if (refreshed != null) {
        entity.zentaoStatus = refreshed.status;
        entity.zentaoLastSyncedAt = DateTime.now();
        _dao.update(entity);
      }
    }
    // else: not linked to Zentao at all — no-op.

    return _toModel(entity);
  }

  Task _toModel(TaskEntity entity) => Task(
    id: entity.id,
    title: entity.title,
    description: entity.description,
    done: entity.done,
    createdAt: entity.createdAt,
    zentaoTaskId: entity.zentaoTaskId,
    zentaoBugId: entity.zentaoBugId,
    zentaoStatus: entity.zentaoStatus,
    zentaoPriority: entity.zentaoPriority,
    zentaoSeverity: entity.zentaoSeverity,
    zentaoProductId: entity.zentaoProductId,
    zentaoProductName: entity.zentaoProductName,
    zentaoProductPriority: entity.zentaoProductPriority,
    zentaoLastSyncedAt: entity.zentaoLastSyncedAt,
    elapsedSeconds: entity.elapsedSeconds,
    timerStartedAt: entity.timerStartedAt,
  );
}
