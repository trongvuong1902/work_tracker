part of 'task_list_cubit.dart';

@freezed
abstract class TaskListState with _$TaskListState {
  const factory TaskListState({
    @Default(true) bool isLoading,
    @Default(<Task>[]) List<Task> tasks,
    @Default(TaskSort.createdDesc) TaskSort sort,
    String? errorMessage,
  }) = _TaskListState;
}
