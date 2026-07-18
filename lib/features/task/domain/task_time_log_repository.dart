import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../database/task/task_time_log_entity.dart';
import '../../../database/task/task_time_session_entity.dart';
import '../data/task_dao.dart';
import '../data/task_time_log_dao.dart';
import '../data/task_time_session_dao.dart';
import 'models/task_time_log.dart';
import 'models/task_time_session.dart';

/// Per-date time tracking for tasks. The timer path
/// (`TaskRepositoryImpl`) calls [recordSegment] to attribute finalized work to
/// the day(s) it happened; the "Manage task times" screen uses the read and
/// edit methods, which keep each task's cumulative `elapsedSeconds` in sync.
abstract class TaskTimeLogRepository {
  /// Attributes the work segment `[start, end]` to the per-day log(s),
  /// splitting at midnight so each calendar day gets its own portion. Does NOT
  /// touch `elapsedSeconds` — the timer path already updates the task total.
  Future<void> recordSegment(int taskId, DateTime start, DateTime end);

  Future<List<TaskTimeLog>> getAll();

  /// Logs for the calendar day of [day].
  Future<List<TaskTimeLog>> getByDay(DateTime day);

  /// Manually adds [seconds] to [taskId] on [day] (also bumps the task total).
  Future<void> addEntry(int taskId, DateTime day, int seconds);

  /// Sets a log row's seconds to [newSeconds], adjusting the task total by the
  /// delta. Deletes the row when [newSeconds] <= 0.
  Future<void> updateSeconds(int logId, int newSeconds);

  /// Removes a log row, subtracting its seconds from the task total.
  Future<void> deleteEntry(int logId);

  /// The individual work sessions (real start/end clock times) that started on
  /// the calendar day of [day] — used by the daily report.
  Future<List<TaskTimeSession>> getSessionsForDay(DateTime day);

  /// Emits whenever the per-day logs change (record/add/update/delete), so
  /// reactive views can re-read. Emits only on writes, never on reads.
  Stream<void> watchTimeLogsChanges();
}

@LazySingleton(as: TaskTimeLogRepository)
class TaskTimeLogRepositoryImpl implements TaskTimeLogRepository {
  TaskTimeLogRepositoryImpl(this._logDao, this._taskDao, this._sessionDao);

  final TaskTimeLogDao _logDao;
  final TaskDao _taskDao;
  final TaskTimeSessionDao _sessionDao;

  // Broadcast on every write so reactive views (home "Today's tasks") re-read.
  // App-scoped singleton, so it's never closed.
  final _changesController = StreamController<void>.broadcast();

  @override
  Stream<void> watchTimeLogsChanges() => _changesController.stream;

  static DateTime _dayOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  Future<void> recordSegment(int taskId, DateTime start, DateTime end) async {
    if (!end.isAfter(start)) return;
    var cursor = start;
    while (cursor.isBefore(end)) {
      final dayStart = _dayOnly(cursor);
      final nextMidnight = dayStart.add(const Duration(days: 1));
      final segmentEnd = end.isBefore(nextMidnight) ? end : nextMidnight;
      final seconds = segmentEnd.difference(cursor).inSeconds;
      if (seconds > 0) {
        _addSecondsToDay(taskId, dayStart, seconds);
        // Preserve the real clock times for the daily report (one row per day
        // slice for a midnight-spanning segment).
        _sessionDao.put(
          TaskTimeSessionEntity(
            taskId: taskId,
            start: cursor,
            end: segmentEnd,
          ),
        );
      }
      cursor = nextMidnight;
    }
    _changesController.add(null);
  }

  @override
  Future<List<TaskTimeSession>> getSessionsForDay(DateTime day) async =>
      _sessionDao.getByDay(day).map(_toSessionModel).toList();

  TaskTimeSession _toSessionModel(TaskTimeSessionEntity e) => TaskTimeSession(
    id: e.id,
    taskId: e.taskId,
    start: e.start,
    end: e.end,
  );

  void _addSecondsToDay(int taskId, DateTime dayStart, int seconds) {
    final existing = _logDao.findByTaskAndDay(taskId, dayStart);
    if (existing == null) {
      _logDao.put(
        TaskTimeLogEntity(taskId: taskId, day: dayStart, seconds: seconds),
      );
    } else {
      existing.seconds += seconds;
      _logDao.put(existing);
    }
  }

  @override
  Future<List<TaskTimeLog>> getAll() async =>
      _logDao.getAll().map(_toModel).toList();

  @override
  Future<List<TaskTimeLog>> getByDay(DateTime day) async =>
      _logDao.getByDay(_dayOnly(day)).map(_toModel).toList();

  @override
  Future<void> addEntry(int taskId, DateTime day, int seconds) async {
    if (seconds <= 0) return;
    final dayStart = _dayOnly(day);
    _addSecondsToDay(taskId, dayStart, seconds);
    _adjustTaskTotal(taskId, seconds);
    _changesController.add(null);
  }

  @override
  Future<void> updateSeconds(int logId, int newSeconds) async {
    final entity = _logDao.getById(logId);
    if (entity == null) return;
    if (newSeconds <= 0) {
      _adjustTaskTotal(entity.taskId, -entity.seconds);
      _logDao.remove(logId);
      _changesController.add(null);
      return;
    }
    final delta = newSeconds - entity.seconds;
    entity.seconds = newSeconds;
    _logDao.put(entity);
    _adjustTaskTotal(entity.taskId, delta);
    _changesController.add(null);
  }

  @override
  Future<void> deleteEntry(int logId) async {
    final entity = _logDao.getById(logId);
    if (entity == null) return;
    _adjustTaskTotal(entity.taskId, -entity.seconds);
    _logDao.remove(logId);
    _changesController.add(null);
  }

  /// Keeps the task's cumulative total consistent with a manual log edit,
  /// clamped at zero.
  void _adjustTaskTotal(int taskId, int deltaSeconds) {
    final task = _taskDao.getById(taskId);
    if (task == null) return;
    final updated = task.elapsedSeconds + deltaSeconds;
    task.elapsedSeconds = updated < 0 ? 0 : updated;
    _taskDao.update(task);
  }

  TaskTimeLog _toModel(TaskTimeLogEntity e) =>
      TaskTimeLog(id: e.id, taskId: e.taskId, day: e.day, seconds: e.seconds);
}
