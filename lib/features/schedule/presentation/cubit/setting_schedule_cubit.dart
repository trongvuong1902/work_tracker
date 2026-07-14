import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:work_tracker/features/schedule/domain/models/work_schedule.dart';
import 'package:work_tracker/features/schedule/domain/work_schedule_constants.dart';
import 'package:work_tracker/features/schedule/domain/work_schedule_repository.dart';

part 'setting_schedule_state.dart';
part 'setting_schedule_cubit.freezed.dart';

@injectable
class SettingScheduleCubit extends Cubit<SettingScheduleState> {
  SettingScheduleCubit(this._workScheduleRepository)
    : super(const SettingScheduleState()) {
    _loadExisting();
  }

  final WorkScheduleRepository _workScheduleRepository;

  Future<void> _loadExisting() async {
    emit(state.copyWith(isLoading: true));
    final existing = await _workScheduleRepository.getCurrentActiveSchedule();
    if (existing == null) {
      emit(state.copyWith(isLoading: false));
      return;
    }
    emit(
      state.copyWith(
        isLoading: false,
        isEditing: true,
        startMinuteOfDay: existing.startMinuteOfDay,
        endMinuteOfDay: existing.endMinuteOfDay,
        lunchMinutes: existing.lunchMinutes,
        reminderMinutes: existing.reminderMinutes,
        workingDaysMask: existing.workingDaysMask ?? kDefaultWorkingDaysMask,
      ),
    );
  }

  void updateStartMinute(int minuteOfDay) {
    emit(state.copyWith(startMinuteOfDay: minuteOfDay, errorMessage: null));
  }

  void updateEndMinute(int minuteOfDay) {
    emit(state.copyWith(endMinuteOfDay: minuteOfDay, errorMessage: null));
  }

  void updateLunchMinutes(int minutes) {
    emit(state.copyWith(lunchMinutes: minutes.clamp(0, 180)));
  }

  void updateReminderMinutes(int minutes) {
    emit(state.copyWith(reminderMinutes: minutes.clamp(0, 60)));
  }

  void toggleWorkingDay(int weekday) {
    final bit = 1 << (weekday - 1);
    emit(state.copyWith(workingDaysMask: state.workingDaysMask ^ bit));
  }

  Future<bool> save() async {
    if (state.endMinuteOfDay <= state.startMinuteOfDay) {
      emit(state.copyWith(errorMessage: 'End time must be after start time'));
      return false;
    }

    emit(state.copyWith(isSaving: true, errorMessage: null));
    await _workScheduleRepository.saveWorkSchedule(
      WorkSchedule(
        startMinuteOfDay: state.startMinuteOfDay,
        endMinuteOfDay: state.endMinuteOfDay,
        lunchMinutes: state.lunchMinutes,
        reminderMinutes: state.reminderMinutes,
        workingDaysMask: state.workingDaysMask,
      ),
    );
    emit(state.copyWith(isSaving: false));
    return true;
  }
}
