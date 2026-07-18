import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/task.dart';
import '../../domain/task_repository.dart';

part 'plan_tasks_state.dart';
part 'plan_tasks_cubit.freezed.dart';

/// Backs the "Add tasks to this day" picker: loads the candidate tasks (not
/// done, not yet planned), tracks a multi-selection, and plans them onto a day.
@injectable
class PlanTasksCubit extends Cubit<PlanTasksState> {
  PlanTasksCubit(this._repository) : super(const PlanTasksState());

  final TaskRepository _repository;

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    try {
      final tasks = await _repository.getUnplannedOpenTasks();
      emit(state.copyWith(isLoading: false, candidates: tasks));
    } catch (e) {
      debugPrint('Failed to load unplanned tasks: $e');
      emit(state.copyWith(isLoading: false));
    }
  }

  void toggle(int taskId) {
    final selected = Set<int>.from(state.selectedIds);
    if (!selected.add(taskId)) selected.remove(taskId);
    emit(state.copyWith(selectedIds: selected));
  }

  /// Plans the selected tasks onto [day]. Returns the count planned.
  Future<int> confirm(DateTime day) async {
    final ids = state.selectedIds.toList();
    if (ids.isEmpty) return 0;
    emit(state.copyWith(isSaving: true));
    await _repository.setPlannedDateForTasks(ids, day);
    emit(state.copyWith(isSaving: false));
    return ids.length;
  }
}
