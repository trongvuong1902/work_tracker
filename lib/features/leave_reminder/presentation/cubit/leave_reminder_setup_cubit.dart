import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:work_tracker/features/leave_reminder/domain/leave_reminder_repository.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/geo_point.dart';

part 'leave_reminder_setup_state.dart';
part 'leave_reminder_setup_cubit.freezed.dart';

@injectable
class LeaveReminderSetupCubit extends Cubit<LeaveReminderSetupState> {
  LeaveReminderSetupCubit(this._repository)
    : super(const LeaveReminderSetupState()) {
    _loadSettings();
  }

  final LeaveReminderRepository _repository;

  Future<void> _loadSettings() async {
    emit(state.copyWith(isLoading: true));
    final settings = await _repository.getSettings();
    emit(
      state.copyWith(
        isLoading: false,
        enabled: settings.enabled,
        home: settings.home,
        work: settings.work,
        lastCommuteMinutes: settings.lastCommuteMinutes,
        lastCommuteUpdatedAt: settings.lastCommuteUpdatedAt,
      ),
    );
  }

  Future<void> toggleEnabled(bool value) async {
    emit(state.copyWith(isTogglingEnabled: true, errorMessage: null));
    final result = await _repository.setEnabled(value);
    switch (result) {
      case EnableLeaveReminderResult.success:
        emit(
          state.copyWith(
            isTogglingEnabled: false,
            enabled: value,
            didCloseSuccessfully: value,
          ),
        );
      case EnableLeaveReminderResult.notificationPermissionDenied:
        emit(
          state.copyWith(
            isTogglingEnabled: false,
            errorMessage:
                'Notifications are disabled for WorkTracker. Enable them in '
                'system settings to turn on leave reminders.',
          ),
        );
    }
  }

  Future<void> setHome(GeoPoint point) async {
    emit(state.copyWith(isSettingHome: true, errorMessage: null));
    final settings = await _repository.setHomeLocation(point);
    emit(
      state.copyWith(
        isSettingHome: false,
        home: settings.home,
        lastCommuteMinutes: settings.lastCommuteMinutes,
        lastCommuteUpdatedAt: settings.lastCommuteUpdatedAt,
      ),
    );
    if (state.hasBothLocations) refreshCommute();
  }

  Future<void> setWork(GeoPoint point) async {
    emit(state.copyWith(isSettingWork: true, errorMessage: null));
    final settings = await _repository.setWorkLocation(point);
    emit(
      state.copyWith(
        isSettingWork: false,
        work: settings.work,
        lastCommuteMinutes: settings.lastCommuteMinutes,
        lastCommuteUpdatedAt: settings.lastCommuteUpdatedAt,
      ),
    );
    if (state.hasBothLocations) refreshCommute();
  }

  Future<void> refreshCommute() async {
    if (!state.hasBothLocations) return;
    emit(state.copyWith(isRefreshingCommute: true, errorMessage: null));
    await _repository.scheduleTodayReminders();
    final settings = await _repository.getSettings();
    emit(
      state.copyWith(
        isRefreshingCommute: false,
        lastCommuteMinutes: settings.lastCommuteMinutes,
        lastCommuteUpdatedAt: settings.lastCommuteUpdatedAt,
      ),
    );
  }
}
