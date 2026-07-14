import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';

part 'hero_card_model.freezed.dart';

@freezed
class HeroCardModel with _$HeroCardModel {
  const factory HeroCardModel.beforeCheckIn() = _BeforeCheckIn;
  const factory HeroCardModel.working({
    required DateTime checkIn,
    required DateTime leaveAt,
  }) = _Working;
  const factory HeroCardModel.afterCheckOut() = _AfterCheckOut;

  static HeroCardModel? fromAttendance(Attendance attendance) {
    if (attendance.checkIn == null) {
      return const HeroCardModel.beforeCheckIn();
    } else if (attendance.checkOut == null) {
      final totalMinutes =
          attendance.expectedEndMinute - attendance.expectedStartMinute;
      final leaveAt = attendance.checkIn!.add(Duration(minutes: totalMinutes));

      return HeroCardModel.working(
        checkIn: attendance.checkIn!,
        leaveAt: leaveAt,
      );
    } else {
      return const HeroCardModel.afterCheckOut();
    }
  }
}
