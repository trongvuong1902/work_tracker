import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../../core/text/html_format.dart';
import '../../../core/time/time_format.dart';
import '../../../database/work_item/work_item_entity.dart';
import '../../zentao/domain/models/zentao_bug.dart';
import '../../zentao/domain/models/zentao_bug_attachment.dart';
import '../../zentao/domain/models/zentao_bug_comment.dart';
import '../../zentao/domain/models/zentao_product.dart';
import '../../zentao/domain/models/zentao_task.dart';
import '../../zentao/domain/zentao_repository.dart';
import '../data/work_item_dao.dart';
import 'models/work_item.dart';
import 'models/work_item_source.dart';
import 'work_item_repository.dart';
import 'work_item_time_log_repository.dart';

@LazySingleton(as: WorkItemRepository)
class WorkItemRepositoryImpl implements WorkItemRepository {
  WorkItemRepositoryImpl(this._dao, this._zentaoRepository, this._timeLogRepository);

  final WorkItemDao _dao;
  final ZentaoRepository _zentaoRepository;
  final WorkItemTimeLogRepository _timeLogRepository;

  // Broadcast on every mutation so reactive views (home "Today's tasks") can
  // re-read. Never emit on reads — that would feed back into a listener that
  // re-reads. App-scoped singleton, so it's never closed.
  final _changesController = StreamController<void>.broadcast();

  @override
  Stream<void> watchTasksChanges() => _changesController.stream;

  void _notifyChanged() => _changesController.add(null);

  // Zentao statuses that mean the item is finished. Bugs use resolved/closed;
  // tasks use done/closed. Cancelled is deliberately excluded (not "done").
  static const _completedZentaoStatuses = {'resolved', 'closed', 'done'};

  bool _isZentaoCompletedStatus(String? status) {
    if (status == null) return false;
    return _completedZentaoStatuses.contains(status.trim().toLowerCase());
  }

  /// Two-way status sync for a Zentao-linked [entity]: aligns local `done` with
  /// the freshly-applied `zentaoStatus` (the server is the source of truth). A
  /// completed status (resolved/closed/done) marks the task done, finalizing
  /// any running timer the way [stopTimer] does so tracked time isn't lost; a
  /// non-completed status (e.g. a bug reopened on the server back to active)
  /// clears `done` so the task returns to the active list. Tracked time is
  /// always preserved. Assumes the caller has already applied the fresh
  /// `zentaoStatus`, and persists via the caller's `_dao.update`.
  Future<void> _applyZentaoStatus(WorkItemEntity entity) async {
    if (_isZentaoCompletedStatus(entity.zentaoStatus)) {
      if (entity.done) return;
      final startedAt = entity.timerStartedAt;
      if (startedAt != null) {
        final now = DateTime.now();
        entity.elapsedSeconds += now.difference(startedAt).inSeconds;
        entity.timerStartedAt = null;
        await _timeLogRepository.recordSegment(entity.id, startedAt, now);
      }
      entity.done = true;
    } else if (entity.done) {
      // Server reopened the item (or it was never completed) — reflect it
      // locally so the task returns to the active list.
      entity.done = false;
    }
  }

  @override
  Future<WorkItem> createManual({
    required String title,
    String? description,
  }) async {
    final entity = WorkItemEntity(
      title: title,
      description: description,
      done: false,
      createdAt: DateTime.now(),
      elapsedSeconds: 0,
    );
    _dao.insert(entity);
    _notifyChanged();
    return _toModel(entity);
  }

  @override
  Future<WorkItem> importFromZentao(ZentaoTask task) async {
    final entity = WorkItemEntity(
      title: task.name,
      done: false,
      createdAt: DateTime.now(),
      zentaoTaskId: task.id,
      zentaoStatus: task.status,
      zentaoLastSyncedAt: DateTime.now(),
      elapsedSeconds: 0,
      taskSource: WorkItemSource.zentao.name,
      externalId: task.id.toString(),
      externalType: ExternalItemType.task.name,
    );
    _dao.insert(entity);
    await _applyZentaoStatus(entity);
    _dao.update(entity);
    _notifyChanged();
    return _toModel(entity);
  }

  @override
  Future<WorkItem> importBugFromZentao(ZentaoBug bug, {ZentaoProduct? product}) async {
    final entity = WorkItemEntity(
      title: bug.title,
      done: false,
      createdAt: DateTime.now(),
      zentaoBugId: bug.id,
      zentaoStatus: bug.status,
      elapsedSeconds: 0,
    );
    _applyBugFields(entity, bug, product);
    _dao.insert(entity);
    await _applyZentaoStatus(entity);
    _dao.update(entity);
    _notifyChanged();
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
      // (elapsedSeconds/timerStartedAt/createdAt) untouched — except `done`,
      // which tracks the server status two-way (completed → done, reopened →
      // active) via _applyZentaoStatus.
      _applyBugFields(existing, bug, product);
      await _applyZentaoStatus(existing);
      _dao.update(existing);
      _notifyChanged();
      return BugUpsertOutcome.updated;
    }

    final entity = WorkItemEntity(
      title: bug.title,
      done: false,
      createdAt: DateTime.now(),
      zentaoBugId: bug.id,
      zentaoStatus: bug.status,
      elapsedSeconds: 0,
    );
    _applyBugFields(entity, bug, product);
    _dao.insert(entity);
    await _applyZentaoStatus(entity);
    _dao.update(entity);
    _notifyChanged();
    return BugUpsertOutcome.added;
  }

  /// Copies the list-sourced Zentao bug fields (and optional [product]
  /// context) onto [entity], stamping the sync time. Shared by import and
  /// upsert so a bug's persisted fields never drift between the two paths.
  /// Deliberately does NOT touch detail-only fields (notes/attachments) and
  /// only overwrites the description when the list actually carries one, so a
  /// re-sync never wipes data the lazy detail fetch already enriched.
  void _applyBugFields(WorkItemEntity entity, ZentaoBug bug, ZentaoProduct? product) {
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
    entity.zentaoConfirmed = bug.confirmed;
    entity.zentaoOpenedBy = bug.openedByAccount ?? entity.zentaoOpenedBy;
    entity.zentaoLastSyncedAt = DateTime.now();
    // Forward-fill the platform-agnostic identity so new rows are sync-ready.
    entity.taskSource = WorkItemSource.zentao.name;
    entity.externalId = bug.id.toString();
    entity.externalType = ExternalItemType.bug.name;
  }

  /// WorkItem title for a bug: the plain-text title, with any HTML flattened.
  String _bugTitle(ZentaoBug bug) => htmlToPlainText(bug.title);

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
  Future<List<WorkItem>> getAll() async {
    final entities = _dao.getAll()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return entities.map(_toModel).toList();
  }

  @override
  Future<WorkItem?> getById(int id) async {
    final entity = _dao.getById(id);
    return entity == null ? null : _toModel(entity);
  }

  @override
  Future<void> toggleDone(int id) async {
    final entity = _dao.getById(id);
    if (entity == null) return;
    entity.done = !entity.done;
    _dao.update(entity);
    _notifyChanged();
  }

  @override
  Future<WorkItem> setPlannedDate(int id, DateTime? date) async {
    final entity = _dao.getById(id);
    if (entity == null) throw Exception('Task not found: $id');
    entity.plannedDate =
        date == null ? null : DateTime(date.year, date.month, date.day);
    _dao.update(entity);
    _notifyChanged();
    return _toModel(entity);
  }

  @override
  Future<List<WorkItem>> getUnplannedOpenTasks() async {
    final entities = _dao.getAll()
        .where((e) => !e.done && e.plannedDate == null)
        .toList()
      ..sort((a, b) {
        final ap = a.priority;
        final bp = b.priority;
        if (ap != bp) {
          if (ap == null) return 1;
          if (bp == null) return -1;
          return ap.compareTo(bp);
        }
        return b.createdAt.compareTo(a.createdAt);
      });
    return entities.map(_toModel).toList();
  }

  @override
  Future<void> setPlannedDateForTasks(List<int> ids, DateTime day) async {
    if (ids.isEmpty) return;
    final dayStart = DateTime(day.year, day.month, day.day);
    for (final id in ids) {
      final entity = _dao.getById(id);
      if (entity == null) continue;
      entity.plannedDate = dayStart;
      _dao.update(entity);
    }
    _notifyChanged();
  }

  @override
  Future<List<WorkItem>> getPlannedTasksForMonth(int year, int month) async {
    final entities = _dao.getAll().where((e) {
      final planned = e.plannedDate;
      return planned != null &&
          planned.year == year &&
          planned.month == month;
    }).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return entities.map(_toModel).toList();
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
        await _timeLogRepository.recordSegment(other.id, startedAt, now);
      }
    }
    entity.timerStartedAt = now;
    _dao.update(entity);
    _notifyChanged();
  }

  @override
  Future<void> stopTimer(int id) async {
    final entity = _dao.getById(id);
    final startedAt = entity?.timerStartedAt;
    if (entity == null || startedAt == null) return;
    final now = DateTime.now();
    entity.elapsedSeconds += now.difference(startedAt).inSeconds;
    entity.timerStartedAt = null;
    _dao.update(entity);
    await _timeLogRepository.recordSegment(id, startedAt, now);
    _notifyChanged();
  }

  @override
  Future<WorkItem> refreshFromZentao(int id) async {
    final entity = _dao.getById(id);
    if (entity == null) throw Exception('Task not found: $id');

    final zentaoTaskId = entity.zentaoTaskId;
    final zentaoBugId = entity.zentaoBugId;

    if (zentaoTaskId != null) {
      final refreshed = await _zentaoRepository.refreshTask(zentaoTaskId);
      if (refreshed != null) {
        entity.zentaoStatus = refreshed.status;
        entity.zentaoLastSyncedAt = DateTime.now();
        await _applyZentaoStatus(entity);
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
        entity.zentaoConfirmed = bug.confirmed;
        entity.zentaoOpenedBy = bug.openedByAccount ?? entity.zentaoOpenedBy;
        entity.notes = _formatNotes(detail.comments);
        entity.zentaoAttachmentsJson = _encodeAttachments(detail.attachments);
        entity.zentaoLastSyncedAt = now;
        entity.zentaoDetailSyncedAt = now;
        await _applyZentaoStatus(entity);
        _dao.update(entity);
      }
    }
    // else: not linked to Zentao at all — no-op.

    _notifyChanged();
    return _toModel(entity);
  }

  @override
  Future<int> refreshAllZentaoFromServer() async {
    final entities = _dao
        .getAll()
        .where((e) => e.zentaoTaskId != null || e.zentaoBugId != null)
        .toList();
    var updated = 0;
    for (final entity in entities) {
      // Skip individual failures (a deleted ticket, an auth blip) so one bad
      // item doesn't abort the whole refresh.
      try {
        final zentaoTaskId = entity.zentaoTaskId;
        final zentaoBugId = entity.zentaoBugId;
        if (zentaoTaskId != null) {
          final refreshed = await _zentaoRepository.refreshTask(zentaoTaskId);
          if (refreshed == null) continue;
          entity.zentaoStatus = refreshed.status;
          entity.zentaoLastSyncedAt = DateTime.now();
        } else if (zentaoBugId != null) {
          // Lightweight status-only fetch — not the full detail, so
          // pull-to-refresh stays fast and notes/attachments aren't re-pulled.
          final bug = await _zentaoRepository.refreshBug(zentaoBugId);
          if (bug == null) continue;
          _applyBugStatusRefresh(entity, bug);
        } else {
          continue;
        }
        await _applyZentaoStatus(entity);
        _dao.update(entity);
        updated++;
      } catch (_) {
        // Ignore and move on to the next task.
      }
    }
    if (updated > 0) _notifyChanged();
    return updated;
  }

  /// Refreshes the status-relevant Zentao fields of a bug-linked [entity] from a
  /// lightweight `refreshBug` result. Unlike [_applyBugFields], it deliberately
  /// leaves product context and detail-only fields (notes/attachments) intact,
  /// so a bulk status refresh never wipes data the sync/detail fetch enriched.
  void _applyBugStatusRefresh(WorkItemEntity entity, ZentaoBug bug) {
    entity.title = _bugTitle(bug);
    entity.zentaoStatus = bug.status;
    entity.zentaoPriority = bug.priority;
    entity.zentaoSeverity = bug.severity;
    entity.priority = _computeTaskPriority(bug.severity, bug.priority);
    entity.zentaoConfirmed = bug.confirmed;
    entity.zentaoOpenedBy = bug.openedByAccount ?? entity.zentaoOpenedBy;
    entity.zentaoLastSyncedAt = DateTime.now();
  }

  WorkItem _toModel(WorkItemEntity entity) => WorkItem(
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
    zentaoConfirmed: entity.zentaoConfirmed,
    source: _deriveSource(entity),
    externalId: entity.externalId ??
        (entity.zentaoBugId ?? entity.zentaoTaskId)?.toString(),
    externalType: _deriveExternalType(entity),
    externalUrl: entity.externalUrl,
    plannedDate: entity.plannedDate,
  );

  /// Source discriminator: the stored value when present, otherwise derived
  /// from the legacy zentao* columns so pre-existing rows map correctly.
  WorkItemSource _deriveSource(WorkItemEntity entity) {
    if (entity.taskSource != null) {
      return TaskSourceX.fromName(entity.taskSource);
    }
    return (entity.zentaoBugId != null || entity.zentaoTaskId != null)
        ? WorkItemSource.zentao
        : WorkItemSource.manual;
  }

  ExternalItemType? _deriveExternalType(WorkItemEntity entity) {
    final stored = ExternalItemTypeX.fromName(entity.externalType);
    if (stored != null) return stored;
    if (entity.zentaoBugId != null) return ExternalItemType.bug;
    if (entity.zentaoTaskId != null) return ExternalItemType.task;
    return null;
  }

  @override
  Future<void> confirmZentaoBug(int id) async {
    final entity = _dao.getById(id);
    if (entity == null) return;
    final zentaoBugId = entity.zentaoBugId;
    // Only bug-linked tasks confirm; skip if already confirmed.
    if (zentaoBugId == null || entity.zentaoConfirmed) return;

    // Throws on failure — the caller (cubit) blocks starting the timer.
    await _zentaoRepository.confirmBug(zentaoBugId, pri: entity.zentaoPriority);

    entity.zentaoConfirmed = true;
    _dao.update(entity);
    _notifyChanged();
  }

  @override
  Future<WorkItem> resolveZentaoBug(int id, {int? durationMinutes}) async {
    final entity = _dao.getById(id);
    if (entity == null) throw Exception('Task not found: $id');
    final zentaoBugId = entity.zentaoBugId;
    if (zentaoBugId == null) {
      throw Exception('Task  is not linked to a Zentao bug');
    }

    // Final tracked total, including the in-progress segment — computed
    // WITHOUT mutating, so nothing changes locally if the resolve call fails.
    final now = DateTime.now();
    final startedAt = entity.timerStartedAt;
    final totalSeconds = entity.elapsedSeconds +
        (startedAt == null ? 0 : now.difference(startedAt).inSeconds);
    // The reported duration drives the comment when the user confirmed one in
    // the resolve sheet; otherwise fall back to the measured tracked total.
    final reportedMinutes = durationMinutes ?? totalSeconds ~/ 60;
    final comment = 'Tracked time: ${TimeFormat.hMm(reportedMinutes)}';

    // The resolve is reassigned to the bug's opener. Enrich it on demand if a
    // stale/older import never captured it.
    var openedBy = entity.zentaoOpenedBy;
    if (openedBy == null) {
      final bug = await _zentaoRepository.refreshBug(zentaoBugId);
      openedBy = bug?.openedByAccount;
      if (openedBy != null) {
        entity.zentaoOpenedBy = openedBy;
        _dao.update(entity);
      }
    }
    if (openedBy == null) {
      throw Exception("Couldn't determine the bug's creator to assign on resolve");
    }

    // Throws on failure — the caller (cubit) leaves the task not-done.
    await _zentaoRepository.resolveBug(
      zentaoBugId,
      resolution: 'fixed', // Zentao code that displays as "Resolved".
      resolvedBuild: 'trunk',
      resolvedDate: DateTime.now(),
      assignedTo: openedBy,
      comment: comment,
    );

    // Success — finalize the timer and mark done locally.
    entity.elapsedSeconds = totalSeconds;
    entity.timerStartedAt = null;
    entity.done = true;
    entity.zentaoStatus = 'resolved';
    _dao.update(entity);
    if (startedAt != null) {
      await _timeLogRepository.recordSegment(id, startedAt, now);
    }
    _notifyChanged();
    return _toModel(entity);
  }

  @override
  Future<WorkItem> closeZentaoBug(int id) async {
    final entity = _dao.getById(id);
    if (entity == null) throw Exception('Task not found: $id');
    final zentaoBugId = entity.zentaoBugId;
    if (zentaoBugId == null) {
      throw Exception('Task  is not linked to a Zentao bug');
    }

    // Throws on failure — the caller leaves local state unchanged.
    await _zentaoRepository.closeBug(zentaoBugId);

    // Success — finalize any running timer and mark it closed/done locally.
    final startedAt = entity.timerStartedAt;
    final now = DateTime.now();
    if (startedAt != null) {
      entity.elapsedSeconds += now.difference(startedAt).inSeconds;
      entity.timerStartedAt = null;
    }
    entity.done = true;
    entity.zentaoStatus = 'closed';
    _dao.update(entity);
    if (startedAt != null) {
      await _timeLogRepository.recordSegment(id, startedAt, now);
    }
    _notifyChanged();
    return _toModel(entity);
  }

  @override
  Future<WorkItem> reopenZentaoBug(int id) async {
    final entity = _dao.getById(id);
    if (entity == null) throw Exception('Task not found: $id');
    final zentaoBugId = entity.zentaoBugId;
    if (zentaoBugId == null) {
      throw Exception('Task  is not linked to a Zentao bug');
    }

    // Throws on failure — the caller leaves local state unchanged.
    await _zentaoRepository.activateBug(zentaoBugId);

    // Success — reopen locally: back to active, not done, and needing a fresh
    // confirm on the next Start-timer.
    entity.done = false;
    entity.zentaoStatus = 'active';
    entity.zentaoConfirmed = false;
    _dao.update(entity);
    _notifyChanged();
    return _toModel(entity);
  }
}
