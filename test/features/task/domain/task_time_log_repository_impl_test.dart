import 'package:flutter_test/flutter_test.dart';
import 'package:work_tracker/database/task/task_entity.dart';
import 'package:work_tracker/database/task/task_time_log_entity.dart';
import 'package:work_tracker/features/task/data/task_dao.dart';
import 'package:work_tracker/features/task/data/task_time_log_dao.dart';
import 'package:work_tracker/features/task/domain/task_time_log_repository.dart';

class FakeTaskTimeLogDao implements TaskTimeLogDao {
  final Map<int, TaskTimeLogEntity> store = {};
  int _nextId = 1;

  @override
  List<TaskTimeLogEntity> getAll() => store.values.toList();

  @override
  List<TaskTimeLogEntity> getByDay(DateTime day) =>
      store.values.where((e) => e.day == day).toList();

  @override
  TaskTimeLogEntity? findByTaskAndDay(int taskId, DateTime day) {
    for (final e in store.values) {
      if (e.taskId == taskId && e.day == day) return e;
    }
    return null;
  }

  @override
  int put(TaskTimeLogEntity entity) {
    if (entity.id == 0) entity.id = _nextId++;
    store[entity.id] = entity;
    return entity.id;
  }

  @override
  TaskTimeLogEntity? getById(int id) => store[id];

  @override
  void remove(int id) => store.remove(id);

  @override
  void removeForTask(int taskId) =>
      store.removeWhere((_, e) => e.taskId == taskId);
}

class FakeTaskDao implements TaskDao {
  final Map<int, TaskEntity> store = {};

  @override
  TaskEntity? getById(int id) => store[id];

  @override
  void update(TaskEntity entity) => store[entity.id] = entity;

  // Unused by TaskTimeLogRepositoryImpl.
  @override
  TaskEntity insert(TaskEntity entity) => throw UnimplementedError();
  @override
  List<TaskEntity> getAll() => throw UnimplementedError();
  @override
  TaskEntity? findByZentaoBugId(int bugId) => throw UnimplementedError();
  @override
  void remove(int id) => throw UnimplementedError();
}

TaskEntity _task(int id, int elapsed) {
  final e = TaskEntity(
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
  late TaskTimeLogRepositoryImpl repository;

  setUp(() {
    logDao = FakeTaskTimeLogDao();
    taskDao = FakeTaskDao();
    repository = TaskTimeLogRepositoryImpl(logDao, taskDao);
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
        TaskTimeLogEntity(taskId: 1, day: DateTime(2026, 7, 18), seconds: 600),
      );

      await repository.updateSeconds(logId, 900);

      expect(logDao.getById(logId)!.seconds, 900);
      expect(taskDao.getById(1)!.elapsedSeconds, 1300); // 1000 + (900 - 600)
    });

    test('updateSeconds to zero deletes the row and subtracts its time', () async {
      taskDao.store[1] = _task(1, 1000);
      final logId = logDao.put(
        TaskTimeLogEntity(taskId: 1, day: DateTime(2026, 7, 18), seconds: 600),
      );

      await repository.updateSeconds(logId, 0);

      expect(logDao.getById(logId), isNull);
      expect(taskDao.getById(1)!.elapsedSeconds, 400);
    });

    test('deleteEntry subtracts its seconds from the task total', () async {
      taskDao.store[1] = _task(1, 1000);
      final logId = logDao.put(
        TaskTimeLogEntity(taskId: 1, day: DateTime(2026, 7, 18), seconds: 600),
      );

      await repository.deleteEntry(logId);

      expect(logDao.getById(logId), isNull);
      expect(taskDao.getById(1)!.elapsedSeconds, 400);
    });

    test('the task total never goes negative', () async {
      taskDao.store[1] = _task(1, 100);
      final logId = logDao.put(
        TaskTimeLogEntity(taskId: 1, day: DateTime(2026, 7, 18), seconds: 600),
      );

      await repository.deleteEntry(logId);

      expect(taskDao.getById(1)!.elapsedSeconds, 0);
    });
  });
}
