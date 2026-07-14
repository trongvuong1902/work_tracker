import 'package:flutter/material.dart' show ThemeMode;

abstract class AppRepository {
  bool get isOnboardingCompleted;

  Future<void> completeOnboarding();

  ThemeMode get themeMode;

  Future<void> setThemeMode(ThemeMode mode);
}
