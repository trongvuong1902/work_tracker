import 'package:flutter/widgets.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/core/time/time_format.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';

enum DayStatus { onTime, late, none }

/// Derives the indicator status of a single calendar day, based on the
/// check-in versus the scheduled start time:
/// - No check-in recorded → [DayStatus.none] (no indicator shown).
/// - Checked in after the scheduled start → [DayStatus.late].
/// - Checked in on time or early → [DayStatus.onTime] (green).
DayStatus deriveDayStatus({required Attendance? attendance}) {
  if (attendance?.checkIn == null) {
    return DayStatus.none;
  }
  return attendance!.lateMinutes > 0 ? DayStatus.late : DayStatus.onTime;
}

/// The check-in/check-out time to display under the date number, or `null`
/// if there is nothing to show for that day.
String? deriveTimeLabel(Attendance? attendance) {
  if (attendance == null) return null;
  if (attendance.checkOut != null) {
    return TimeFormat.hhMmFromDateTime(attendance.checkOut!);
  }
  if (attendance.checkIn != null) {
    return TimeFormat.hhMmFromDateTime(attendance.checkIn!);
  }
  return null;
}

extension DayStatusColor on DayStatus {
  Color color(BuildContext context) {
    final colors = context.colors;
    switch (this) {
      case DayStatus.onTime:
        return colors.primary;
      case DayStatus.late:
        return colors.error;
      case DayStatus.none:
        return colors.outline;
    }
  }
}
