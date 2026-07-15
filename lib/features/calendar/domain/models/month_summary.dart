import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';

part 'month_summary.freezed.dart';

@freezed
abstract class MonthSummary with _$MonthSummary {
  const factory MonthSummary({
    @Default(0) int lateCount,
    @Default(0) int soonCount,
    @Default(0) int onTimeCount,
  }) = _MonthSummary;
}

/// Tallies check-in punctuality across a month's attendance records, each
/// classified against its own snapshotted [Attendance.expectedStartMinute].
/// Days with no check-in are not counted.
MonthSummary deriveMonthSummary(Iterable<Attendance> attendances) {
  var lateCount = 0;
  var soonCount = 0;
  var onTimeCount = 0;

  for (final attendance in attendances) {
    final checkIn = attendance.checkIn;
    if (checkIn == null) continue;

    final checkInMinute = checkIn.hour * 60 + checkIn.minute;
    final diff = checkInMinute - attendance.expectedStartMinute;
    if (diff > 0) {
      lateCount++;
    } else if (diff < 0) {
      soonCount++;
    } else {
      onTimeCount++;
    }
  }

  return MonthSummary(
    lateCount: lateCount,
    soonCount: soonCount,
    onTimeCount: onTimeCount,
  );
}
