import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:work_tracker/features/leave_reminder/domain/leave_reminder_repository.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/commute_waypoint.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/geo_point.dart';
import 'package:work_tracker/features/leave_reminder/leave_reminder_constants.dart';
import 'package:work_tracker/features/schedule/domain/models/work_schedule.dart';
import 'package:work_tracker/features/schedule/domain/work_schedule_repository.dart';

part 'leave_reminder_setup_state.dart';
part 'leave_reminder_setup_cubit.freezed.dart';

@injectable
class LeaveReminderSetupCubit extends Cubit<LeaveReminderSetupState> {
  LeaveReminderSetupCubit(this._repository, this._workScheduleRepository)
    : super(const LeaveReminderSetupState()) {
    _loadSettings();
  }

  final LeaveReminderRepository _repository;
  final WorkScheduleRepository _workScheduleRepository;

  Future<void> _loadSettings() async {
    emit(state.copyWith(isLoading: true));
    final settings = await _repository.getSettings();
    final schedule = await _workScheduleRepository.getCurrentActiveSchedule();
    final averageCommuteMinutes = await _repository.getAverageCommuteMinutes();
    emit(
      state.copyWith(
        isLoading: false,
        enabled: settings.enabled,
        home: settings.home,
        work: settings.work,
        waypoints: settings.waypoints,
        lastCommuteMinutes: settings.lastCommuteMinutes,
        lastCommuteUpdatedAt: settings.lastCommuteUpdatedAt,
        averageCommuteMinutes: averageCommuteMinutes,
        headsUpLeadMinutes: settings.headsUpLeadMinutes,
        workRadiusMeters: settings.workRadiusMeters,
        schedule: schedule,
      ),
    );
  }

  Future<void> toggleEnabled(bool value) async {
    emit(state.copyWith(isTogglingEnabled: true, errorMessage: null));
    final result = await _repository.setEnabled(value);
    switch (result) {
      case EnableLeaveReminderResult.success:
        emit(state.copyWith(isTogglingEnabled: false, enabled: value));
        final settings = await _repository.getSettings();
        final averageCommuteMinutes = await _repository
            .getAverageCommuteMinutes();
        emit(
          state.copyWith(
            lastCommuteMinutes: settings.lastCommuteMinutes,
            lastCommuteUpdatedAt: settings.lastCommuteUpdatedAt,
            averageCommuteMinutes: averageCommuteMinutes,
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
    final averageCommuteMinutes = await _repository.getAverageCommuteMinutes();
    emit(
      state.copyWith(
        isSettingHome: false,
        home: settings.home,
        lastCommuteMinutes: settings.lastCommuteMinutes,
        lastCommuteUpdatedAt: settings.lastCommuteUpdatedAt,
        averageCommuteMinutes: averageCommuteMinutes,
      ),
    );
    if (state.hasBothLocations) refreshCommute();
  }

  Future<void> setWork(GeoPoint point) async {
    emit(state.copyWith(isSettingWork: true, errorMessage: null));
    final settings = await _repository.setWorkLocation(point);
    final averageCommuteMinutes = await _repository.getAverageCommuteMinutes();
    emit(
      state.copyWith(
        isSettingWork: false,
        work: settings.work,
        lastCommuteMinutes: settings.lastCommuteMinutes,
        lastCommuteUpdatedAt: settings.lastCommuteUpdatedAt,
        averageCommuteMinutes: averageCommuteMinutes,
      ),
    );
    if (state.hasBothLocations) refreshCommute();
  }

  Future<void> addWaypoint(GeoPoint point) async {
    emit(state.copyWith(isAddingWaypoint: true, errorMessage: null));
    final settings = await _repository.addWaypoint(point);
    final averageCommuteMinutes = await _repository.getAverageCommuteMinutes();
    emit(
      state.copyWith(
        isAddingWaypoint: false,
        waypoints: settings.waypoints,
        lastCommuteMinutes: settings.lastCommuteMinutes,
        lastCommuteUpdatedAt: settings.lastCommuteUpdatedAt,
        averageCommuteMinutes: averageCommuteMinutes,
      ),
    );
    if (state.hasBothLocations) refreshCommute();
  }

  Future<void> removeWaypointAt(int index) async {
    emit(state.copyWith(removingWaypointIndex: index, errorMessage: null));
    final settings = await _repository.removeWaypointAt(index);
    final averageCommuteMinutes = await _repository.getAverageCommuteMinutes();
    emit(
      state.copyWith(
        removingWaypointIndex: null,
        waypoints: settings.waypoints,
        lastCommuteMinutes: settings.lastCommuteMinutes,
        lastCommuteUpdatedAt: settings.lastCommuteUpdatedAt,
        averageCommuteMinutes: averageCommuteMinutes,
      ),
    );
    if (state.hasBothLocations) refreshCommute();
  }

  Future<void> setWaypointEnabledAt(int index, bool enabled) async {
    emit(state.copyWith(togglingWaypointIndex: index, errorMessage: null));
    final settings = await _repository.setWaypointEnabledAt(index, enabled);
    final averageCommuteMinutes = await _repository.getAverageCommuteMinutes();
    emit(
      state.copyWith(
        togglingWaypointIndex: null,
        waypoints: settings.waypoints,
        lastCommuteMinutes: settings.lastCommuteMinutes,
        lastCommuteUpdatedAt: settings.lastCommuteUpdatedAt,
        averageCommuteMinutes: averageCommuteMinutes,
      ),
    );
    if (state.hasBothLocations) refreshCommute();
  }

  Future<void> setWaypointLocationAt(int index, GeoPoint point) async {
    emit(state.copyWith(repickingWaypointIndex: index, errorMessage: null));
    final settings = await _repository.setWaypointLocationAt(index, point);
    final averageCommuteMinutes = await _repository.getAverageCommuteMinutes();
    emit(
      state.copyWith(
        repickingWaypointIndex: null,
        waypoints: settings.waypoints,
        lastCommuteMinutes: settings.lastCommuteMinutes,
        lastCommuteUpdatedAt: settings.lastCommuteUpdatedAt,
        averageCommuteMinutes: averageCommuteMinutes,
      ),
    );
    if (state.hasBothLocations) refreshCommute();
  }

  Future<void> updateReminderMinutes(int minutes) async {
    final schedule = state.schedule;
    if (schedule == null) return;

    final updated = schedule.copyWith(reminderMinutes: minutes.clamp(0, 60));
    emit(state.copyWith(schedule: updated));
    await _workScheduleRepository.saveWorkSchedule(updated);
    await _repository.scheduleTodayReminders();
  }

  Future<void> updateHeadsUpLeadMinutes(int minutes) async {
    final settings = await _repository.setHeadsUpLeadMinutes(
      minutes.clamp(0, 60),
    );
    emit(state.copyWith(headsUpLeadMinutes: settings.headsUpLeadMinutes));
    await _repository.scheduleTodayReminders();
  }

  Future<void> updateWorkRadiusMeters(int meters) async {
    final settings = await _repository.setWorkRadiusMeters(
      meters.clamp(50, 500),
    );
    emit(state.copyWith(workRadiusMeters: settings.workRadiusMeters));
  }

  Future<void> refreshCommute() async {
    if (!state.hasBothLocations) return;
    emit(state.copyWith(isRefreshingCommute: true, errorMessage: null));
    await _repository.scheduleTodayReminders();
    final settings = await _repository.getSettings();
    final averageCommuteMinutes = await _repository.getAverageCommuteMinutes();
    emit(
      state.copyWith(
        isRefreshingCommute: false,
        lastCommuteMinutes: settings.lastCommuteMinutes,
        lastCommuteUpdatedAt: settings.lastCommuteUpdatedAt,
        averageCommuteMinutes: averageCommuteMinutes,
      ),
    );
  }
}
