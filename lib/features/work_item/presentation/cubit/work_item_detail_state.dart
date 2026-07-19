part of 'work_item_detail_cubit.dart';

@freezed
abstract class WorkItemDetailState with _$WorkItemDetailState {
  const factory WorkItemDetailState({
    @Default(true) bool isLoading,
    WorkItem? task,
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
    // `WorkItem.currentElapsedSeconds()` in the widget.
    @Default(0) int tick,
  }) = _WorkItemDetailState;
}
