part of 'app_cubit.dart';

enum AppStatus { loading, onboarding, setupSchedule, ready }

class AppState {
  final AppStatus status;
  final ThemeMode themeMode;

  const AppState({required this.status, this.themeMode = ThemeMode.system});

  AppState copyWith({AppStatus? status, ThemeMode? themeMode}) => AppState(
    status: status ?? this.status,
    themeMode: themeMode ?? this.themeMode,
  );
}
