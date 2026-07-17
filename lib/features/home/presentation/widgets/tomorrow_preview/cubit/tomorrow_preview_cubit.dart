import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:work_tracker/features/attendance/domain/attendance_repository.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';
import 'package:work_tracker/features/leave_reminder/domain/leave_reminder_repository.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/tomorrow_preview.dart';

part 'tomorrow_preview_state.dart';
part 'tomorrow_preview_cubit.freezed.dart';

@injectable
class TomorrowPreviewCubit extends Cubit<TomorrowPreviewState> {
  TomorrowPreviewCubit({
    required this._attendanceRepository,
    required this._leaveReminderRepository,
  }) : super(const TomorrowPreviewState());

  final AttendanceRepository _attendanceRepository;
  final LeaveReminderRepository _leaveReminderRepository;
  late final StreamSubscription<Attendance?> _attendanceSubscription;

  Future<void> init() async {
    _attendanceSubscription = _attendanceRepository
        .watchAttendanceChanges()
        .listen(_apply);
    // Seed the initial state: reads no longer broadcast, so subscribing alone
    // would leave the preview empty until the next check-in/out.
    await _apply(await _attendanceRepository.getTodayAttendance());
  }

  Future<void> _apply(Attendance? attendance) async {
    if (attendance?.checkIn != null && attendance?.checkOut != null) {
      final preview = await _leaveReminderRepository.getTomorrowPreview();
      emit(TomorrowPreviewState(preview: preview));
    } else {
      emit(const TomorrowPreviewState());
    }
  }

  @override
  Future<void> close() {
    _attendanceSubscription.cancel();
    return super.close();
  }
}
