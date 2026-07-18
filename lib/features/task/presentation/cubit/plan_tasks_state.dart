part of 'plan_tasks_cubit.dart';

@freezed
abstract class PlanTasksState with _$PlanTasksState {
  const factory PlanTasksState({
    @Default(true) bool isLoading,
    @Default(false) bool isSaving,
    @Default(<Task>[]) List<Task> candidates,
    @Default(<int>{}) Set<int> selectedIds,
  }) = _PlanTasksState;
}
