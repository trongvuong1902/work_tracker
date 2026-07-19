part of 'today_work_items_cubit.dart';

/// One row in the "Today's tasks" list: the task and the seconds worked on it
/// today (logged today + any live running portion at emit time).
class TodayWorkItem {
  const TodayWorkItem({required this.task, required this.seconds});

  final WorkItem task;
  final int seconds;
}

@freezed
abstract class TodayWorkItemsState with _$TodayWorkItemsState {
  const factory TodayWorkItemsState({
    @Default(true) bool isLoading,
    @Default(<TodayWorkItem>[]) List<TodayWorkItem> items,
  }) = _TodayWorkItemsState;
}
