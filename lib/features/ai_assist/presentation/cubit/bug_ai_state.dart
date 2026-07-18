part of 'bug_ai_cubit.dart';

@freezed
abstract class BugAiState with _$BugAiState {
  const factory BugAiState({
    @Default(AiTarget.claude) AiTarget target,
    @Default(false) bool isStreaming,
    // Raw model output — may include a leading `FRAMEWORK:` marker line while
    // streaming. Use [displayText] for anything user-facing.
    @Default('') String text,
    String? framework,
    @Default(false) bool done,
    String? errorMessage,
  }) = _BugAiState;
}

extension BugAiStateX on BugAiState {
  /// [text] with a leading `FRAMEWORK: <name>` marker line removed — what the
  /// user sees and copies.
  String get displayText => stripFrameworkMarker(text);
}
