import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';

part 'hero_card_model.freezed.dart';

@freezed
class HeroCardModel with _$HeroCardModel {
  const factory HeroCardModel.beforeCheckIn({
    DateTime? leaveHomeAt,
    DateTime? arriveAtWorkAt,
  }) = _BeforeCheckIn;
  const factory HeroCardModel.working({
    required DateTime checkIn,
    required DateTime leaveAt,
    required DateTime breakStart,
    required DateTime breakEnd,
  }) = _Working;
  const factory HeroCardModel.afterCheckOut() = _AfterCheckOut;

  static HeroCardModel? fromAttendance(Attendance attendance) {
    if (attendance.checkIn == null) {
      return const HeroCardModel.beforeCheckIn();
    } else if (attendance.checkOut == null) {
      final checkIn = attendance.checkIn!;
      final totalMinutes =
          attendance.expectedEndMinute - attendance.expectedStartMinute;
      final leaveAt = checkIn.add(Duration(minutes: totalMinutes));

      final breakStart = DateTime(
        checkIn.year,
        checkIn.month,
        checkIn.day,
        attendance.expectedLunchStartMinute ~/ 60,
        attendance.expectedLunchStartMinute % 60,
      );
      final breakEnd = breakStart.add(
        Duration(minutes: attendance.lunchMinutes),
      );

      return HeroCardModel.working(
        checkIn: checkIn,
        leaveAt: leaveAt,
        breakStart: breakStart,
        breakEnd: breakEnd,
      );
    } else {
      return const HeroCardModel.afterCheckOut();
    }
  }
}
