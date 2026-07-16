import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:work_tracker/core/time/time_format.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';
part 'attendance_card_model.freezed.dart';

enum CheckInStatus { soon, late }

enum CheckOutStatus { soon, overtime }

@freezed
class AttendanceCardModel with _$AttendanceCardModel {
  const factory AttendanceCardModel.beforeCheckIn({
    required String startWorkTime,
    required String endWorkTime,
    required String workingTime,
    required String breakTime,
  }) = _BeforeCheckIn;

  const factory AttendanceCardModel.working({
    required String actualCheckInTime,
    required String plannedCheckInTime,
    required String estimateCheckOutTime,
    required String plannedLeave,
    String? extraTimeCheckIn,
    CheckInStatus? checkInStatus,
    String? extraTimeCheckOut,
    CheckOutStatus? checkOutStatus,
  }) = _Working;

  const factory AttendanceCardModel.afterCheckOut({
    required String workedTime,
    required String plannedWorkedTime,
    required String overtime,
    required String actualCheckInTime,
    required String plannedCheckInTime,
    required CheckInStatus checkInStatus,
    required String checkInExtra,
    required String actualCheckOutTime,
    required String plannedCheckOutTime,
    required CheckOutStatus checkOutStatus,
    required String checkOutExtra,
  }) = _AfterCheckOut;

  static AttendanceCardModel fromAttendance(Attendance attendance) {
    if (attendance.checkOut != null) {
      final workedTime = TimeFormat.hMm(attendance.workedMinutes);
      final plannedWorkedTime = TimeFormat.hMm(
        attendance.expectedEndMinute -
            attendance.expectedStartMinute -
            attendance.lunchMinutes,
      );
      final overtime = TimeFormat.hMm(attendance.overtimeMinutes);

      final actualCheckInTime = TimeFormat.hhMmFromDateTime(
        attendance.checkIn!,
      );
      final plannedCheckInTime = TimeFormat.hhMm(
        attendance.expectedStartMinute,
      );
      final checkInDiff =
          _minuteOfDay(attendance.checkIn!) - attendance.expectedStartMinute;
      final checkInStatus = checkInDiff > 0
          ? CheckInStatus.late
          : CheckInStatus.soon;
      final checkInExtra = TimeFormat.hMm(checkInDiff.abs());

      final actualCheckOutTime = TimeFormat.hhMmFromDateTime(
        attendance.checkOut!,
      );
      // Compared against the raw work-schedule end time (not shifted for a
      // late check-in) — this is "how late did they leave vs. schedule",
      // distinct from the check-in-adjusted `overtime` figure above.
      final plannedCheckOutTime = TimeFormat.hhMm(attendance.expectedEndMinute);
      final checkOutDiff =
          _minuteOfDay(attendance.checkOut!) - attendance.expectedEndMinute;
      final checkOutStatus = checkOutDiff >= 0
          ? CheckOutStatus.overtime
          : CheckOutStatus.soon;
      final checkOutExtra = TimeFormat.hMm(checkOutDiff.abs());

      return AttendanceCardModel.afterCheckOut(
        workedTime: workedTime,
        plannedWorkedTime: plannedWorkedTime,
        overtime: overtime,
        actualCheckInTime: actualCheckInTime,
        plannedCheckInTime: plannedCheckInTime,
        checkInStatus: checkInStatus,
        checkInExtra: checkInExtra,
        actualCheckOutTime: actualCheckOutTime,
        plannedCheckOutTime: plannedCheckOutTime,
        checkOutStatus: checkOutStatus,
        checkOutExtra: checkOutExtra,
      );
    } else if (attendance.checkIn != null) {
      final actualCheckInTime = TimeFormat.hhMmFromDateTime(
        attendance.checkIn!,
      );
      final plannedCheckInTime = TimeFormat.hhMm(
        attendance.expectedStartMinute,
      );
      final estimateCheckOutTime = TimeFormat.hhMm(
        attendance.expectedEndMinute,
      );

      final checkInDiff =
          _minuteOfDay(attendance.checkIn!) - attendance.expectedStartMinute;
      final extraTimeNeedToCheckOut = max(0, checkInDiff);
      final plannedLeave = TimeFormat.hhMm(
        attendance.expectedEndMinute + extraTimeNeedToCheckOut,
      );
      final checkInStatus = checkInDiff > 0
          ? CheckInStatus.late
          : CheckInStatus.soon;
      final extraTimeCheckIn = TimeFormat.hMm(checkInDiff.abs());

      final checkOutDiff =
          _minuteOfDay(DateTime.now()) -
          max(
            attendance.expectedEndMinute,
            attendance.expectedEndMinute + extraTimeNeedToCheckOut,
          ).toInt();

      final checkOutStatus = checkOutDiff >= 0
          ? CheckOutStatus.overtime
          : CheckOutStatus.soon;

      final extraTimeCheckOut = TimeFormat.hMm(checkOutDiff.abs());

      return AttendanceCardModel.working(
        actualCheckInTime: actualCheckInTime,
        plannedCheckInTime: plannedCheckInTime,
        estimateCheckOutTime: estimateCheckOutTime,
        plannedLeave: plannedLeave,
        extraTimeCheckIn: extraTimeCheckIn,
        checkInStatus: checkInStatus,
        checkOutStatus: checkOutStatus,
        extraTimeCheckOut: extraTimeCheckOut,
      );
    } else {
      return AttendanceCardModel.beforeCheckIn(
        startWorkTime: TimeFormat.hhMm(attendance.expectedStartMinute),
        endWorkTime: TimeFormat.hhMm(attendance.expectedEndMinute),
        workingTime: TimeFormat.hMm(
          attendance.expectedEndMinute -
              attendance.expectedStartMinute -
              attendance.lunchMinutes,
        ),
        breakTime: TimeFormat.hMm(attendance.lunchMinutes),
      );
    }
  }

  static int _minuteOfDay(DateTime dateTime) =>
      dateTime.hour * 60 + dateTime.minute;
}
