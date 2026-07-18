import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';

import 'day_status.dart';

part 'calendar_day.freezed.dart';

@freezed
abstract class CalendarDayModel with _$CalendarDayModel {
  const factory CalendarDayModel({
    required DateTime date,
    required bool isCurrentMonth,
    required bool isToday,
    required bool isSelected,
    required DayStatus status,
    String? timeLabel,
    Attendance? attendance,
    // Whether the user has planned any task for this day (drives a marker).
    @Default(false) bool hasPlannedTasks,
  }) = _CalendarDayModel;
}

/// Builds a flat, Monday-first month grid for [year]/[month].
///
/// The result always covers whole weeks: leading days are borrowed from the
/// previous month to fill the first week, and trailing days are borrowed
/// from the next month to fill the last week — no dead empty week is added.
List<CalendarDayModel> buildMonthGrid({
  required int year,
  required int month,
  required Map<int, Attendance> attendanceByDayKey,
  required DateTime today,
  required DateTime selectedDate,
  Set<int> plannedDayKeys = const {},
}) {
  final firstOfMonth = DateTime(year, month, 1);
  final daysInMonth = DateTime(year, month + 1, 0).day;

  // weekday: 1 = Monday .. 7 = Sunday.
  final leadingDays = (firstOfMonth.weekday - 1) % 7;
  final gridStart = firstOfMonth.subtract(Duration(days: leadingDays));

  final totalDaysBeforeTrailing = leadingDays + daysInMonth;
  final trailingDays = (7 - (totalDaysBeforeTrailing % 7)) % 7;
  final totalDays = totalDaysBeforeTrailing + trailingDays;

  final todayDateOnly = DateTime(today.year, today.month, today.day);
  final selectedDateOnly = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
  );

  return List.generate(totalDays, (index) {
    final date = gridStart.add(Duration(days: index));
    final dateOnly = DateTime(date.year, date.month, date.day);
    final dayKey = dateOnly.year * 10000 + dateOnly.month * 100 + dateOnly.day;
    final attendance = attendanceByDayKey[dayKey];

    return CalendarDayModel(
      date: dateOnly,
      isCurrentMonth: dateOnly.month == month && dateOnly.year == year,
      isToday: dateOnly.isAtSameMomentAs(todayDateOnly),
      isSelected: dateOnly.isAtSameMomentAs(selectedDateOnly),
      status: deriveDayStatus(attendance: attendance),
      timeLabel: deriveTimeLabel(attendance),
      attendance: attendance,
      hasPlannedTasks: plannedDayKeys.contains(dayKey),
    );
  });
}
