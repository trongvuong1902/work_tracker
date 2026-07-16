import 'package:work_tracker/features/attendance/domain/models/attendance.dart';
import 'package:work_tracker/features/schedule/domain/models/work_schedule.dart';

/// The five body states the Calendar tab's day-summary card can render for a
/// selected date, per `docs/design/day-detail-edit.md`.
enum DaySummaryDisplayState {
  /// Attendance exists for the date — show the recorded check-in/check-out.
  populated,

  /// No attendance, a schedule applies to this weekday, and the date is
  /// today or in the past — editable Start/End tiles.
  scheduleFallbackPast,

  /// No attendance, a schedule applies to this weekday, and the date is in
  /// the future — read-only Start/End tiles.
  scheduleFallbackFuture,

  /// No attendance, a schedule exists, but the date's weekday is not a
  /// scheduled work day.
  nonWorkingDay,

  /// No attendance and no schedule has ever been set up.
  noScheduleSetUp,
}

/// Derives which of the day-summary card's body states applies for the
/// selected [date], based purely on whether attendance/a schedule exist and
/// whether the date is a working day, past, or future.
DaySummaryDisplayState deriveDaySummaryDisplayState({
  required Attendance? attendance,
  required WorkSchedule? schedule,
  required bool isWorkingDay,
  required DateTime date,
  required DateTime today,
}) {
  if (attendance != null) {
    return DaySummaryDisplayState.populated;
  }
  if (schedule == null) {
    return DaySummaryDisplayState.noScheduleSetUp;
  }
  if (!isWorkingDay) {
    return DaySummaryDisplayState.nonWorkingDay;
  }

  final dateOnly = DateTime(date.year, date.month, date.day);
  final todayOnly = DateTime(today.year, today.month, today.day);
  return dateOnly.isAfter(todayOnly)
      ? DaySummaryDisplayState.scheduleFallbackFuture
      : DaySummaryDisplayState.scheduleFallbackPast;
}
