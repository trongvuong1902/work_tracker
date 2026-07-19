import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/work_item.dart';
import '../../domain/work_item_repository.dart';

part 'work_item_list_state.dart';
part 'work_item_list_cubit.freezed.dart';

/// How the task list is ordered. Priority uses the computed 1..5 task priority
/// (1 = most urgent); tasks without a priority sort last.
enum WorkItemSort { createdDesc, priority }

@injectable
class WorkItemListCubit extends Cubit<WorkItemListState> {
  WorkItemListCubit(this._repository) : super(const WorkItemListState()) {
    load();
    // Reload whenever any task changes (e.g. a bug sync, timer, or status
    // change elsewhere) so the list reflects synced data on return.
    _changesSub = _repository.watchTasksChanges().listen((_) => load());
  }

  final WorkItemRepository _repository;
  StreamSubscription<void>? _changesSub;

  @override
  Future<void> close() {
    _changesSub?.cancel();
    return super.close();
  }

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

  /// Pull-to-refresh: pull the latest status from Zentao for every linked task,
  /// then reload. Falls through to a plain reload if the server pull fails so
  /// the indicator never hangs.
  Future<void> refreshFromServer() async {
    try {
      await _repository.refreshAllZentaoFromServer();
    } catch (_) {
      // Ignore — reload local data below regardless.
    }
    await load();
  }

  void setSort(WorkItemSort sort) {
    emit(state.copyWith(sort: sort, tasks: _sorted(state.tasks, sort)));
  }

  List<WorkItem> _sorted(List<WorkItem> tasks, WorkItemSort sort) {
    final sorted = [...tasks];
    switch (sort) {
      case WorkItemSort.createdDesc:
        sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      case WorkItemSort.priority:
        sorted.sort(_compareByField((t) => t.priority));
    }
    return sorted;
  }

  /// Ascending by the priority field (1 = most urgent first); tasks with a
  /// null field sort last, then fall back to most-recently-created.
  int Function(WorkItem, WorkItem) _compareByField(int? Function(WorkItem) field) {
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
