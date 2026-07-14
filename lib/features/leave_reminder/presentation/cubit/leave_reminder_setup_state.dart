part of 'leave_reminder_setup_cubit.dart';

@freezed
abstract class LeaveReminderSetupState with _$LeaveReminderSetupState {
  const factory LeaveReminderSetupState({
    @Default(true) bool isLoading,
    @Default(false) bool enabled,
    GeoPoint? home,
    GeoPoint? work,
    int? lastCommuteMinutes,
    DateTime? lastCommuteUpdatedAt,
    @Default(false) bool isSettingHome,
    @Default(false) bool isSettingWork,
    @Default(false) bool isRefreshingCommute,
    @Default(false) bool isTogglingEnabled,
    String? errorMessage,
    @Default(false) bool didCloseSuccessfully,
  }) = _LeaveReminderSetupState;
}

extension LeaveReminderSetupStateX on LeaveReminderSetupState {
  bool get hasBothLocations => home != null && work != null;
}
