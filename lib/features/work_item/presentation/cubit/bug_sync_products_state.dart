part of 'bug_sync_products_cubit.dart';

@freezed
abstract class BugSyncProductsState with _$BugSyncProductsState {
  const factory BugSyncProductsState({
    @Default(true) bool isLoading,
    @Default(<ZentaoProduct>[]) List<ZentaoProduct> products,
    @Default(<int>{}) Set<int> selectedIds,
    String? errorMessage,
  }) = _BugSyncProductsState;
}
