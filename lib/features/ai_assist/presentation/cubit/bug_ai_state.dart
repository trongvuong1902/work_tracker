part of 'bug_ai_cubit.dart';

@freezed
abstract class BugAiState with _$BugAiState {
  const factory BugAiState({
    @Default(false) bool isStreaming,
    @Default('') String text,
    @Default(false) bool done,
    String? errorMessage,
  }) = _BugAiState;
}
