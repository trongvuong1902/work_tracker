import 'package:flutter_test/flutter_test.dart';
import 'package:work_tracker/database/work_item/work_item_entity.dart';
import 'package:work_tracker/database/work_item/work_item_time_log_entity.dart';
import 'package:work_tracker/database/work_item/work_item_time_session_entity.dart';
import 'package:work_tracker/features/work_item/data/work_item_dao.dart';
import 'package:work_tracker/features/work_item/data/work_item_time_log_dao.dart';
import 'package:work_tracker/features/work_item/data/work_item_time_session_dao.dart';
import 'package:work_tracker/features/work_item/domain/work_item_time_log_repository.dart';

class FakeTaskTimeLogDao implements WorkItemTimeLogDao {
  final Map<int, WorkItemTimeLogEntity> store = {};
  int _nextId = 1;

  @override
  List<WorkItemTimeLogEntity> getAll() => store.values.toList();

  @override
  List<WorkItemTimeLogEntity> getByDay(DateTime day) =>
      store.values.where((e) => e.day == day).toList();

  @override
  WorkItemTimeLogEntity? findByTaskAndDay(int taskId, DateTime day) {
    for (final e in store.values) {
      if (e.taskId == taskId && e.day == day) return e;
    }
    return null;
  }

  @override
  int put(WorkItemTimeLogEntity entity) {
    if (entity.id == 0) entity.id = _nextId++;
    store[entity.id] = entity;
    return entity.id;
  }

  @override
  WorkItemTimeLogEntity? getById(int id) => store[id];

  @override
  void remove(int id) => store.remove(id);

  @override
  void removeForTask(int taskId) =>
      store.removeWhere((_, e) => e.taskId == taskId);
}

class FakeTaskTimeSessionDao implements WorkItemTimeSessionDao {
  final List<WorkItemTimeSessionEntity> store = [];
  int _nextId = 1;

  @override
  List<WorkItemTimeSessionEntity> getAll() => List.of(store);

  @override
  List<WorkItemTimeSessionEntity> getByDay(DateTime day) {
    final dayStart = DateTime(day.year, day.month, day.day);
    final nextMidnight = dayStart.add(const Duration(days: 1));
    return store
        .where((e) => !e.start.isBefore(dayStart) && e.start.isBefore(nextMidnight))
        .toList();
  }

  @override
  int put(WorkItemTimeSessionEntity entity) {
    if (entity.id == 0) entity.id = _nextId++;
    store.removeWhere((e) => e.id == entity.id);
    store.add(entity);
    return entity.id;
  }

  @override
  void removeForTask(int taskId) =>
      store.removeWhere((e) => e.taskId == taskId);
}

class FakeTaskDao implements WorkItemDao {
  final Map<int, WorkItemEntity> store = {};

  @override
  WorkItemEntity? getById(int id) => store[id];

  @override
  void update(WorkItemEntity entity) => store[entity.id] = entity;

  // Unused by WorkItemTimeLogRepositoryImpl.
  @override
  WorkItemEntity insert(WorkItemEntity entity) => throw UnimplementedError();
  @override
  List<WorkItemEntity> getAll() => throw UnimplementedError();
  @override
  WorkItemEntity? findByZentaoBugId(int bugId) => throw UnimplementedError();
  @override
  void remove(int id) => throw UnimplementedError();
}

WorkItemEntity _task(int id, int elapsed) {
  final e = WorkItemEntity(
    title: 'T$id',
    done: false,
    createdAt: DateTime(2026, 1, 1),
    elapsedSeconds: elapsed,
  );
  e.id = id;
  return e;
}

void main() {
  late FakeTaskTimeLogDao logDao;
  late FakeTaskDao taskDao;
  late FakeTaskTimeSessionDao sessionDao;
  late WorkItemTimeLogRepositoryImpl repository;

  setUp(() {
    logDao = FakeTaskTimeLogDao();
    taskDao = FakeTaskDao();
    sessionDao = FakeTaskTimeSessionDao();
    repository = WorkItemTimeLogRepositoryImpl(logDao, taskDao, sessionDao);
  });

  group('recordSegment sessions', () {
    test('records a session with the exact start/end', () async {
      final start = DateTime(2026, 7, 18, 9, 0, 0);
      final end = DateTime(2026, 7, 18, 9, 30, 0);

      await repository.recordSegment(1, start, end);

      expect(sessionDao.store, hasLength(1));
      expect(sessionDao.store.single.taskId, 1);
      expect(sessionDao.store.single.start, start);
      expect(sessionDao.store.single.end, end);
    });

    test('splits a midnight-spanning segment into two sessions', () async {
      final start = DateTime(2026, 7, 18, 23, 30, 0);
      final end = DateTime(2026, 7, 19, 0, 30, 0);

      await repository.recordSegment(1, start, end);

      final day18 = sessionDao.getByDay(DateTime(2026, 7, 18));
      final day19 = sessionDao.getByDay(DateTime(2026, 7, 19));
      expect(day18, hasLength(1));
      expect(day18.single.start, start);
      expect(day18.single.end, DateTime(2026, 7, 19));
      expect(day19, hasLength(1));
      expect(day19.single.start, DateTime(2026, 7, 19));
      expect(day19.single.end, end);
    });

    test('getSessionsForDay returns the day\'s sessions', () async {
      await repository.recordSegment(
        1,
        DateTime(2026, 7, 18, 9, 0, 0),
        DateTime(2026, 7, 18, 9, 30, 0),
      );
      final sessions = await repository.getSessionsForDay(DateTime(2026, 7, 18));
      expect(sessions, hasLength(1));
      expect(sessions.single.durationSeconds, 30 * 60);
    });
  });

  group('recordSegment', () {
    test('attributes a same-day segment to one day row', () async {
      final start = DateTime(2026, 7, 18, 9, 0, 0);
      final end = DateTime(2026, 7, 18, 9, 30, 0);

      await repository.recordSegment(1, start, end);

      final logs = logDao.getAll();
      expect(logs, hasLength(1));
      expect(logs.single.taskId, 1);
      expect(logs.single.day, DateTime(2026, 7, 18));
      expect(logs.single.seconds, 30 * 60);
    });

    test('splits a segment that crosses midnight into two day rows', () async {
      final start = DateTime(2026, 7, 18, 23, 30, 0);
      final end = DateTime(2026, 7, 19, 0, 30, 0);

      await repository.recordSegment(1, start, end);

      final day18 = logDao.findByTaskAndDay(1, DateTime(2026, 7, 18));
      final day19 = logDao.findByTaskAndDay(1, DateTime(2026, 7, 19));
      expect(day18?.seconds, 30 * 60);
      expect(day19?.seconds, 30 * 60);
    });

    test('increments an existing same-day row instead of duplicating', () async {
      await repository.recordSegment(
        1,
        DateTime(2026, 7, 18, 9, 0, 0),
        DateTime(2026, 7, 18, 9, 10, 0),
      );
      await repository.recordSegment(
        1,
        DateTime(2026, 7, 18, 14, 0, 0),
        DateTime(2026, 7, 18, 14, 5, 0),
      );

      final logs = logDao.getAll();
      expect(logs, hasLength(1));
      expect(logs.single.seconds, (10 + 5) * 60);
    });

    test('does not touch the task total (timer path owns elapsedSeconds)', () async {
      taskDao.store[1] = _task(1, 100);
      await repository.recordSegment(
        1,
        DateTime(2026, 7, 18, 9, 0, 0),
        DateTime(2026, 7, 18, 9, 30, 0),
      );
      expect(taskDao.getById(1)!.elapsedSeconds, 100);
    });
  });

  group('edits keep the task total in sync', () {
    test('addEntry adds seconds to both the log and the task total', () async {
      taskDao.store[1] = _task(1, 100);

      await repository.addEntry(1, DateTime(2026, 7, 18), 600);

      expect(taskDao.getById(1)!.elapsedSeconds, 700);
      expect(logDao.findByTaskAndDay(1, DateTime(2026, 7, 18))?.seconds, 600);
    });

    test('updateSeconds adjusts the task total by the delta', () async {
      taskDao.store[1] = _task(1, 1000);
      final logId = logDao.put(
        WorkItemTimeLogEntity(taskId: 1, day: DateTime(2026, 7, 18), seconds: 600),
      );

      await repository.updateSeconds(logId, 900);

      expect(logDao.getById(logId)!.seconds, 900);
      expect(taskDao.getById(1)!.elapsedSeconds, 1300); // 1000 + (900 - 600)
    });

    test('updateSeconds to zero deletes the row and subtracts its time', () async {
      taskDao.store[1] = _task(1, 1000);
      final logId = logDao.put(
        WorkItemTimeLogEntity(taskId: 1, day: DateTime(2026, 7, 18), seconds: 600),
      );

      await repository.updateSeconds(logId, 0);

      expect(logDao.getById(logId), isNull);
      expect(taskDao.getById(1)!.elapsedSeconds, 400);
    });

    test('deleteEntry subtracts its seconds from the task total', () async {
      taskDao.store[1] = _task(1, 1000);
      final logId = logDao.put(
        WorkItemTimeLogEntity(taskId: 1, day: DateTime(2026, 7, 18), seconds: 600),
      );

      await repository.deleteEntry(logId);

      expect(logDao.getById(logId), isNull);
      expect(taskDao.getById(1)!.elapsedSeconds, 400);
    });

    test('the task total never goes negative', () async {
      taskDao.store[1] = _task(1, 100);
      final logId = logDao.put(
        WorkItemTimeLogEntity(taskId: 1, day: DateTime(2026, 7, 18), seconds: 600),
      );

      await repository.deleteEntry(logId);

      expect(taskDao.getById(1)!.elapsedSeconds, 0);
    });
  });
}
