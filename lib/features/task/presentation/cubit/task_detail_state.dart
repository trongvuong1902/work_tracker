part of 'task_detail_cubit.dart';

@freezed
abstract class TaskDetailState with _$TaskDetailState {
  const factory TaskDetailState({
    @Default(true) bool isLoading,
    Task? task,
    @Default(false) bool isTogglingDone,
    @Default(false) bool isTogglingTimer,
    @Default(false) bool isRefreshing,
    String? errorMessage,
    // Bumped every second while the timer runs purely to force a rebuild —
    // not read by anything, the live elapsed time itself is recomputed via
    // `Task.currentElapsedSeconds()` in the widget.
    @Default(0) int tick,
  }) = _TaskDetailState;
}
