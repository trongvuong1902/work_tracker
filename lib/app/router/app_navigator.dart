import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:work_tracker/app/router/app_router.dart';
import 'package:work_tracker/app/router/app_routes.dart';

abstract final class AppNavigator {
  const AppNavigator._();

  static void goHome(BuildContext context) => context.go(AppRoutes.home);

  static void goCalendar(BuildContext context) =>
      context.go(AppRoutes.calendar);

  static void goStatistics(BuildContext context) =>
      context.go(AppRoutes.statistics);

  static void goSettings(BuildContext context) =>
      context.go(AppRoutes.settings);

  static void pushWorkScheduleSettings(BuildContext context) =>
      context.push(AppRoutes.workScheduleSettings);

  static void pushOnboarding(BuildContext context) =>
      context.push(AppRoutes.onboarding);

  static void pushDebug(BuildContext context) => context.push(AppRoutes.debug);

  static void pushPrivacyPolicy(BuildContext context) =>
      context.push(AppRoutes.privacyPolicy);

  static Future<LatLng?> pushLocationPicker(
    BuildContext context, {
    LatLng? initial,
    required String title,
  }) async {
    final result = await context.push<LatLng?>(
      AppRoutes.leaveReminderLocationPicker,
      extra: LocationPickerArgs(title: title, initial: initial),
    );
    return result;
  }
}
