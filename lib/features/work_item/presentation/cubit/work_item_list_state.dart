part of 'work_item_list_cubit.dart';

@freezed
abstract class WorkItemListState with _$WorkItemListState {
  const factory WorkItemListState({
    @Default(true) bool isLoading,
    @Default(<WorkItem>[]) List<WorkItem> tasks,
    @Default(WorkItemSort.createdDesc) WorkItemSort sort,
    String? errorMessage,
  }) = _WorkItemListState;
}
