part of 'bug_sync_cubit.dart';

@freezed
abstract class BugSyncState with _$BugSyncState {
  const factory BugSyncState({
    @Default(false) bool isSyncing,
    @Default(false) bool done,
    @Default(0) int added,
    @Default(0) int updated,
    @Default(0) int failedProducts,
    String? progressText,
    String? errorMessage,
  }) = _BugSyncState;
}
