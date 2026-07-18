import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:work_tracker/database/task/task_entity.dart';
import 'package:work_tracker/features/task/data/task_dao.dart';
import 'package:work_tracker/features/task/domain/models/task_source.dart';
import 'package:work_tracker/features/task/domain/models/task_time_log.dart';
import 'package:work_tracker/features/task/domain/models/task_time_session.dart';
import 'package:work_tracker/features/task/domain/task_repository.dart';
import 'package:work_tracker/features/task/domain/task_repository_impl.dart';
import 'package:work_tracker/features/task/domain/task_time_log_repository.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_bug.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_bug_attachment.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_bug_comment.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_bug_detail.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_connection.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_product.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_task.dart';
import 'package:work_tracker/features/zentao/domain/zentao_repository.dart';

/// Minimal hand-written fake, matching the style of
/// `FakeWorkScheduleRepository` in
/// `test/features/schedule/presentation/cubit/setting_schedule_cubit_test.dart`.
/// No mocktail/bloc_test dependency is present in pubspec.yaml yet, and both
/// interfaces faked here are small enough that a fake is straightforward and
/// does not require adding a new dependency.
class FakeTaskDao implements TaskDao {
  final Map<int, TaskEntity> _store = {};
  int _nextId = 1;

  @override
  TaskEntity insert(TaskEntity entity) {
    entity.id = _nextId++;
    _store[entity.id] = entity;
    return entity;
  }

  @override
  void update(TaskEntity entity) => _store[entity.id] = entity;

  @override
  List<TaskEntity> getAll() => _store.values.toList();

  @override
  TaskEntity? getById(int id) => _store[id];

  @override
  TaskEntity? findByZentaoBugId(int bugId) {
    for (final entity in _store.values) {
      if (entity.zentaoBugId == bugId) return entity;
    }
    return null;
  }

  @override
  void remove(int id) => _store.remove(id);
}

/// Fakes only `refreshTask`, the single `ZentaoRepository` method
/// `TaskRepositoryImpl` actually calls. The rest throw if ever hit, so a test
/// accidentally depending on unfaked behavior fails loudly instead of
/// silently returning nonsense.
class FakeZentaoRepository implements ZentaoRepository {
  FakeZentaoRepository({this.refreshTaskResult});

  ZentaoTask? refreshTaskResult;
  int refreshTaskCallCount = 0;
  int? lastRefreshedTaskId;

  @override
  Future<ZentaoTask?> refreshTask(int zentaoTaskId) async {
    refreshTaskCallCount++;
    lastRefreshedTaskId = zentaoTaskId;
    return refreshTaskResult;
  }

  @override
  Future<bool> connect({
    required String domain,
    required String account,
    required String password,
  }) => throw UnimplementedError();

  @override
  Future<ZentaoConnection?> getConnection() => throw UnimplementedError();

  @override
  Future<void> disconnect() => throw UnimplementedError();

  @override
  Future<List<ZentaoProduct>> getProducts() => throw UnimplementedError();

  @override
  Future<List<ZentaoTask>> getAssignedTasks(int productId) =>
      throw UnimplementedError();

  @override
  Future<List<ZentaoBug>> getAssignedBugs(int productId) =>
      throw UnimplementedError();

  ZentaoBug? refreshBugResult;
  int refreshBugCallCount = 0;

  @override
  Future<ZentaoBug?> refreshBug(int zentaoBugId) async {
    refreshBugCallCount++;
    return refreshBugResult;
  }

  ZentaoBugDetail? bugDetailResult;
  int getBugDetailCallCount = 0;
  int? lastBugDetailId;

  @override
  Future<ZentaoBugDetail?> getBugDetail(int zentaoBugId) async {
    getBugDetailCallCount++;
    lastBugDetailId = zentaoBugId;
    return bugDetailResult;
  }

  @override
  Future<File> downloadAttachment(ZentaoBugAttachment attachment) =>
      throw UnimplementedError();

  bool confirmBugShouldThrow = false;
  int confirmBugCallCount = 0;
  int? lastConfirmBugId;
  int? lastConfirmPri;

  @override
  Future<void> confirmBug(int bugId, {int? pri}) async {
    confirmBugCallCount++;
    lastConfirmBugId = bugId;
    lastConfirmPri = pri;
    if (confirmBugShouldThrow) throw Exception('confirm failed');
  }

  bool resolveBugShouldThrow = false;
  int resolveBugCallCount = 0;
  int? lastResolveBugId;
  String? lastResolveResolution;
  String? lastResolveBuild;
  String? lastResolveAssignedTo;
  String? lastResolveComment;

  @override
  Future<void> resolveBug(
    int bugId, {
    required String resolution,
    required String resolvedBuild,
    required DateTime resolvedDate,
    required String assignedTo,
    required String comment,
  }) async {
    resolveBugCallCount++;
    lastResolveBugId = bugId;
    lastResolveResolution = resolution;
    lastResolveBuild = resolvedBuild;
    lastResolveAssignedTo = assignedTo;
    lastResolveComment = comment;
    if (resolveBugShouldThrow) throw Exception('resolve failed');
  }

  bool closeBugShouldThrow = false;
  int closeBugCallCount = 0;
  int? lastCloseBugId;

  @override
  Future<void> closeBug(int bugId, {String comment = ''}) async {
    closeBugCallCount++;
    lastCloseBugId = bugId;
    if (closeBugShouldThrow) throw Exception('close failed');
  }

  bool activateBugShouldThrow = false;
  int activateBugCallCount = 0;
  int? lastActivateBugId;

  @override
  Future<void> activateBug(int bugId, {String comment = ''}) async {
    activateBugCallCount++;
    lastActivateBugId = bugId;
    if (activateBugShouldThrow) throw Exception('activate failed');
  }
}

/// Captures the segments the repository attributes to per-day logs so tests
/// can assert the timer paths record time. Only [recordSegment] is exercised.
class FakeTaskTimeLogRepository implements TaskTimeLogRepository {
  final List<({int taskId, DateTime start, DateTime end})> recorded = [];

  @override
  Future<void> recordSegment(int taskId, DateTime start, DateTime end) async {
    recorded.add((taskId: taskId, start: start, end: end));
  }

  @override
  Future<void> addEntry(int taskId, DateTime day, int seconds) =>
      throw UnimplementedError();

  @override
  Future<void> deleteEntry(int logId) => throw UnimplementedError();

  @override
  Future<void> updateSeconds(int logId, int newSeconds) =>
      throw UnimplementedError();

  @override
  Future<List<TaskTimeLog>> getAll() => throw UnimplementedError();

  @override
  Future<List<TaskTimeLog>> getByDay(DateTime day) =>
      throw UnimplementedError();

  @override
  Future<List<TaskTimeSession>> getSessionsForDay(DateTime day) =>
      throw UnimplementedError();

  @override
  Stream<void> watchTimeLogsChanges() => const Stream.empty();
}

void main() {
  late FakeTaskDao dao;
  late FakeZentaoRepository zentaoRepository;
  late FakeTaskTimeLogRepository timeLogRepository;
  late TaskRepositoryImpl repository;

  setUp(() {
    dao = FakeTaskDao();
    zentaoRepository = FakeZentaoRepository();
    timeLogRepository = FakeTaskTimeLogRepository();
    repository = TaskRepositoryImpl(dao, zentaoRepository, timeLogRepository);
  });

  group('createManual', () {
    test('creates an unlinked, not-done task with zero elapsed time', () async {
      final task = await repository.createManual(
        title: 'Write report',
        description: 'Q3 summary',
      );

      expect(task.title, 'Write report');
      expect(task.description, 'Q3 summary');
      expect(task.done, isFalse);
      expect(task.zentaoTaskId, isNull);
      expect(task.zentaoStatus, isNull);
      expect(task.zentaoLastSyncedAt, isNull);
      expect(task.elapsedSeconds, 0);
      expect(task.timerStartedAt, isNull);

      // Actually persisted, not just returned.
      expect(dao.getAll(), hasLength(1));
      expect(dao.getById(task.id)?.title, 'Write report');
    });

    test('description defaults to null when omitted', () async {
      final task = await repository.createManual(title: 'No description');

      expect(task.description, isNull);
    });
  });

  group('importFromZentao', () {
    test('maps a ZentaoTask into a linked Task', () async {
      const zentaoTask = ZentaoTask(
        id: 42,
        name: 'Fix login bug',
        status: 'doing',
      );

      final before = DateTime.now();
      final task = await repository.importFromZentao(zentaoTask);
      final after = DateTime.now();

      expect(task.title, 'Fix login bug');
      expect(task.zentaoTaskId, 42);
      expect(task.zentaoStatus, 'doing');
      expect(task.done, isFalse);
      expect(task.elapsedSeconds, 0);

      // zentaoLastSyncedAt should be set to "now" at import time. Comparing
      // to a [before, after] bracket taken around the call avoids flakiness
      // from asserting exact equality against a separately-computed
      // DateTime.now().
      expect(task.zentaoLastSyncedAt, isNotNull);
      expect(
        task.zentaoLastSyncedAt!.isAfter(before.subtract(const Duration(milliseconds: 1))),
        isTrue,
      );
      expect(
        task.zentaoLastSyncedAt!.isBefore(after.add(const Duration(milliseconds: 1))),
        isTrue,
      );
    });
  });

  group('generic external identity (multi-platform)', () {
    test('a manual task maps to source manual with no external id', () async {
      final task = await repository.createManual(title: 'Plain');
      expect(task.source, TaskSource.manual);
      expect(task.externalId, isNull);
      expect(task.externalType, isNull);
    });

    test('a legacy zentao bug row (no stored source) derives zentao/bug', () async {
      // Simulate a row written before the generic columns existed: only the
      // legacy zentaoBugId is set, taskSource/externalId are null.
      final legacy = TaskEntity(
        title: 'Crash',
        done: false,
        createdAt: DateTime(2026),
        zentaoBugId: 7,
        zentaoStatus: 'active',
        elapsedSeconds: 0,
      );
      dao.insert(legacy);

      final task = (await repository.getById(legacy.id))!;
      expect(task.source, TaskSource.zentao);
      expect(task.externalType, ExternalItemType.bug);
      expect(task.externalId, '7');
    });

    test('importBugFromZentao forward-fills the generic identity', () async {
      await repository.importBugFromZentao(
        const ZentaoBug(id: 7, title: 'Crash', status: 'active'),
      );
      final entity = dao.findByZentaoBugId(7)!;
      expect(entity.taskSource, 'zentao');
      expect(entity.externalId, '7');
      expect(entity.externalType, 'bug');

      final task = (await repository.getById(entity.id))!;
      expect(task.source, TaskSource.zentao);
      expect(task.externalType, ExternalItemType.bug);
      expect(task.externalId, '7');
    });

    test('importFromZentao forward-fills a task-type identity', () async {
      final task = await repository.importFromZentao(
        const ZentaoTask(id: 42, name: 'Fix login', status: 'doing'),
      );
      expect(task.source, TaskSource.zentao);
      expect(task.externalType, ExternalItemType.task);
      expect(task.externalId, '42');
    });
  });

  group('toggleDone', () {
    test('flips done on the target task only', () async {
      final taskA = await repository.createManual(title: 'A');
      final taskB = await repository.createManual(title: 'B');

      await repository.toggleDone(taskA.id);

      expect((await repository.getById(taskA.id))!.done, isTrue);
      expect((await repository.getById(taskB.id))!.done, isFalse);

      await repository.toggleDone(taskA.id);

      expect((await repository.getById(taskA.id))!.done, isFalse);
    });

    test('is a no-op for an unknown id', () async {
      final taskA = await repository.createManual(title: 'A');

      await repository.toggleDone(9999);

      expect((await repository.getById(taskA.id))!.done, isFalse);
    });
  });

  group('startTimer / stopTimer', () {
    test('startTimer sets timerStartedAt', () async {
      final task = await repository.createManual(title: 'Timed task');

      await repository.startTimer(task.id);

      final entity = dao.getById(task.id)!;
      expect(entity.timerStartedAt, isNotNull);
      expect(entity.elapsedSeconds, 0);
    });

    test('startTimer is a no-op if already running (does not reset the start time)', () async {
      final task = await repository.createManual(title: 'Timed task');
      await repository.startTimer(task.id);
      final firstStartedAt = dao.getById(task.id)!.timerStartedAt;

      await repository.startTimer(task.id);

      expect(dao.getById(task.id)!.timerStartedAt, firstStartedAt);
    });

    test('stopTimer accumulates elapsed time based on the running duration', () async {
      final task = await repository.createManual(title: 'Timed task');
      await repository.startTimer(task.id);

      // Simulate 5 seconds having passed by rewinding the stored
      // timerStartedAt into the past, rather than a real 5-second sleep.
      final entity = dao.getById(task.id)!;
      entity.timerStartedAt = DateTime.now().subtract(const Duration(seconds: 5));
      dao.update(entity);

      await repository.stopTimer(task.id);

      final stopped = dao.getById(task.id)!;
      expect(stopped.timerStartedAt, isNull);
      // Tolerant range rather than exact equality: stopTimer's internal
      // DateTime.now() is taken slightly after the 5s offset was written
      // above, so a sliver of extra real time (test execution overhead)
      // can legitimately be included.
      expect(stopped.elapsedSeconds, inInclusiveRange(5, 6));
    });

    test('a second start/stop cycle adds onto the previously accumulated elapsedSeconds', () async {
      final task = await repository.createManual(title: 'Timed task');
      await repository.startTimer(task.id);
      var entity = dao.getById(task.id)!;
      entity.timerStartedAt = DateTime.now().subtract(const Duration(seconds: 5));
      dao.update(entity);
      await repository.stopTimer(task.id);

      await repository.startTimer(task.id);
      entity = dao.getById(task.id)!;
      entity.timerStartedAt = DateTime.now().subtract(const Duration(seconds: 3));
      dao.update(entity);
      await repository.stopTimer(task.id);

      expect(dao.getById(task.id)!.elapsedSeconds, inInclusiveRange(8, 9));
    });

    test('stopTimer records the finalized segment to the per-day time log', () async {
      final task = await repository.createManual(title: 'Timed task');
      await repository.startTimer(task.id);
      final started = DateTime.now().subtract(const Duration(seconds: 5));
      final entity = dao.getById(task.id)!;
      entity.timerStartedAt = started;
      dao.update(entity);

      await repository.stopTimer(task.id);

      expect(timeLogRepository.recorded, hasLength(1));
      final segment = timeLogRepository.recorded.single;
      expect(segment.taskId, task.id);
      expect(segment.start, started);
      expect(segment.end.isAfter(started), isTrue);
    });

    test('watchTasksChanges emits on startTimer and stopTimer', () async {
      final task = await repository.createManual(title: 'Timed task');
      final events = <void>[];
      final sub = repository.watchTasksChanges().listen(events.add);
      addTearDown(sub.cancel);

      await repository.startTimer(task.id);
      await repository.stopTimer(task.id);
      // Let the broadcast microtasks flush.
      await Future<void>.delayed(Duration.zero);

      expect(events.length, greaterThanOrEqualTo(2));
    });

    test('stopTimer is a safe no-op when the timer is not running', () async {
      final task = await repository.createManual(title: 'Never started');

      await repository.stopTimer(task.id);

      final entity = dao.getById(task.id)!;
      expect(entity.timerStartedAt, isNull);
      expect(entity.elapsedSeconds, 0);
    });

    test('stopTimer is a safe no-op for an unknown id', () async {
      await expectLater(repository.stopTimer(9999), completes);
    });

    test('startTimer is a safe no-op for an unknown id', () async {
      await expectLater(repository.startTimer(9999), completes);
    });
  });

  group('importBugFromZentao', () {
    test('maps title to plain title, computes priority, keeps raw fields', () async {
      const bug = ZentaoBug(
        id: 7,
        title: 'Crash on save',
        status: 'active',
        description: 'Steps to reproduce…',
        priority: 2,
        severity: 1,
      );
      const product = ZentaoProduct(id: 3, name: 'Mobile', priority: 5);

      final task = await repository.importBugFromZentao(bug, product: product);

      expect(task.zentaoBugId, 7);
      expect(task.title, 'Crash on save');
      expect(task.description, 'Steps to reproduce…');
      // severity 1 + priority 2 -> avg 1.5 -> scaled to 2 (1 = most urgent).
      expect(task.priority, 2);
      expect(task.zentaoStatus, 'active');
      expect(task.zentaoPriority, 2);
      expect(task.zentaoSeverity, 1);
      expect(task.zentaoProductId, 3);
      expect(task.zentaoProductName, 'Mobile');
      expect(task.zentaoProductPriority, 5);
    });

    test('computed task priority spans 1..5 (1 = most urgent)', () async {
      Future<int?> priorityFor(int? severity, int? priority) async {
        final task = await repository.importBugFromZentao(
          ZentaoBug(
            id: DateTime.now().microsecondsSinceEpoch % 100000,
            title: 't',
            status: 'active',
            severity: severity,
            priority: priority,
          ),
        );
        return task.priority;
      }

      expect(await priorityFor(1, 1), 1);
      expect(await priorityFor(2, 2), 2);
      expect(await priorityFor(2, 3), 3);
      expect(await priorityFor(3, 3), 4);
      expect(await priorityFor(4, 4), 5);
      // Only one set -> use it; neither set -> null.
      expect(await priorityFor(4, null), 5);
      expect(await priorityFor(null, null), isNull);
    });
  });

  group('startTimer single global timer', () {
    test('starting one task stops any other running task', () async {
      final a = await repository.createManual(title: 'A');
      final b = await repository.createManual(title: 'B');

      await repository.startTimer(a.id);
      // Rewind A's start so stopping it accumulates a measurable duration.
      final entityA = dao.getById(a.id)!;
      entityA.timerStartedAt = DateTime.now().subtract(const Duration(seconds: 5));
      dao.update(entityA);

      await repository.startTimer(b.id);

      final afterA = dao.getById(a.id)!;
      final afterB = dao.getById(b.id)!;
      // A was auto-stopped and its running segment accumulated.
      expect(afterA.timerStartedAt, isNull);
      expect(afterA.elapsedSeconds, inInclusiveRange(5, 6));
      // Only B is running now.
      expect(afterB.timerStartedAt, isNotNull);
    });
  });

  group('upsertBugFromZentao', () {
    test('inserts a new task the first time a bug is seen', () async {
      const bug = ZentaoBug(id: 7, title: 'Crash', status: 'active', severity: 2);

      final outcome = await repository.upsertBugFromZentao(bug);

      expect(outcome, BugUpsertOutcome.added);
      expect(dao.getAll(), hasLength(1));
      expect(dao.findByZentaoBugId(7)?.zentaoSeverity, 2);
    });

    test('updates Zentao fields but preserves local state on re-sync', () async {
      const bug = ZentaoBug(id: 7, title: 'Crash', status: 'active', severity: 3);
      await repository.upsertBugFromZentao(bug);

      // Simulate local work on the imported task: mark done and log time.
      final entity = dao.findByZentaoBugId(7)!;
      final originalId = entity.id;
      entity.done = true;
      entity.elapsedSeconds = 120;
      entity.timerStartedAt = DateTime(2026);
      dao.update(entity);

      const updatedBug = ZentaoBug(
        id: 7,
        title: 'Crash on save (renamed)',
        status: 'resolved',
        severity: 1,
        priority: 2,
      );
      final outcome = await repository.upsertBugFromZentao(updatedBug);

      expect(outcome, BugUpsertOutcome.updated);
      expect(dao.getAll(), hasLength(1));

      final after = dao.findByZentaoBugId(7)!;
      // Same row, refreshed Zentao fields…
      expect(after.id, originalId);
      expect(after.title, 'Crash on save (renamed)');
      expect(after.zentaoStatus, 'resolved');
      expect(after.zentaoSeverity, 1);
      expect(after.zentaoPriority, 2);
      expect(after.priority, 2);
      // …local state untouched.
      expect(after.done, isTrue);
      expect(after.elapsedSeconds, 120);
      expect(after.timerStartedAt, DateTime(2026));
    });
  });

  group('refreshFromZentao (bug detail enrichment)', () {
    test('maps description/notes/attachments and stamps detailSyncedAt', () async {
      const bug = ZentaoBug(id: 7, title: 'Crash', status: 'active', severity: 3);
      await repository.importBugFromZentao(bug);
      final id = dao.findByZentaoBugId(7)!.id;
      expect(dao.getById(id)!.zentaoDetailSyncedAt, isNull);

      zentaoRepository.bugDetailResult = ZentaoBugDetail(
        bug: const ZentaoBug(
          id: 7,
          title: 'Crash on save',
          status: 'resolved',
          description: 'Full steps here',
          priority: 1,
          severity: 1,
        ),
        comments: [
          ZentaoBugComment(
            actor: 'Alice',
            date: DateTime(2026, 7, 1, 9, 30),
            comment: 'Looking into it',
          ),
        ],
        attachments: const [
          ZentaoBugAttachment(id: 55, title: 'shot.png', fileExtension: 'png'),
        ],
      );

      final refreshed = await repository.refreshFromZentao(id);

      expect(zentaoRepository.lastBugDetailId, 7);
      expect(refreshed.title, 'Crash on save');
      expect(refreshed.description, 'Full steps here');
      expect(refreshed.priority, 1); // sev 1 + pri 1 -> 1
      expect(refreshed.zentaoStatus, 'resolved');
      expect(refreshed.notes, contains('Looking into it'));
      expect(refreshed.notes, contains('Alice'));
      expect(refreshed.attachments, hasLength(1));
      expect(refreshed.attachments.first.id, 55);
      expect(refreshed.attachments.first.title, 'shot.png');
      expect(refreshed.attachments.first.fileExtension, 'png');
      expect(refreshed.zentaoDetailSyncedAt, isNotNull);
    });

    test('returns the task unchanged when the detail fetch fails', () async {
      const bug = ZentaoBug(id: 7, title: 'Crash', status: 'active');
      await repository.importBugFromZentao(bug);
      final id = dao.findByZentaoBugId(7)!.id;

      zentaoRepository.bugDetailResult = null; // simulated failure

      final result = await repository.refreshFromZentao(id);

      expect(zentaoRepository.getBugDetailCallCount, 1);
      expect(result.zentaoDetailSyncedAt, isNull);
      expect(result.notes, isNull);
    });
  });

  group('refreshFromZentao', () {
    test('updates zentaoStatus and zentaoLastSyncedAt from the repository result', () async {
      const zentaoTask = ZentaoTask(id: 42, name: 'Fix login bug', status: 'doing');
      final imported = await repository.importFromZentao(zentaoTask);
      final originalSyncedAt = imported.zentaoLastSyncedAt;

      zentaoRepository.refreshTaskResult = const ZentaoTask(
        id: 42,
        name: 'Fix login bug',
        status: 'done',
      );

      // Ensure the "now" captured by refreshFromZentao is measurably later
      // than the one captured at import time.
      await Future<void>.delayed(const Duration(milliseconds: 5));

      final refreshed = await repository.refreshFromZentao(imported.id);

      expect(zentaoRepository.lastRefreshedTaskId, 42);
      expect(refreshed.zentaoStatus, 'done');
      expect(refreshed.zentaoLastSyncedAt, isNotNull);
      expect(refreshed.zentaoLastSyncedAt!.isAfter(originalSyncedAt!), isTrue);
    });

    test('is a no-op that returns the task unchanged when not linked to Zentao', () async {
      final task = await repository.createManual(title: 'Plain task');

      final result = await repository.refreshFromZentao(task.id);

      expect(result.zentaoStatus, isNull);
      expect(result.zentaoLastSyncedAt, isNull);
      expect(zentaoRepository.refreshTaskCallCount, 0);
    });

    test('leaves zentaoStatus/zentaoLastSyncedAt unchanged when refreshTask returns null', () async {
      const zentaoTask = ZentaoTask(id: 42, name: 'Fix login bug', status: 'doing');
      final imported = await repository.importFromZentao(zentaoTask);

      zentaoRepository.refreshTaskResult = null; // simulated fetch failure

      final result = await repository.refreshFromZentao(imported.id);

      expect(zentaoRepository.refreshTaskCallCount, 1);
      expect(result.zentaoStatus, 'doing');
      expect(result.zentaoLastSyncedAt, imported.zentaoLastSyncedAt);
    });

    test('throws for an unknown task id', () async {
      expect(
        () => repository.refreshFromZentao(9999),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('confirmZentaoBug', () {
    test('is a no-op for a non-bug task', () async {
      final task = await repository.createManual(title: 'Manual');

      await repository.confirmZentaoBug(task.id);

      expect(zentaoRepository.confirmBugCallCount, 0);
    });

    test('is a no-op when the bug is already confirmed', () async {
      final task = await repository.importBugFromZentao(
        const ZentaoBug(id: 7, title: 'Crash', status: 'active', confirmed: true),
      );

      await repository.confirmZentaoBug(task.id);

      expect(zentaoRepository.confirmBugCallCount, 0);
      expect(dao.getById(task.id)?.zentaoConfirmed, isTrue);
    });

    test('confirms via the repository and flips the local flag on success', () async {
      final task = await repository.importBugFromZentao(
        const ZentaoBug(id: 7, title: 'Crash', status: 'active', priority: 2),
      );
      expect(dao.getById(task.id)?.zentaoConfirmed, isFalse);

      await repository.confirmZentaoBug(task.id);

      expect(zentaoRepository.confirmBugCallCount, 1);
      expect(zentaoRepository.lastConfirmBugId, 7);
      expect(zentaoRepository.lastConfirmPri, 2);
      expect(dao.getById(task.id)?.zentaoConfirmed, isTrue);
    });

    test('propagates the error and leaves the flag unset on failure', () async {
      final task = await repository.importBugFromZentao(
        const ZentaoBug(id: 7, title: 'Crash', status: 'active'),
      );
      zentaoRepository.confirmBugShouldThrow = true;

      await expectLater(
        repository.confirmZentaoBug(task.id),
        throwsA(isA<Exception>()),
      );
      expect(dao.getById(task.id)?.zentaoConfirmed, isFalse);
    });
  });

  group('resolveZentaoBug', () {
    test('resolves with fixed/trunk/opener + tracked-time comment, then marks done', () async {
      final task = await repository.importBugFromZentao(
        const ZentaoBug(
          id: 7,
          title: 'Crash',
          status: 'active',
          openedByAccount: 'creator_acc',
        ),
      );
      // 83 minutes of tracked time -> "1h 23m".
      dao.getById(task.id)!.elapsedSeconds = 83 * 60;

      final result = await repository.resolveZentaoBug(task.id);

      expect(zentaoRepository.resolveBugCallCount, 1);
      expect(zentaoRepository.lastResolveBugId, 7);
      expect(zentaoRepository.lastResolveResolution, 'fixed');
      expect(zentaoRepository.lastResolveBuild, 'trunk');
      expect(zentaoRepository.lastResolveAssignedTo, 'creator_acc');
      expect(zentaoRepository.lastResolveComment, 'Tracked time: 1h 23m');
      // Local state finalized only on success.
      expect(result.done, isTrue);
      expect(result.zentaoStatus, 'resolved');
      expect(result.timerStartedAt, isNull);
    });

    test('stops a running timer as part of resolving', () async {
      final task = await repository.importBugFromZentao(
        const ZentaoBug(
          id: 7,
          title: 'Crash',
          status: 'active',
          openedByAccount: 'creator_acc',
        ),
      );
      await repository.startTimer(task.id);
      expect(dao.getById(task.id)?.timerStartedAt, isNotNull);

      final result = await repository.resolveZentaoBug(task.id);

      expect(result.timerStartedAt, isNull);
      expect(result.done, isTrue);
    });

    test('fetches the opener via refreshBug when the entity lacks it', () async {
      final task = await repository.importBugFromZentao(
        const ZentaoBug(id: 7, title: 'Crash', status: 'active'),
      );
      // No openedBy captured locally; the on-demand fetch supplies it.
      zentaoRepository.refreshBugResult = const ZentaoBug(
        id: 7,
        title: 'Crash',
        status: 'active',
        openedByAccount: 'fetched_acc',
      );

      await repository.resolveZentaoBug(task.id);

      expect(zentaoRepository.refreshBugCallCount, 1);
      expect(zentaoRepository.lastResolveAssignedTo, 'fetched_acc');
      expect(dao.getById(task.id)?.zentaoOpenedBy, 'fetched_acc');
    });

    test('throws and leaves the task not-done when the resolve call fails', () async {
      final task = await repository.importBugFromZentao(
        const ZentaoBug(
          id: 7,
          title: 'Crash',
          status: 'active',
          openedByAccount: 'creator_acc',
        ),
      );
      dao.getById(task.id)!.elapsedSeconds = 60;
      zentaoRepository.resolveBugShouldThrow = true;

      await expectLater(
        repository.resolveZentaoBug(task.id),
        throwsA(isA<Exception>()),
      );
      final entity = dao.getById(task.id);
      expect(entity?.done, isFalse);
      expect(entity?.zentaoStatus, 'active');
      expect(entity?.elapsedSeconds, 60); // untouched on failure
    });

    test('throws for a non-bug task', () async {
      final task = await repository.createManual(title: 'Manual');

      await expectLater(
        repository.resolveZentaoBug(task.id),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('planned date', () {
    test('setPlannedDate normalizes to midnight and persists', () async {
      final task = await repository.createManual(title: 'Plan me');

      final updated = await repository.setPlannedDate(
        task.id,
        DateTime(2026, 7, 19, 14, 30),
      );

      expect(updated.plannedDate, DateTime(2026, 7, 19));
      expect(dao.getById(task.id)!.plannedDate, DateTime(2026, 7, 19));
    });

    test('setPlannedDate(null) clears the planned date', () async {
      final task = await repository.createManual(title: 'Plan me');
      await repository.setPlannedDate(task.id, DateTime(2026, 7, 19));

      final cleared = await repository.setPlannedDate(task.id, null);

      expect(cleared.plannedDate, isNull);
    });

    test('getUnplannedOpenTasks excludes done and already-planned tasks', () async {
      final open = await repository.createManual(title: 'Open unplanned');
      final planned = await repository.createManual(title: 'Planned');
      final done = await repository.createManual(title: 'Done');
      await repository.setPlannedDate(planned.id, DateTime(2026, 7, 19));
      await repository.toggleDone(done.id);

      final candidates = await repository.getUnplannedOpenTasks();

      expect(candidates.map((t) => t.id), [open.id]);
    });

    test('setPlannedDateForTasks plans every id in one batch', () async {
      final a = await repository.createManual(title: 'A');
      final b = await repository.createManual(title: 'B');

      await repository.setPlannedDateForTasks(
        [a.id, b.id],
        DateTime(2026, 7, 19, 9),
      );

      expect(dao.getById(a.id)!.plannedDate, DateTime(2026, 7, 19));
      expect(dao.getById(b.id)!.plannedDate, DateTime(2026, 7, 19));
    });

    test('getPlannedTasksForMonth returns only that month\'s planned tasks', () async {
      final a = await repository.createManual(title: 'July');
      final b = await repository.createManual(title: 'August');
      final c = await repository.createManual(title: 'Unplanned');
      await repository.setPlannedDate(a.id, DateTime(2026, 7, 19));
      await repository.setPlannedDate(b.id, DateTime(2026, 8, 1));
      // c left unplanned.

      final july = await repository.getPlannedTasksForMonth(2026, 7);

      expect(july.map((t) => t.id), [a.id]);
      expect(july.single.title, 'July');
      // sanity: c never appears
      expect(july.any((t) => t.id == c.id), isFalse);
    });
  });

  group('closeZentaoBug / reopenZentaoBug', () {
    Future<int> seedResolvedBug() async {
      await repository.upsertBugFromZentao(
        const ZentaoBug(id: 7, title: 'Crash', status: 'resolved'),
      );
      return dao.findByZentaoBugId(7)!.id;
    }

    test('closeZentaoBug closes in Zentao then marks it closed + done', () async {
      final id = await seedResolvedBug();

      final result = await repository.closeZentaoBug(id);

      expect(zentaoRepository.closeBugCallCount, 1);
      expect(zentaoRepository.lastCloseBugId, 7);
      expect(result.zentaoStatus, 'closed');
      expect(result.done, isTrue);
    });

    test('closeZentaoBug finalizes a running timer', () async {
      final id = await seedResolvedBug();
      final entity = dao.getById(id)!;
      final started = DateTime.now().subtract(const Duration(seconds: 5));
      entity.timerStartedAt = started;
      entity.done = false;
      dao.update(entity);
      timeLogRepository.recorded.clear();

      final result = await repository.closeZentaoBug(id);

      expect(result.timerStartedAt, isNull);
      expect(result.elapsedSeconds, inInclusiveRange(5, 6));
      expect(timeLogRepository.recorded, isNotEmpty);
    });

    test('reopenZentaoBug activates in Zentao then reopens locally', () async {
      final id = await seedResolvedBug();

      final result = await repository.reopenZentaoBug(id);

      expect(zentaoRepository.activateBugCallCount, 1);
      expect(zentaoRepository.lastActivateBugId, 7);
      expect(result.zentaoStatus, 'active');
      expect(result.done, isFalse);
      expect(dao.getById(id)!.zentaoConfirmed, isFalse);
    });

    test('closeZentaoBug leaves local state unchanged on Zentao failure', () async {
      final id = await seedResolvedBug();
      zentaoRepository.closeBugShouldThrow = true;

      await expectLater(
        repository.closeZentaoBug(id),
        throwsA(isA<Exception>()),
      );
      expect(dao.getById(id)!.zentaoStatus, 'resolved');
    });

    test('closeZentaoBug throws for a non-bug task', () async {
      final task = await repository.createManual(title: 'Manual');
      await expectLater(
        repository.closeZentaoBug(task.id),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('sync-driven completion (Zentao resolved/closed -> done)', () {
    test('upsertBugFromZentao marks an open task done when status is resolved', () async {
      await repository.upsertBugFromZentao(
        const ZentaoBug(id: 7, title: 'Crash', status: 'active'),
      );
      expect(dao.findByZentaoBugId(7)!.done, isFalse);

      await repository.upsertBugFromZentao(
        const ZentaoBug(id: 7, title: 'Crash', status: 'resolved'),
      );
      expect(dao.findByZentaoBugId(7)!.done, isTrue);
    });

    test('upsertBugFromZentao marks done when status is closed', () async {
      await repository.upsertBugFromZentao(
        const ZentaoBug(id: 7, title: 'Crash', status: 'active'),
      );
      await repository.upsertBugFromZentao(
        const ZentaoBug(id: 7, title: 'Crash', status: 'CLOSED'), // case-insensitive
      );
      expect(dao.findByZentaoBugId(7)!.done, isTrue);
    });

    test('one-way: an active re-sync never un-marks an already-done task', () async {
      await repository.upsertBugFromZentao(
        const ZentaoBug(id: 7, title: 'Crash', status: 'active'),
      );
      final entity = dao.findByZentaoBugId(7)!;
      entity.done = true;
      dao.update(entity);

      await repository.upsertBugFromZentao(
        const ZentaoBug(id: 7, title: 'Crash', status: 'active'),
      );
      expect(dao.findByZentaoBugId(7)!.done, isTrue);
    });

    test('finalizes a running timer when sync marks the task done', () async {
      await repository.upsertBugFromZentao(
        const ZentaoBug(id: 7, title: 'Crash', status: 'active'),
      );
      final entity = dao.findByZentaoBugId(7)!;
      final started = DateTime.now().subtract(const Duration(seconds: 5));
      entity.timerStartedAt = started;
      dao.update(entity);
      timeLogRepository.recorded.clear();

      await repository.upsertBugFromZentao(
        const ZentaoBug(id: 7, title: 'Crash', status: 'resolved'),
      );

      final after = dao.findByZentaoBugId(7)!;
      expect(after.done, isTrue);
      expect(after.timerStartedAt, isNull);
      expect(after.elapsedSeconds, inInclusiveRange(5, 6));
      expect(timeLogRepository.recorded, isNotEmpty);
      expect(timeLogRepository.recorded.last.taskId, after.id);
    });

    test('refreshFromZentao marks a bug task done when the detail is resolved', () async {
      await repository.importBugFromZentao(
        const ZentaoBug(id: 7, title: 'Crash', status: 'active'),
      );
      final id = dao.findByZentaoBugId(7)!.id;
      zentaoRepository.bugDetailResult = const ZentaoBugDetail(
        bug: ZentaoBug(id: 7, title: 'Crash', status: 'resolved'),
        comments: [],
        attachments: [],
      );

      final refreshed = await repository.refreshFromZentao(id);

      expect(refreshed.done, isTrue);
    });

    test('refreshFromZentao marks a task done when its status is done', () async {
      final imported = await repository.importFromZentao(
        const ZentaoTask(id: 42, name: 'Fix login', status: 'doing'),
      );
      expect(imported.done, isFalse);
      zentaoRepository.refreshTaskResult = const ZentaoTask(
        id: 42,
        name: 'Fix login',
        status: 'done',
      );

      final refreshed = await repository.refreshFromZentao(imported.id);

      expect(refreshed.done, isTrue);
    });

    test('a cancelled task is not marked done', () async {
      final imported = await repository.importFromZentao(
        const ZentaoTask(id: 42, name: 'Fix login', status: 'doing'),
      );
      zentaoRepository.refreshTaskResult = const ZentaoTask(
        id: 42,
        name: 'Fix login',
        status: 'cancel',
      );

      final refreshed = await repository.refreshFromZentao(imported.id);

      expect(refreshed.done, isFalse);
    });
  });
}
