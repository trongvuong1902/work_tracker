part of 'home_page_cubit.dart';

@freezed
abstract class HomePageState with _$HomePageState {
  const factory HomePageState({
    DateTime? checkInTime,
    DateTime? checkOutTime,
    WorkSchedule? workSchedule,
    HeroCardModel? heroCardModel,
    AttendanceCardModel? attendanceCardModel,
    LeaveReminderPromptTrigger? pendingLeaveReminderTrigger,
  }) = _HomePageState;
}

extension HomePageStateX on HomePageState {
  bool get isCheckInTimeSet => checkInTime != null;
  bool get isCheckOutTimeSet => checkOutTime != null;
}
