import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:work_tracker/features/attendance/domain/attendance_repository.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';

import '../../domain/daily_report.dart';
import '../../domain/models/work_item_time_session.dart';
import '../../domain/work_item_repository.dart';
import '../../domain/work_item_time_log_repository.dart';

part 'daily_report_state.dart';
part 'daily_report_cubit.freezed.dart';

/// Builds the on-demand daily report for a given day (default: today) from the
/// tasks worked that day — real work sessions plus the currently-running task's
/// ongoing session up to now. Also loads today's attendance (when the target
/// day is today) so callers can render/copy the extended report with the
/// Attendance block (see [renderDailyReportText]).
@injectable
class DailyReportCubit extends Cubit<DailyReportState> {
  DailyReportCubit(
    this._taskRepository,
    this._timeLogRepository,
    this._attendanceRepository,
  ) : super(const DailyReportState());

  final WorkItemRepository _taskRepository;
  final WorkItemTimeLogRepository _timeLogRepository;
  final AttendanceRepository _attendanceRepository;

  Future<void> load([DateTime? day]) async {
    final target = day ?? DateTime.now();
    final dayStart = DateTime(target.year, target.month, target.day);
    emit(const DailyReportState(isLoading: true));
    try {
      final tasks = await _taskRepository.getAll();
      final sessions = await _timeLogRepository.getSessionsForDay(dayStart);
      final logs = await _timeLogRepository.getByDay(dayStart);
      final secondsByTask = {for (final log in logs) log.taskId: log.seconds};

      // Fold the currently-running task's in-progress work (since the later of
      // its start and midnight) into today's report as an ongoing session.
      final now = DateTime.now();
      final isToday = dayStart ==
          DateTime(now.year, now.month, now.day);
      // Attendance is only tracked for today — there's no per-day lookup
      // beyond that yet, so past-day reports simply carry no Attendance block.
      final attendance = isToday
          ? await _attendanceRepository.getTodayAttendance()
          : null;
      final mutableSessions = [...sessions];
      if (isToday) {
        for (final task in tasks) {
          final startedAt = task.timerStartedAt;
          if (startedAt == null) continue;
          final from = startedAt.isAfter(dayStart) ? startedAt : dayStart;
          final liveSeconds = now.difference(from).inSeconds;
          if (liveSeconds <= 0) continue;
          mutableSessions.add(
            WorkItemTimeSession(
              id: 0,
              taskId: task.id,
              start: from,
              end: now,
            ),
          );
          secondsByTask[task.id] =
              (secondsByTask[task.id] ?? 0) + liveSeconds;
        }
      }

      final report = buildDailyReport(
        day: dayStart,
        tasks: tasks,
        sessions: mutableSessions,
        secondsByTask: secondsByTask,
      );
      emit(
        DailyReportState(
          isLoading: false,
          report: report,
          attendance: attendance,
        ),
      );
    } catch (e) {
      debugPrint('Failed to build daily report: $e');
      emit(const DailyReportState(isLoading: false));
    }
  }
}
