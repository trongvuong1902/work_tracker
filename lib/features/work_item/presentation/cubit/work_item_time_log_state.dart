part of 'work_item_time_log_cubit.dart';

/// One editable timesheet row: a task's time log for a given day.
class TaskTimeEntry {
  const TaskTimeEntry({
    required this.logId,
    required this.taskId,
    required this.title,
    required this.seconds,
  });

  final int logId;
  final int taskId;
  final String title;
  final int seconds;
}

/// A day's worth of time entries plus the daily total.
class TaskTimeDayGroup {
  const TaskTimeDayGroup({
    required this.day,
    required this.entries,
    required this.totalSeconds,
  });

  final DateTime day;
  final List<TaskTimeEntry> entries;
  final int totalSeconds;
}

@freezed
abstract class WorkItemTimeLogState with _$WorkItemTimeLogState {
  const factory WorkItemTimeLogState({
    @Default(true) bool isLoading,
    @Default(<TaskTimeDayGroup>[]) List<TaskTimeDayGroup> groups,
    @Default(<WorkItem>[]) List<WorkItem> tasks,
    String? errorMessage,
  }) = _WorkItemTimeLogState;
}
