import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:work_tracker/features/calendar/domain/models/calendar_day.dart';
import 'package:work_tracker/features/calendar/domain/models/day_summary_display.dart';
import 'package:work_tracker/features/calendar/domain/models/month_summary.dart';
import 'package:work_tracker/features/schedule/domain/models/work_schedule.dart';
import 'package:work_tracker/features/task/domain/models/task.dart';

part 'calendar_state.freezed.dart';

/// A task worked on the selected day plus the seconds tracked that day.
class DayWorkedTask {
  const DayWorkedTask({required this.task, required this.seconds});

  final Task task;
  final int seconds;
}

@freezed
abstract class CalendarState with _$CalendarState {
  const factory CalendarState({
    @Default(true) bool isLoading,
    required int year,
    required int month,
    required DateTime selectedDate,
    @Default(<CalendarDayModel>[]) List<CalendarDayModel> days,
    @Default(MonthSummary()) MonthSummary summary,
    WorkSchedule? schedule,
    @Default(false) bool isSelectedDateWorkingDay,
    @Default(<Task>[]) List<Task> plannedTasksForSelectedDay,
    @Default(<DayWorkedTask>[]) List<DayWorkedTask> workedTasksForSelectedDay,
    @Default(DaySummaryDisplayState.noScheduleSetUp)
    DaySummaryDisplayState displayState,
    String? editErrorMessage,
    String? errorMessage,
  }) = _CalendarState;
}
