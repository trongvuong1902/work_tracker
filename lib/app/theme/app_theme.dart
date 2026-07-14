import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.light.background,
    colorScheme: ColorScheme.light(
      primary: AppColors.light.primary,
      onPrimary: Colors.white,
      secondary: AppColors.light.primaryLight,
      onSecondary: AppColors.light.textPrimary,
      surface: AppColors.light.surface,
      onSurface: AppColors.light.textPrimary,
      error: AppColors.light.error,
      onError: Colors.white,
      outline: AppColors.light.outline,
    ),
    extensions: [AppColors.light],
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.dark.background,
    colorScheme: ColorScheme.dark(
      primary: AppColors.dark.primary,
      onPrimary: Colors.white,
      secondary: AppColors.dark.primaryLight,
      onSecondary: AppColors.dark.textPrimary,
      surface: AppColors.dark.surface,
      onSurface: AppColors.dark.textPrimary,
      error: AppColors.dark.error,
      onError: Colors.white,
      outline: AppColors.dark.outline,
    ),
    extensions: [AppColors.dark],
  );
}
