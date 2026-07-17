import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/task.dart';
import '../../domain/task_repository.dart';

part 'task_list_state.dart';
part 'task_list_cubit.freezed.dart';

/// How the task list is ordered. Priority uses the computed 1..5 task priority
/// (1 = most urgent); tasks without a priority sort last.
enum TaskSort { createdDesc, priority }

@injectable
class TaskListCubit extends Cubit<TaskListState> {
  TaskListCubit(this._repository) : super(const TaskListState()) {
    load();
  }

  final TaskRepository _repository;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final tasks = await _repository.getAll();
      emit(state.copyWith(isLoading: false, tasks: _sorted(tasks, state.sort)));
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: "Couldn't load tasks — try again.",
        ),
      );
    }
  }

  void setSort(TaskSort sort) {
    emit(state.copyWith(sort: sort, tasks: _sorted(state.tasks, sort)));
  }

  List<Task> _sorted(List<Task> tasks, TaskSort sort) {
    final sorted = [...tasks];
    switch (sort) {
      case TaskSort.createdDesc:
        sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      case TaskSort.priority:
        sorted.sort(_compareByField((t) => t.priority));
    }
    return sorted;
  }

  /// Ascending by the priority field (1 = most urgent first); tasks with a
  /// null field sort last, then fall back to most-recently-created.
  int Function(Task, Task) _compareByField(int? Function(Task) field) {
    return (a, b) {
      final av = field(a);
      final bv = field(b);
      if (av == null && bv == null) return b.createdAt.compareTo(a.createdAt);
      if (av == null) return 1;
      if (bv == null) return -1;
      final cmp = av.compareTo(bv);
      return cmp != 0 ? cmp : b.createdAt.compareTo(a.createdAt);
    };
  }
}
