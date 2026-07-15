part of 'setting_schedule_cubit.dart';

@freezed
abstract class SettingScheduleState with _$SettingScheduleState {
  const factory SettingScheduleState({
    @Default(540) int startMinuteOfDay,
    @Default(1080) int endMinuteOfDay,
    @Default(60) int lunchMinutes,
    @Default(720) int lunchStartMinuteOfDay,
    @Default(10) int reminderMinutes,
    @Default(kDefaultWorkingDaysMask) int workingDaysMask,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isEditing,
    String? errorMessage,
  }) = _SettingScheduleState;
}
