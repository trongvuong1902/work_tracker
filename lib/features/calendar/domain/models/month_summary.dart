import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';

part 'month_summary.freezed.dart';

@freezed
abstract class MonthSummary with _$MonthSummary {
  const factory MonthSummary({
    @Default(0) int totalLateMinutes,
    @Default(0) int lateDayCount,
    @Default(0) int totalOvertimeMinutes,
  }) = _MonthSummary;
}

/// Aggregates lateness and overtime across a month's attendance records,
/// summing each record's already-computed [Attendance.lateMinutes] and
/// [Attendance.overtimeMinutes].
MonthSummary deriveMonthSummary(Iterable<Attendance> attendances) {
  var totalLateMinutes = 0;
  var lateDayCount = 0;
  var totalOvertimeMinutes = 0;

  for (final attendance in attendances) {
    totalLateMinutes += attendance.lateMinutes;
    totalOvertimeMinutes += attendance.overtimeMinutes;
    if (attendance.lateMinutes > 0) {
      lateDayCount++;
    }
  }

  return MonthSummary(
    totalLateMinutes: totalLateMinutes,
    lateDayCount: lateDayCount,
    totalOvertimeMinutes: totalOvertimeMinutes,
  );
}
