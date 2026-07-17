part of 'bug_detail_cubit.dart';

@freezed
abstract class BugDetailState with _$BugDetailState {
  const factory BugDetailState({
    @Default(false) bool isLoading,
    ZentaoBugDetail? detail,
    String? errorMessage,
  }) = _BugDetailState;
}
