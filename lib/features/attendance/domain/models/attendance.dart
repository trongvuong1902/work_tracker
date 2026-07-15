import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance.freezed.dart';

@freezed
abstract class Attendance with _$Attendance {
  const factory Attendance({
    required DateTime workDate,
    required int dayKey,
    DateTime? checkIn,
    DateTime? checkOut,
    required int expectedStartMinute,
    required int expectedEndMinute,
    required int lunchMinutes,
    required int expectedLunchStartMinute,
    @Default(0) int workedMinutes,
    @Default(0) int lateMinutes,
    @Default(0) int overtimeMinutes,
    @Default(0) int earlyLeaveMinutes,
    @Default(0) int status,
    String? note,
    @Default(false) bool isEdited,
    DateTime? editedAt,
  }) = _Attendance;
}
