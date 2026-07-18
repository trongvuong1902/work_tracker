import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/task.dart';
import '../../domain/models/task_time_log.dart';
import '../../domain/task_repository.dart';
import '../../domain/task_time_log_repository.dart';

part 'task_time_log_state.dart';
part 'task_time_log_cubit.freezed.dart';

/// Backs the "Manage task times" timesheet: all per-day time logs grouped by
/// date (newest first), with edit/add/delete that keep each task total in sync.
@injectable
class TaskTimeLogCubit extends Cubit<TaskTimeLogState> {
  TaskTimeLogCubit(this._timeLogRepository, this._taskRepository)
    : super(const TaskTimeLogState());

  final TaskTimeLogRepository _timeLogRepository;
  final TaskRepository _taskRepository;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final logs = await _timeLogRepository.getAll();
      final tasks = await _taskRepository.getAll();
      final titles = {for (final t in tasks) t.id: t.title};

      // Group by day-normalized value.
      final byDay = <DateTime, List<TaskTimeLog>>{};
      for (final log in logs) {
        final day = DateTime(log.day.year, log.day.month, log.day.day);
        byDay.putIfAbsent(day, () => []).add(log);
      }

      final groups = byDay.entries.map((entry) {
        final entries =
            entry.value
                .map(
                  (log) => TaskTimeEntry(
                    logId: log.id,
                    taskId: log.taskId,
                    title: titles[log.taskId] ?? 'Task #${log.taskId}',
                    seconds: log.seconds,
                  ),
                )
                .toList()
              ..sort((a, b) => b.seconds.compareTo(a.seconds));
        final total = entries.fold<int>(0, (sum, e) => sum + e.seconds);
        return TaskTimeDayGroup(
          day: entry.key,
          entries: entries,
          totalSeconds: total,
        );
      }).toList()..sort((a, b) => b.day.compareTo(a.day));

      emit(
        state.copyWith(isLoading: false, groups: groups, tasks: tasks),
      );
    } catch (e) {
      debugPrint('Failed to load task time logs: $e');
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: "Couldn't load task times.",
        ),
      );
    }
  }

  Future<void> editEntry(int logId, int seconds) async {
    await _timeLogRepository.updateSeconds(logId, seconds);
    await load();
  }

  Future<void> deleteEntry(int logId) async {
    await _timeLogRepository.deleteEntry(logId);
    await load();
  }

  Future<void> addEntry(int taskId, DateTime day, int seconds) async {
    await _timeLogRepository.addEntry(taskId, day, seconds);
    await load();
  }
}
