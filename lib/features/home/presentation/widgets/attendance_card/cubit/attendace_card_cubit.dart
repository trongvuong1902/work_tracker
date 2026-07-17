import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:work_tracker/core/time/time_format.dart';
import 'package:work_tracker/features/attendance/domain/attendance_repository.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';
import 'package:work_tracker/features/home/presentation/widgets/attendance_card/attendance_card_model.dart';
import 'package:work_tracker/features/schedule/domain/work_schedule_repository.dart';

part 'attendace_card_state.dart';
part 'attendace_card_cubit.freezed.dart';

@injectable
class AttendaceCardCubit extends Cubit<AttendaceCardState> {
  AttendaceCardCubit({
    required this._attendanceRepository,
    required this._workScheduleRepository,
  }) : super(AttendaceCardState());

  final AttendanceRepository _attendanceRepository;
  final WorkScheduleRepository _workScheduleRepository;
  late final StreamSubscription<Attendance?> _attendanceSubscription;

  Future<void> init() async {
    _attendanceSubscription = _attendanceRepository
        .watchAttendanceChanges()
        .listen(_apply);
    // Seed the initial state: reads no longer broadcast, so subscribing alone
    // would leave the card empty until the next check-in/out.
    await _apply(await _attendanceRepository.getTodayAttendance());
  }

  Future<void> _apply(Attendance? attendance) async {
    if (attendance != null) {
      final attendanceCardModel = AttendanceCardModel.fromAttendance(
        attendance,
      );
      emit(AttendaceCardState(model: attendanceCardModel));
    } else {
      final currentSchedule = await _workScheduleRepository
          .getCurrentActiveSchedule();

      if (currentSchedule == null) {
        return;
      }

      final model = AttendanceCardModel.beforeCheckIn(
        startWorkTime: TimeFormat.hhMm(currentSchedule.startMinuteOfDay),
        endWorkTime: TimeFormat.hhMm(currentSchedule.endMinuteOfDay),
        workingTime: TimeFormat.hMm(
          currentSchedule.endMinuteOfDay -
              currentSchedule.startMinuteOfDay -
              currentSchedule.lunchMinutes,
        ),
        breakTime: TimeFormat.hMm(currentSchedule.lunchMinutes),
      );
      emit(AttendaceCardState(model: model));
    }
  }

  @override
  Future<void> close() {
    _attendanceSubscription.cancel();
    return super.close();
  }
}
