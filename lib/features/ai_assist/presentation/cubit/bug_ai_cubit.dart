import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../task/domain/models/task.dart';
import '../../data/ai_client.dart';
import '../../domain/ai_prompt_builder.dart';
import '../../domain/ai_repository.dart';
import '../../domain/ai_target.dart';

part 'bug_ai_state.dart';
part 'bug_ai_cubit.freezed.dart';

/// Drives the "AI fix prompt" bottom sheet: streams a model-generated,
/// platform-tailored fix prompt for [Task]'s linked bug into
/// [BugAiState.text] as it arrives, and caches the detected framework.
@injectable
class BugAiCubit extends Cubit<BugAiState> {
  BugAiCubit(this._repository)
    : super(BugAiState(target: _repository.getTarget()));

  final AiRepository _repository;
  StreamSubscription<String>? _subscription;
  Task? _task;

  /// Generates a prompt for [task] tailored to [target]. Pass no [target] to
  /// reuse the last-selected one (used for the initial run).
  Future<void> generate(Task task, [AiTarget? target]) async {
    _task = task;
    final resolved = target ?? state.target;
    await _subscription?.cancel();
    emit(
      BugAiState(
        target: resolved,
        isStreaming: true,
        framework: _repository.getFramework(),
      ),
    );

    _subscription = _repository.generatePrompt(task, resolved).listen(
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
      onDone: _onDone,
    );
  }

  /// Switches the target platform, persists it as the new default, and
  /// regenerates for the current task.
  Future<void> changeTarget(AiTarget target) async {
    if (target == state.target && state.isStreaming) return;
    await _repository.setTarget(target);
    final task = _task;
    if (task != null) await generate(task, target);
  }

  /// Forgets the cached framework and regenerates so the model re-detects it.
  Future<void> reDetectFramework() async {
    await _repository.clearFramework();
    final task = _task;
    if (task != null) await generate(task, state.target);
  }

  /// Overrides the cached framework with a user-supplied value and regenerates.
  Future<void> setFramework(String framework) async {
    final trimmed = framework.trim();
    if (trimmed.isEmpty) return;
    await _repository.cacheFramework(trimmed);
    final task = _task;
    if (task != null) await generate(task, state.target);
  }

  void _onDone() {
    // First-time detection: the model prefixed a `FRAMEWORK:` marker line —
    // cache it so subsequent generations skip re-detection.
    var framework = state.framework;
    if (framework == null) {
      final detected = parseFrameworkMarker(state.text);
      if (detected != null) {
        framework = detected;
        unawaited(_repository.cacheFramework(detected));
      }
    }
    emit(state.copyWith(isStreaming: false, done: true, framework: framework));
  }

  String _errorMessage(Object error) {
    if (error is AiNotConfiguredException) {
      return _withDebugDetail("AI isn't configured in this build.", error);
    }
    return _withDebugDetail("Couldn't generate a prompt — try again.", error);
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
