import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../../core/text/html_format.dart';
import '../../../database/task/task_entity.dart';
import '../../zentao/domain/models/zentao_bug.dart';
import '../../zentao/domain/models/zentao_bug_attachment.dart';
import '../../zentao/domain/models/zentao_bug_comment.dart';
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

  /// Copies the list-sourced Zentao bug fields (and optional [product]
  /// context) onto [entity], stamping the sync time. Shared by import and
  /// upsert so a bug's persisted fields never drift between the two paths.
  /// Deliberately does NOT touch detail-only fields (notes/attachments) and
  /// only overwrites the description when the list actually carries one, so a
  /// re-sync never wipes data the lazy detail fetch already enriched.
  void _applyBugFields(TaskEntity entity, ZentaoBug bug, ZentaoProduct? product) {
    entity.title = _bugTitle(bug);
    if (bug.description != null && bug.description!.isNotEmpty) {
      entity.description = bug.description;
    }
    entity.zentaoStatus = bug.status;
    entity.zentaoPriority = bug.priority;
    entity.zentaoSeverity = bug.severity;
    entity.priority = _computeTaskPriority(bug.severity, bug.priority);
    entity.zentaoProductId = product?.id;
    entity.zentaoProductName = product?.name;
    entity.zentaoProductPriority = product?.priority;
    entity.zentaoLastSyncedAt = DateTime.now();
  }

  /// Task title for a bug: the `[id][title]` pattern, with any HTML flattened.
  String _bugTitle(ZentaoBug bug) => '[${bug.id}][${htmlToPlainText(bug.title)}]';

  /// Single 1..5 task priority (1 = most urgent) from the Zentao severity +
  /// priority (each 1..4, 1 = highest; 0/null = unset). Equal-weight average
  /// of whichever values are set, scaled to 1..5. Null when neither is set.
  int? _computeTaskPriority(int? severity, int? priority) {
    final values = [
      severity,
      priority,
    ].whereType<int>().where((v) => v >= 1).toList();
    if (values.isEmpty) return null;
    final avg = values.reduce((a, b) => a + b) / values.length; // 1..4
    final scaled = ((avg - 1) / 3 * 4).round() + 1; // 1..5
    return scaled.clamp(1, 5);
  }

  /// Flattens a bug's comment/action history into a readable notes blob.
  String? _formatNotes(List<ZentaoBugComment> comments) {
    if (comments.isEmpty) return null;
    final blocks = comments.map((c) {
      final header = [
        if (c.actor != null && c.actor!.isNotEmpty) c.actor!,
        if (c.date != null) _formatDate(c.date!),
      ].join(' · ');
      return header.isEmpty ? c.comment : '$header\n${c.comment}';
    }).join('\n\n');
    return blocks.isEmpty ? null : blocks;
  }

  String _formatDate(DateTime d) {
    String two(int v) => v.toString().padLeft(2, '0');
    return '${d.year}-${two(d.month)}-${two(d.day)} ${two(d.hour)}:${two(d.minute)}';
  }

  String? _encodeAttachments(List<ZentaoBugAttachment> list) {
    if (list.isEmpty) return null;
    return jsonEncode([
      for (final a in list)
        {
          'id': a.id,
          'title': a.title,
          'ext': a.fileExtension,
          'size': a.sizeBytes,
        },
    ]);
  }

  List<ZentaoBugAttachment> _decodeAttachments(String? json) {
    if (json == null || json.isEmpty) return const [];
    try {
      final decoded = jsonDecode(json);
      if (decoded is! List) return const [];
      return [
        for (final item in decoded)
          if (item is Map<String, dynamic> && item['id'] != null)
            ZentaoBugAttachment(
              id: (item['id'] as num).toInt(),
              title: item['title'] as String? ?? 'Attachment',
              fileExtension: item['ext'] as String?,
              sizeBytes: (item['size'] as num?)?.toInt(),
            ),
      ];
    } catch (_) {
      return const [];
    }
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
    final now = DateTime.now();
    // Only one timer runs at a time across all tasks — stop any other running
    // task first, accumulating its elapsed time.
    for (final other in _dao.getAll()) {
      final startedAt = other.timerStartedAt;
      if (other.id != id && startedAt != null) {
        other.elapsedSeconds += now.difference(startedAt).inSeconds;
        other.timerStartedAt = null;
        _dao.update(other);
      }
    }
    entity.timerStartedAt = now;
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
      // Bugs pull the full detail so description/notes/attachments (which only
      // exist on the detail endpoint) are mapped and persisted onto the task.
      // Backs both the lazy first-open enrichment and the manual Refresh.
      final detail = await _zentaoRepository.getBugDetail(zentaoBugId);
      if (detail != null) {
        final bug = detail.bug;
        final now = DateTime.now();
        entity.title = _bugTitle(bug);
        if (bug.description != null && bug.description!.isNotEmpty) {
          entity.description = bug.description;
        }
        entity.zentaoStatus = bug.status;
        entity.zentaoPriority = bug.priority;
        entity.zentaoSeverity = bug.severity;
        entity.priority = _computeTaskPriority(bug.severity, bug.priority);
        entity.notes = _formatNotes(detail.comments);
        entity.zentaoAttachmentsJson = _encodeAttachments(detail.attachments);
        entity.zentaoLastSyncedAt = now;
        entity.zentaoDetailSyncedAt = now;
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
    priority: entity.priority,
    notes: entity.notes,
    attachments: _decodeAttachments(entity.zentaoAttachmentsJson),
    zentaoPriority: entity.zentaoPriority,
    zentaoSeverity: entity.zentaoSeverity,
    zentaoProductId: entity.zentaoProductId,
    zentaoProductName: entity.zentaoProductName,
    zentaoProductPriority: entity.zentaoProductPriority,
    zentaoLastSyncedAt: entity.zentaoLastSyncedAt,
    zentaoDetailSyncedAt: entity.zentaoDetailSyncedAt,
    elapsedSeconds: entity.elapsedSeconds,
    timerStartedAt: entity.timerStartedAt,
  );
}
