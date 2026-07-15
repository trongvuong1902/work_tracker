import 'package:flutter/widgets.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/core/time/time_format.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';

enum DayStatus { onTime, late, none }

/// Derives the indicator status of a single calendar day, based purely on
/// check-out behavior:
/// - No attendance record, or checked in but not yet checked out →
///   [DayStatus.none] (no indicator shown).
/// - Checked out later than the expected end time → [DayStatus.late].
/// - Checked out early or on time → [DayStatus.onTime].
DayStatus deriveDayStatus({required Attendance? attendance}) {
  if (attendance?.checkOut == null) {
    return DayStatus.none;
  }
  return attendance!.overtimeMinutes > 0 ? DayStatus.late : DayStatus.onTime;
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
        return colors.warning;
      case DayStatus.none:
        return colors.outline;
    }
  }
}
