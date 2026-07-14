import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:injectable/injectable.dart';
import 'package:work_tracker/domain/repository/app_repository.dart';
import 'package:work_tracker/features/schedule/domain/work_schedule_repository.dart';

part 'app_state.dart';

@singleton
class AppCubit extends Cubit<AppState> {
  AppCubit(this._preferences, this._workScheduleRepository)
    : super(AppState(status: AppStatus.loading)) {
    _initialize();
  }

  final AppRepository _preferences;
  final WorkScheduleRepository _workScheduleRepository;

  Future<void> _initialize() async {
    final themeMode = _preferences.themeMode;
    if (_preferences.isOnboardingCompleted) {
      emit(
        AppState(
          status: await _statusAfterOnboarding(),
          themeMode: themeMode,
        ),
      );
    } else {
      emit(AppState(status: AppStatus.onboarding, themeMode: themeMode));
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _preferences.setThemeMode(mode);
    emit(state.copyWith(themeMode: mode));
  }

  Future<AppStatus> _statusAfterOnboarding() async {
    final schedule = await _workScheduleRepository.getCurrentActiveSchedule();
    return schedule == null ? AppStatus.setupSchedule : AppStatus.ready;
  }

  Future<void> completeOnboarding() async {
    await _preferences.completeOnboarding();
    emit(state.copyWith(status: await _statusAfterOnboarding()));
  }

  void onScheduleSaved() {
    emit(state.copyWith(status: AppStatus.ready));
  }

  void skipScheduleSetup() {
    emit(state.copyWith(status: AppStatus.ready));
  }
}
