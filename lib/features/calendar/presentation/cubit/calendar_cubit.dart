import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:work_tracker/features/attendance/domain/attendance_repository.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';
import 'package:work_tracker/features/calendar/domain/models/calendar_day.dart';
import 'package:work_tracker/features/calendar/domain/models/day_summary_display.dart';
import 'package:work_tracker/features/calendar/domain/models/month_summary.dart';
import 'package:work_tracker/features/schedule/domain/work_schedule_repository.dart';

import 'calendar_state.dart';

@injectable
class CalendarCubit extends Cubit<CalendarState> {
  final AttendanceRepository _attendanceRepository;
  final WorkScheduleRepository _workScheduleRepository;
  late final StreamSubscription<Attendance?> _attendanceSubscription;

  CalendarCubit(this._attendanceRepository, this._workScheduleRepository)
    : super(
        CalendarState(
          year: DateTime.now().year,
          month: DateTime.now().month,
          selectedDate: _dateOnly(DateTime.now()),
        ),
      ) {
    _loadMonth();
    // Calendar's tab is kept alive across tab switches by the shell route,
    // so it must react to attendance edits made from other tabs (e.g. Home)
    // rather than only reloading when the user re-interacts with Calendar.
    _attendanceSubscription = _attendanceRepository.watchAttendanceChanges().listen(
      (_) => _loadMonth(),
    );
  }

  static DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static int _dayKeyOf(DateTime date) =>
      date.year * 10000 + date.month * 100 + date.day;

  Future<void> _loadMonth() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final attendanceByDayKey = await _attendanceRepository
          .getAttendanceForMonth(year: state.year, month: state.month);
      final schedule = await _workScheduleRepository.getCurrentActiveSchedule();
      final today = DateTime.now();
      final days = buildMonthGrid(
        year: state.year,
        month: state.month,
        attendanceByDayKey: attendanceByDayKey,
        today: today,
        selectedDate: state.selectedDate,
      );
      final summary = deriveMonthSummary(attendanceByDayKey.values);

      final selectedAttendance =
          attendanceByDayKey[_dayKeyOf(state.selectedDate)];
      final isSelectedDateWorkingDay =
          schedule != null &&
          _workScheduleRepository.isWorkingDay(state.selectedDate);
      final displayState = deriveDaySummaryDisplayState(
        attendance: selectedAttendance,
        schedule: schedule,
        isWorkingDay: isSelectedDateWorkingDay,
        date: state.selectedDate,
        today: today,
      );

      emit(
        state.copyWith(
          isLoading: false,
          days: days,
          summary: summary,
          schedule: schedule,
          isSelectedDateWorkingDay: isSelectedDateWorkingDay,
          displayState: displayState,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> goToPreviousMonth() async {
    final newMonth = state.month == 1 ? 12 : state.month - 1;
    final newYear = state.month == 1 ? state.year - 1 : state.year;
    emit(state.copyWith(year: newYear, month: newMonth));
    await _loadMonth();
  }

  Future<void> goToNextMonth() async {
    final newMonth = state.month == 12 ? 1 : state.month + 1;
    final newYear = state.month == 12 ? state.year + 1 : state.year;
    emit(state.copyWith(year: newYear, month: newMonth));
    await _loadMonth();
  }

  Future<void> selectDate(DateTime date) async {
    final normalized = _dateOnly(date);
    emit(
      state.copyWith(
        year: normalized.year,
        month: normalized.month,
        selectedDate: normalized,
        editErrorMessage: null,
      ),
    );
    await _loadMonth();
  }

  /// Creates or corrects the selected day's check-in. [time]'s date
  /// component should already be anchored to the selected day.
  Future<void> editCheckIn(DateTime time) async {
    try {
      await _attendanceRepository.checkIn(time);
      emit(state.copyWith(editErrorMessage: null));
      await _loadMonth();
    } catch (e) {
      emit(state.copyWith(editErrorMessage: _messageFor(e)));
    }
  }

  /// Creates or corrects the selected day's check-out. [time]'s date
  /// component should already be anchored to the selected day.
  Future<void> editCheckOut(DateTime time) async {
    try {
      await _attendanceRepository.checkOut(time);
      emit(state.copyWith(editErrorMessage: null));
      await _loadMonth();
    } catch (e) {
      emit(state.copyWith(editErrorMessage: _messageFor(e)));
    }
  }

  /// Reloads the month/selected-day state after returning from
  /// `SettingSchedulePage`, so the card re-evaluates against the new
  /// schedule.
  Future<void> refreshAfterScheduleChange() => _loadMonth();

  String _messageFor(Object e) => e is StateError ? e.message : e.toString();

  @override
  Future<void> close() {
    _attendanceSubscription.cancel();
    return super.close();
  }
}
