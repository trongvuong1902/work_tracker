part of 'app_cubit.dart';

enum AppStatus { loading, onboarding, setupSchedule, ready }

class AppState {
  final AppStatus status;

  const AppState({required this.status});
}
