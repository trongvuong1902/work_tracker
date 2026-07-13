import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_repository.dart';

@LazySingleton(as: AppRepository)
class AppRepositoryImpl implements AppRepository {
  @override
  bool get isOnboardingCompleted =>
      _sharedPreferences.getBool('onboarding_completed') ?? false;

  final SharedPreferences _sharedPreferences;

  AppRepositoryImpl({required this._sharedPreferences});

  @override
  Future<void> completeOnboarding() async {
    await _sharedPreferences.setBool('onboarding_completed', true);
    // Implement the logic to mark onboarding as completed
  }
}
