import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:work_tracker/features/attendance/domain/attendance_repository.dart';
import 'package:work_tracker/features/calendar/domain/models/calendar_day.dart';
import 'package:work_tracker/features/calendar/domain/models/month_summary.dart';

import 'calendar_state.dart';

@injectable
class CalendarCubit extends Cubit<CalendarState> {
  final AttendanceRepository _attendanceRepository;

  CalendarCubit(this._attendanceRepository)
    : super(
        CalendarState(
          year: DateTime.now().year,
          month: DateTime.now().month,
          selectedDate: _dateOnly(DateTime.now()),
        ),
      ) {
    _loadMonth();
  }

  static DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  Future<void> _loadMonth() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final attendanceByDayKey = await _attendanceRepository
          .getAttendanceForMonth(year: state.year, month: state.month);
      final days = buildMonthGrid(
        year: state.year,
        month: state.month,
        attendanceByDayKey: attendanceByDayKey,
        today: DateTime.now(),
        selectedDate: state.selectedDate,
      );
      final summary = deriveMonthSummary(attendanceByDayKey.values);
      emit(state.copyWith(isLoading: false, days: days, summary: summary));
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
      ),
    );
    await _loadMonth();
  }
}
