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
    required String workHours,
    required String overtime,
    required String? leaveEarly,
    required String? leaveLate,
  }) = _AfterCheckOut;

  static AttendanceCardModel fromAttendance(Attendance attendance) {
    if (attendance.checkOut != null) {
      final workHours = TimeFormat.hMm(attendance.workedMinutes);
      final overtime = TimeFormat.hMm(attendance.overtimeMinutes);
      final leaveEarly = attendance.earlyLeaveMinutes > 0
          ? TimeFormat.hMm(attendance.earlyLeaveMinutes)
          : null;
      final leaveLate = attendance.lateMinutes > 0
          ? TimeFormat.hMm(attendance.lateMinutes)
          : null;

      return AttendanceCardModel.afterCheckOut(
        workHours: workHours,
        overtime: overtime,
        leaveEarly: leaveEarly,
        leaveLate: leaveLate,
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
