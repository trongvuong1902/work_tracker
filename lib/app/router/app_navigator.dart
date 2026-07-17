import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:work_tracker/app/router/app_router.dart';
import 'package:work_tracker/app/router/app_routes.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/geo_point.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_bug_attachment.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_import_kind.dart';

abstract final class AppNavigator {
  const AppNavigator._();

  static void goHome(BuildContext context) => context.go(AppRoutes.home);

  static void goCalendar(BuildContext context) =>
      context.go(AppRoutes.calendar);

  static void goTasks(BuildContext context) => context.go(AppRoutes.tasks);

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

  static Future<void> pushAttendance(BuildContext context) =>
      context.push(AppRoutes.attendance);

  static Future<void> pushAttendanceDetail(
    BuildContext context,
    DateTime date,
  ) => context.push(
    AppRoutes.attendanceDetail.replaceFirst(
      ':date',
      date.toIso8601String().split('T').first,
    ),
  );

  /// Pushes the Task Detail page for [taskId]. The task list always
  /// refreshes itself on return, whether the task changed or the page was
  /// just dismissed, so no return value is needed here.
  static Future<void> pushTaskDetail(BuildContext context, int taskId) =>
      context.push(AppRoutes.taskDetail, extra: taskId);

  static Future<void> pushManualTaskForm(BuildContext context) =>
      context.push(AppRoutes.taskManualForm);

  static Future<void> pushTaskImportPlatformPicker(BuildContext context) =>
      context.push(AppRoutes.taskImportPlatformPicker);

  /// Pushed both from the import flow (Platform Picker -> not connected)
  /// and from Settings' "Manage Zentao connection" flow indirectly via
  /// [pushTaskImportPlatformPicker]'s chain.
  static Future<void> pushZentaoConnect(BuildContext context) =>
      context.push(AppRoutes.zentaoConnect);

  /// Pushed when the account is already connected — the user still needs to
  /// pick Tasks vs Bugs.
  static Future<void> pushZentaoSelectOption(BuildContext context) =>
      context.push(AppRoutes.zentaoSelectOption);

  /// Replaces the current route (the Connect page) with the Select Option
  /// screen on a successful connect, so the back button from there returns
  /// to the Platform Picker, not back to the connect form.
  static void pushReplacementZentaoSelectOption(BuildContext context) =>
      context.pushReplacement(AppRoutes.zentaoSelectOption);

  static Future<void> pushZentaoProductPicker(
    BuildContext context, {
    required ZentaoImportKind kind,
  }) => context.push(AppRoutes.zentaoProductPicker, extra: kind);

  /// The product multi-select step of the bulk "Bugs assigned to me" sync.
  /// Resolves to `true` once the user saves a selection.
  static Future<bool?> pushBugSyncProducts(BuildContext context) =>
      context.push<bool>(AppRoutes.bugSyncProducts);

  static Future<void> pushAttachmentViewer(
    BuildContext context,
    ZentaoBugAttachment attachment,
  ) => context.push(AppRoutes.attachmentViewer, extra: attachment);
}
