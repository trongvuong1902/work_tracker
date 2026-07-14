import 'package:flutter/material.dart' show ThemeMode;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_repository.dart';

const _themeModeKey = 'theme_mode';

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

  @override
  ThemeMode get themeMode {
    final name = _sharedPreferences.getString(_themeModeKey);
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == name,
      orElse: () => ThemeMode.system,
    );
  }

  @override
  Future<void> setThemeMode(ThemeMode mode) =>
      _sharedPreferences.setString(_themeModeKey, mode.name);
}
