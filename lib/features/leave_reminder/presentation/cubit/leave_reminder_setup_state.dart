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
    WorkSchedule? schedule,
  }) = _LeaveReminderSetupState;
}

extension LeaveReminderSetupStateX on LeaveReminderSetupState {
  bool get hasBothLocations => home != null && work != null;

  /// Minute-of-day the user is expected to arrive at work, i.e. their
  /// schedule's start time minus the configured reminder buffer. Null if no
  /// active schedule is set.
  int? get expectedArriveMinuteOfDay {
    final s = schedule;
    if (s == null) return null;
    return s.startMinuteOfDay - s.reminderMinutes;
  }

  /// Minute-of-day the "time to leave" alert fires — arrival time minus the
  /// commute duration. Null until both a schedule and a commute estimate
  /// are available.
  int? get alertMinuteOfDay {
    final arrive = expectedArriveMinuteOfDay;
    if (arrive == null || lastCommuteMinutes == null) return null;
    return arrive - lastCommuteMinutes!;
  }
}
