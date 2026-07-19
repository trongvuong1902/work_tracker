import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:work_tracker/features/attendance/domain/attendance_repository.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';
import 'package:work_tracker/features/home/presentation/widgets/hero_card/hero_card_model.dart';
import 'package:work_tracker/features/leave_reminder/domain/leave_reminder_repository.dart';

part 'hero_card_state.dart';
part 'hero_card_cubit.freezed.dart';

@injectable
class HeroCardCubit extends Cubit<HeroCardState> {
  HeroCardCubit({
    required this._attendanceRepository,
    required this._leaveReminderRepository,
  }) : super(HeroCardState());

  final AttendanceRepository _attendanceRepository;
  final LeaveReminderRepository _leaveReminderRepository;
  late final StreamSubscription<Attendance?> _attendanceSubscription;
  late final StreamSubscription<void> _leaveInfoSubscription;

  // Remembered so a leave-info change can re-apply against the current
  // attendance without waiting for the next check-in/out event.
  Attendance? _latestAttendance;

  Future<void> init() async {
    _attendanceSubscription = _attendanceRepository
        .watchAttendanceChanges()
        .listen(_apply);
    // Re-read the leave/arrival time when leave-reminder state changes (e.g.
    // the user sets a home/work location in Settings) so the pre-check-in card
    // reflects it without an app restart or check-in.
    _leaveInfoSubscription = _leaveReminderRepository
        .watchLeaveInfoChanges()
        .listen((_) => _apply(_latestAttendance));
    // Seed the initial state: reads no longer broadcast, so subscribing alone
    // would leave the card empty until the next check-in/out.
    await _apply(await _attendanceRepository.getTodayAttendance());
  }

  Future<void> _apply(Attendance? attendance) async {
    _latestAttendance = attendance;
    if (attendance != null) {
      final heroCardModel = HeroCardModel.fromAttendance(attendance);
      emit(HeroCardState(heroCardModel: heroCardModel));
    } else {
      final leaveHomeAt = await _leaveReminderRepository.getLeaveTime();
      final arriveAtWorkAt = await _leaveReminderRepository
          .getEstimatedArrivalTime();
      emit(
        HeroCardState(
          heroCardModel: HeroCardModel.beforeCheckIn(
            leaveHomeAt: leaveHomeAt,
            arriveAtWorkAt: arriveAtWorkAt,
          ),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _attendanceSubscription.cancel();
    _leaveInfoSubscription.cancel();
    return super.close();
  }
}
