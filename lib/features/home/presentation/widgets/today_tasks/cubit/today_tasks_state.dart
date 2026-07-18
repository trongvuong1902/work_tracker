part of 'today_tasks_cubit.dart';

/// One row in the "Today's tasks" list: the task and the seconds worked on it
/// today (logged today + any live running portion at emit time).
class TodayTaskItem {
  const TodayTaskItem({required this.task, required this.seconds});

  final Task task;
  final int seconds;
}

@freezed
abstract class TodayTasksState with _$TodayTasksState {
  const factory TodayTasksState({
    @Default(true) bool isLoading,
    @Default(<TodayTaskItem>[]) List<TodayTaskItem> items,
  }) = _TodayTasksState;
}
