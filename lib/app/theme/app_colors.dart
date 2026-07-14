import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.primaryLight,
    required this.secondary,
    required this.tertiary,
    required this.success,
    required this.warning,
    required this.error,
    required this.background,
    required this.surface,
    required this.surfaceSecondary,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
    required this.outline,
  });

  final Color primary;
  final Color primaryLight;
  final Color secondary;
  final Color tertiary;
  final Color success;
  final Color warning;
  final Color error;

  final Color background;
  final Color surface;
  final Color surfaceSecondary;

  final Color textPrimary;
  final Color textSecondary;

  final Color divider;
  final Color outline;

  static const light = AppColors(
    primary: Color(0xFF22C55E),
    primaryLight: Color(0xFFDDF7E5),
    secondary: Color(0xFF6366F1),
    tertiary: Color(0xFFD946EF),
    success: Color(0xFF10B981),
    warning: Color(0xFFF59E0B),
    error: Color(0xFFEF4444),
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    surfaceSecondary: Color(0xFFF1F5F9),
    textPrimary: Color(0xFF111827),
    textSecondary: Color(0xFF6B7280),
    divider: Color(0xFFE5E7EB),
    outline: Color(0xFFE5E9F0),
  );

  static const dark = AppColors(
    primary: Color(0xFF22C55E),
    primaryLight: Color(0xFF14311F),
    secondary: Color(0xFF6366F1),
    tertiary: Color(0xFFD946EF),
    success: Color(0xFF10B981),
    warning: Color(0xFFF59E0B),
    error: Color(0xFFEF4444),
    background: Color(0xFF0F172A),
    surface: Color(0xFF1E293B),
    surfaceSecondary: Color(0xFF273449),
    textPrimary: Color(0xFFF1F5F9),
    textSecondary: Color(0xFF94A3B8),
    divider: Color(0xFF334155),
    outline: Color(0xFF334155),
  );

  @override
  AppColors copyWith({
    Color? primary,
    Color? primaryLight,
    Color? secondary,
    Color? tertiary,
    Color? success,
    Color? warning,
    Color? error,
    Color? background,
    Color? surface,
    Color? surfaceSecondary,
    Color? textPrimary,
    Color? textSecondary,
    Color? divider,
    Color? outline,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      primaryLight: primaryLight ?? this.primaryLight,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      divider: divider ?? this.divider,
      outline: outline ?? this.outline,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceSecondary: Color.lerp(
        surfaceSecondary,
        other.surfaceSecondary,
        t,
      )!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
    );
  }
}

extension AppColorsX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
