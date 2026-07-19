part of 'plan_work_items_cubit.dart';

@freezed
abstract class PlanWorkItemsState with _$PlanWorkItemsState {
  const factory PlanWorkItemsState({
    @Default(true) bool isLoading,
    @Default(false) bool isSaving,
    @Default(<WorkItem>[]) List<WorkItem> candidates,
    @Default(<int>{}) Set<int> selectedIds,
  }) = _PlanWorkItemsState;
}
