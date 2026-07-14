import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:work_tracker/features/attendance/domain/attendance_repository.dart';
import 'package:work_tracker/features/home/presentation/widgets/attendance_card/attendance_card_model.dart';
import 'package:work_tracker/features/home/presentation/widgets/hero_card/hero_card_model.dart';
import 'package:work_tracker/features/schedule/domain/models/work_schedule.dart';
import 'package:work_tracker/features/schedule/domain/work_schedule_repository.dart';

part 'home_page_state.dart';
part 'home_page_cubit.freezed.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit({
    required this._workScheduleRepository,
    required this._attendanceRepository,
  }) : super(HomePageState()) {
    initialize();
  }

  final WorkScheduleRepository _workScheduleRepository;
  final AttendanceRepository _attendanceRepository;

  Future<void> initialize() async {
    final currentSchedule = await _workScheduleRepository
        .getCurrentActiveSchedule();
    final attendance = await _attendanceRepository.getTodayAttendance();
    emit(
      state.copyWith(
        workSchedule: currentSchedule,
        checkInTime: attendance?.checkIn,
        checkOutTime: attendance?.checkOut,
      ),
    );
  }

  Future<void> checkIn(DateTime time) async {
    final attendance = await _attendanceRepository.checkIn(time);
    emit(state.copyWith(checkInTime: attendance.checkIn));
  }

  Future<void> checkOut(DateTime time) async {
    final attendance = await _attendanceRepository.checkOut(time);
    emit(
      state.copyWith(
        checkInTime: attendance.checkIn,
        checkOutTime: attendance.checkOut,
      ),
    );
  }

  void clearAll() {
    _attendanceRepository.clearTodayAttendance();
  }
}
