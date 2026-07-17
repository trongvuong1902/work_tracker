import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:work_tracker/features/leave_reminder/domain/leave_reminder_repository.dart';
import 'package:work_tracker/features/location_log/domain/location_log_repository.dart';
import 'package:work_tracker/features/location_log/domain/location_watch_orchestrator.dart';

part 'location_log_setup_state.dart';
part 'location_log_setup_cubit.freezed.dart';

@injectable
class LocationLogSetupCubit extends Cubit<LocationLogSetupState> {
  LocationLogSetupCubit(
    this._locationLogRepository,
    this._leaveReminderRepository,
    this._orchestrator,
  ) : super(const LocationLogSetupState()) {
    _load();
  }

  final LocationLogRepository _locationLogRepository;
  final LeaveReminderRepository _leaveReminderRepository;
  final LocationWatchOrchestrator _orchestrator;

  Future<void> _load() async {
    emit(state.copyWith(isLoading: true));
    final enabled = await _locationLogRepository.isEnabled();
    final settings = await _leaveReminderRepository.getSettings();
    emit(
      state.copyWith(
        isLoading: false,
        enabled: enabled,
        hasWorkLocation: settings.work != null,
      ),
    );
  }

  /// Reloads just the "work location set?" status — called after returning
  /// from the leave-reminder setup sheet where Work is actually set (§2:
  /// shared with `leave_reminder`, not duplicated here).
  Future<void> refreshWorkLocationStatus() async {
    final settings = await _leaveReminderRepository.getSettings();
    emit(state.copyWith(hasWorkLocation: settings.work != null));
  }

  Future<void> toggleEnabled(bool value) async {
    emit(state.copyWith(isTogglingEnabled: true, errorMessage: null));

    if (!value) {
      await _locationLogRepository.setEnabled(false);
      await _orchestrator.scheduleNextArrivalWatch();
      emit(state.copyWith(isTogglingEnabled: false, enabled: false));
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      emit(
        state.copyWith(
          isTogglingEnabled: false,
          errorMessage:
              'Location permission is off for WorkTracker. Enable it in '
              'system settings to turn on location activity tracking.',
        ),
      );
      return;
    }

    if (permission == LocationPermission.whileInUse) {
      // Escalate to background/"Always" — the arrival/departure watch needs
      // to keep running while the app isn't in the foreground. Falls back
      // to while-in-use-only tracking if the user declines this step.
      permission = await Geolocator.requestPermission();
    }

    await _locationLogRepository.setEnabled(true);
    await _orchestrator.scheduleNextArrivalWatch();
    emit(state.copyWith(isTogglingEnabled: false, enabled: true));
  }
}
