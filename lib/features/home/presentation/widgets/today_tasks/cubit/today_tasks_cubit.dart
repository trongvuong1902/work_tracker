import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../task/domain/models/task.dart';
import '../../../../../task/domain/task_repository.dart';
import '../../../../../task/domain/task_time_log_repository.dart';

part 'today_tasks_state.dart';
part 'today_tasks_cubit.freezed.dart';

/// Backs the home "Today's tasks" section: the tasks worked on today (time
/// logged today plus the currently-running task's live portion). Ticks every
/// second while a timer runs so the elapsed display stays live.
@injectable
class TodayTasksCubit extends Cubit<TodayTasksState> {
  TodayTasksCubit(this._taskRepository, this._timeLogRepository)
    : super(const TodayTasksState());

  final TaskRepository _taskRepository;
  final TaskTimeLogRepository _timeLogRepository;

  Map<int, int> _loggedToday = {};
  List<Task> _tasks = const [];
  Timer? _ticker;
  StreamSubscription<void>? _taskSub;
  StreamSubscription<void>? _logSub;

  Future<void> init() async {
    // Re-read whenever a timer starts/stops or a log is edited anywhere (e.g.
    // the Task Detail or Manage task times pages) — HomePage stays alive in an
    // IndexedStack, so this cubit is never recreated to pick up those changes.
    _taskSub = _taskRepository.watchTasksChanges().listen((_) => _load());
    _logSub = _timeLogRepository.watchTimeLogsChanges().listen((_) => _load());
    await _load();
  }

  /// Reloads from the DB — call after returning from screens that may have
  /// changed timers/logs.
  Future<void> refresh() async {
    await _load();
  }

  Future<void> _load() async {
    try {
      final now = DateTime.now();
      final logs = await _timeLogRepository.getByDay(now);
      _loggedToday = {for (final log in logs) log.taskId: log.seconds};
      _tasks = await _taskRepository.getAll();
      _emitItems();
      _syncTicker();
    } catch (e) {
      debugPrint('Failed to load today tasks: $e');
      emit(state.copyWith(isLoading: false));
    }
  }

  void _emitItems() {
    final now = DateTime.now();
    final todayMidnight = DateTime(now.year, now.month, now.day);

    final items = <TodayTaskItem>[];
    for (final task in _tasks) {
      final logged = _loggedToday[task.id] ?? 0;
      if (logged == 0 && !task.isTimerRunning) continue;
      items.add(
        TodayTaskItem(
          task: task,
          seconds: _displaySeconds(task, logged, now, todayMidnight),
        ),
      );
    }
    // Running task(s) first, then by time worked today (desc).
    items.sort((a, b) {
      final running = (b.task.isTimerRunning ? 1 : 0)
          .compareTo(a.task.isTimerRunning ? 1 : 0);
      if (running != 0) return running;
      return b.seconds.compareTo(a.seconds);
    });

    emit(TodayTasksState(isLoading: false, items: items));
  }

  int _displaySeconds(
    Task task,
    int logged,
    DateTime now,
    DateTime todayMidnight,
  ) {
    final startedAt = task.timerStartedAt;
    if (startedAt == null) return logged;
    final from = startedAt.isAfter(todayMidnight) ? startedAt : todayMidnight;
    final live = now.difference(from).inSeconds;
    return logged + (live > 0 ? live : 0);
  }

  void _syncTicker() {
    _ticker?.cancel();
    _ticker = null;
    if (_tasks.any((t) => t.isTimerRunning)) {
      _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _emitItems());
    }
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    _taskSub?.cancel();
    _logSub?.cancel();
    return super.close();
  }
}
