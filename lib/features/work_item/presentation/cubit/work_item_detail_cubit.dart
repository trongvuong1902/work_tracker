import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/work_item.dart';
import '../../domain/work_item_repository.dart';

part 'work_item_detail_state.dart';
part 'work_item_detail_cubit.freezed.dart';

/// A Zentao bug status transition the user can trigger from the detail page.
enum BugStatusAction { resolve, close, reopen }

@injectable
class WorkItemDetailCubit extends Cubit<WorkItemDetailState> {
  WorkItemDetailCubit(this._repository) : super(const WorkItemDetailState());

  final WorkItemRepository _repository;
  Timer? _ticker;

  Future<void> load(int id) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final task = await _repository.getById(id);
    emit(state.copyWith(isLoading: false, task: task));
    _syncTicker();
    await _maybeEnrichBugDetail(task);
  }

  /// On first open of a bug task (its full detail — description/notes/
  /// attachments — hasn't been fetched yet), pull and persist it, then reload.
  Future<void> _maybeEnrichBugDetail(WorkItem? task) async {
    if (task == null || !task.isLinkedToZentaoBug) return;
    if (task.zentaoDetailSyncedAt != null) return;
    emit(state.copyWith(isEnriching: true));
    try {
      final updated = await _repository.refreshFromZentao(task.id);
      emit(state.copyWith(isEnriching: false, task: updated));
    } catch (_) {
      emit(state.copyWith(isEnriching: false));
    }
  }

  Future<void> toggleDone() async {
    final task = state.task;
    if (task == null) return;

    // A bug-linked task mirrors its Done state to Zentao both ways: marking Done
    // resolves the bug, un-marking reopens it. The server call runs first; only
    // on success is local state updated. A failure leaves it unchanged so the
    // user can retry.
    if (task.isLinkedToZentaoBug) {
      emit(state.copyWith(isTogglingDone: true, errorMessage: null));
      try {
        final updated = task.done
            ? await _repository.reopenZentaoBug(task.id)
            : await _repository.resolveZentaoBug(task.id);
        emit(state.copyWith(isTogglingDone: false, task: updated));
        _syncTicker();
      } catch (_) {
        emit(
          state.copyWith(
            isTogglingDone: false,
            errorMessage: task.done
                ? "Couldn't reopen in Zentao — try again."
                : "Couldn't resolve in Zentao — try again.",
          ),
        );
      }
      return;
    }

    emit(state.copyWith(isTogglingDone: true));
    await _repository.toggleDone(task.id);
    final updated = await _repository.getById(task.id);
    emit(state.copyWith(isTogglingDone: false, task: updated));
  }

  Future<void> toggleTimer() async {
    final task = state.task;
    if (task == null) return;
    emit(state.copyWith(isTogglingTimer: true, errorMessage: null));
    if (task.isTimerRunning) {
      await _repository.stopTimer(task.id);
    } else {
      // Starting a bug-linked task confirms the bug in Zentao first; a failed
      // confirm blocks the timer from starting.
      if (task.isLinkedToZentaoBug && !task.zentaoConfirmed) {
        try {
          await _repository.confirmZentaoBug(task.id);
        } catch (_) {
          emit(
            state.copyWith(
              isTogglingTimer: false,
              errorMessage: "Couldn't confirm the bug in Zentao — try again.",
            ),
          );
          return;
        }
      }
      await _repository.startTimer(task.id);
    }
    final updated = await _repository.getById(task.id);
    emit(state.copyWith(isTogglingTimer: false, task: updated));
    _syncTicker();
  }

  /// Changes the linked Zentao bug's status (resolve/close/reopen). On success
  /// the updated task is emitted; on failure the task is left unchanged and an
  /// error message is surfaced.
  Future<void> changeBugStatus(
    BugStatusAction action, {
    int? durationMinutes,
  }) async {
    final task = state.task;
    if (task == null || !task.isLinkedToZentaoBug) return;
    emit(state.copyWith(isChangingStatus: true, errorMessage: null));
    try {
      final updated = switch (action) {
        BugStatusAction.resolve => await _repository.resolveZentaoBug(
          task.id,
          durationMinutes: durationMinutes,
        ),
        BugStatusAction.close => await _repository.closeZentaoBug(task.id),
        BugStatusAction.reopen => await _repository.reopenZentaoBug(task.id),
      };
      emit(state.copyWith(isChangingStatus: false, task: updated));
      _syncTicker();
    } catch (e) {
      emit(
        state.copyWith(
          isChangingStatus: false,
          errorMessage: _statusErrorMessage(action, e),
        ),
      );
    }
  }

  String _statusErrorMessage(BugStatusAction action, Object error) {
    final verb = switch (action) {
      BugStatusAction.resolve => 'resolve',
      BugStatusAction.close => 'close',
      BugStatusAction.reopen => 'reopen',
    };
    // Surface Zentao's own message (e.g. a rejected field) so failures are
    // diagnosable instead of always reading "try again".
    final detail = error.toString().replaceFirst('Exception: ', '');
    return "Couldn't $verb in Zentao: $detail";
  }

  /// Sets or clears the day this task is planned for.
  Future<void> setPlannedDate(DateTime? date) async {
    final task = state.task;
    if (task == null) return;
    final updated = await _repository.setPlannedDate(task.id, date);
    emit(state.copyWith(task: updated));
  }

  Future<void> refreshFromZentao() async {
    final task = state.task;
    if (task == null) return;
    emit(state.copyWith(isRefreshing: true, errorMessage: null));
    try {
      final updated = await _repository.refreshFromZentao(task.id);
      emit(state.copyWith(isRefreshing: false, task: updated));
    } catch (_) {
      emit(
        state.copyWith(
          isRefreshing: false,
          errorMessage: "Couldn't refresh from Zentao — try again.",
        ),
      );
    }
  }

  /// Starts/stops a 1s ticker that bumps `tick` (a no-op counter that only
  /// exists to force a rebuild) while the timer is running, so the elapsed
  /// time display (computed via `WorkItem.currentElapsedSeconds`) stays live.
  void _syncTicker() {
    _ticker?.cancel();
    _ticker = null;
    if (state.task?.isTimerRunning ?? false) {
      _ticker = Timer.periodic(
        const Duration(seconds: 1),
        (_) => emit(state.copyWith(tick: state.tick + 1)),
      );
    }
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    return super.close();
  }
}
