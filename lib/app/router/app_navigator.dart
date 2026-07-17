import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:work_tracker/app/router/app_router.dart';
import 'package:work_tracker/app/router/app_routes.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/geo_point.dart';

abstract final class AppNavigator {
  const AppNavigator._();

  static void goHome(BuildContext context) => context.go(AppRoutes.home);

  static void goCalendar(BuildContext context) =>
      context.go(AppRoutes.calendar);

  static void goStatistics(BuildContext context) =>
      context.go(AppRoutes.statistics);

  static void goSettings(BuildContext context) =>
      context.go(AppRoutes.settings);

  static Future<void> pushWorkScheduleSettings(BuildContext context) async {
    await context.push(AppRoutes.workScheduleSettings);
  }

  static void pushOnboarding(BuildContext context) =>
      context.push(AppRoutes.onboarding);

  static void pushDebug(BuildContext context) => context.push(AppRoutes.debug);

  static void pushDebugComponents(BuildContext context) =>
      context.push(AppRoutes.debugComponents);

  static void pushDebugOnboardingPreview(BuildContext context) =>
      context.push(AppRoutes.debugOnboardingPreview);

  static void pushDebugNotificationsFlow(BuildContext context) =>
      context.push(AppRoutes.debugNotificationsFlow);

  static void pushPrivacyPolicy(BuildContext context) =>
      context.push(AppRoutes.privacyPolicy);

  static Future<GeoPoint?> pushLocationPicker(
    BuildContext context, {
    GeoPoint? initial,
    required String title,
  }) async {
    final result = await context.push<GeoPoint?>(
      AppRoutes.leaveReminderLocationPicker,
      extra: LocationPickerArgs(title: title, initial: initial),
    );
    return result;
  }
}
