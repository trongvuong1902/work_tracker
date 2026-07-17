import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:work_tracker/database/task/task_entity.dart';
import 'package:work_tracker/features/task/data/task_dao.dart';
import 'package:work_tracker/features/task/domain/task_repository.dart';
import 'package:work_tracker/features/task/domain/task_repository_impl.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_bug.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_bug_attachment.dart';
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

  @override
  Future<ZentaoBug?> refreshBug(int zentaoBugId) => throw UnimplementedError();

  @override
  Future<ZentaoBugDetail?> getBugDetail(int zentaoBugId) =>
      throw UnimplementedError();

  @override
  Future<File> downloadAttachment(ZentaoBugAttachment attachment) =>
      throw UnimplementedError();
}

void main() {
  late FakeTaskDao dao;
  late FakeZentaoRepository zentaoRepository;
  late TaskRepositoryImpl repository;

  setUp(() {
    dao = FakeTaskDao();
    zentaoRepository = FakeZentaoRepository();
    repository = TaskRepositoryImpl(dao, zentaoRepository);
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
    test('persists severity/priority/description and product context', () async {
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
      expect(task.zentaoStatus, 'active');
      expect(task.zentaoPriority, 2);
      expect(task.zentaoSeverity, 1);
      expect(task.zentaoProductId, 3);
      expect(task.zentaoProductName, 'Mobile');
      expect(task.zentaoProductPriority, 5);
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
      // …local state untouched.
      expect(after.done, isTrue);
      expect(after.elapsedSeconds, 120);
      expect(after.timerStartedAt, DateTime(2026));
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
}
