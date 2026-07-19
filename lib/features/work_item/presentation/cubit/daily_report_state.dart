part of 'daily_report_cubit.dart';

@freezed
abstract class DailyReportState with _$DailyReportState {
  const factory DailyReportState({
    @Default(true) bool isLoading,
    DailyReport? report,
  }) = _DailyReportState;
}
