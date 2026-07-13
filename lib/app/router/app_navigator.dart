import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
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
}
