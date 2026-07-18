import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../task/domain/models/task.dart';
import '../../domain/ai_repository.dart';
import '../../data/ai_client.dart';

part 'bug_ai_state.dart';
part 'bug_ai_cubit.freezed.dart';

/// Drives the "Resolve with AI" bottom sheet: streams Claude's diagnosis of
/// [Task]'s linked bug into [BugAiState.text] as it arrives.
@injectable
class BugAiCubit extends Cubit<BugAiState> {
  BugAiCubit(this._repository) : super(const BugAiState());

  final AiRepository _repository;
  StreamSubscription<String>? _subscription;

  Future<void> resolve(Task task) async {
    await _subscription?.cancel();
    emit(const BugAiState(isStreaming: true));

    _subscription = _repository.resolveBug(task).listen(
      (delta) => emit(state.copyWith(text: state.text + delta)),
      onError: (Object e) {
        emit(
          state.copyWith(
            isStreaming: false,
            done: true,
            errorMessage: _errorMessage(e),
          ),
        );
      },
      onDone: () => emit(state.copyWith(isStreaming: false, done: true)),
    );
  }

  String _errorMessage(Object error) {
    if (error is AiNotConfiguredException) {
      return _withDebugDetail("AI isn't configured in this build.", error);
    }
    return _withDebugDetail("Couldn't get an AI resolution — try again.", error);
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}

/// Appends the real exception in debug builds only (mirrors `BugSyncCubit`)
/// so failures are diagnosable without device logs.
String _withDebugDetail(String message, Object error) =>
    kDebugMode ? '$message ($error)' : message;
