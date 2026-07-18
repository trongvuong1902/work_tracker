part of 'task_detail_cubit.dart';

@freezed
abstract class TaskDetailState with _$TaskDetailState {
  const factory TaskDetailState({
    @Default(true) bool isLoading,
    Task? task,
    @Default(false) bool isTogglingDone,
    @Default(false) bool isTogglingTimer,
    @Default(false) bool isRefreshing,
    // True while a Zentao bug status change (resolve/close/reopen) is in flight.
    @Default(false) bool isChangingStatus,
    // True while the bug's full detail (description/notes/attachments) is being
    // fetched and persisted on first open.
    @Default(false) bool isEnriching,
    String? errorMessage,
    // Bumped every second while the timer runs purely to force a rebuild —
    // not read by anything, the live elapsed time itself is recomputed via
    // `Task.currentElapsedSeconds()` in the widget.
    @Default(0) int tick,
  }) = _TaskDetailState;
}
