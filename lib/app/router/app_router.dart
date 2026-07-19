import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:work_tracker/app/router/app_routes.dart';
import 'package:work_tracker/app/router/app_shell.dart';
import 'package:work_tracker/app/router/calendar_branch.dart';
import 'package:work_tracker/app/router/home_branch.dart';
import 'package:work_tracker/app/router/setting_branch.dart';
import 'package:work_tracker/debug/notifications_debug_page.dart';
import 'package:work_tracker/debug/components_showcase_page.dart';
import 'package:work_tracker/debug/debug_tools_page.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/app/cubit/app_cubit.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/geo_point.dart';
import 'package:work_tracker/features/leave_reminder/presentation/pages/location_picker_page.dart';
import 'package:work_tracker/features/location_log/presentation/pages/location_activity_day_page.dart';
import 'package:work_tracker/features/location_log/presentation/pages/location_activity_page.dart';
import 'package:work_tracker/features/onboard/presentation/pages/onboard_page.dart';
import 'package:work_tracker/features/schedule/presentation/pages/setting_schedule_page.dart';
import 'package:work_tracker/features/setting/presentation/pages/privacy_policy_page.dart';
import 'package:work_tracker/features/splash/presentation/pages/splash_page.dart';
import 'package:work_tracker/features/work_item/presentation/pages/attachment_viewer_page.dart';
import 'package:work_tracker/features/work_item/presentation/pages/bug_sync_products_page.dart';
import 'package:work_tracker/features/work_item/presentation/pages/manual_task_form_page.dart';
import 'package:work_tracker/features/work_item/presentation/pages/platform_picker_page.dart';
import 'package:work_tracker/features/work_item/presentation/pages/work_item_detail_page.dart';
import 'package:work_tracker/features/work_item/presentation/pages/work_item_time_log_page.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_bug_attachment.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_import_kind.dart';
import 'package:work_tracker/features/zentao/presentation/pages/zentao_connect_page.dart';
import 'package:work_tracker/features/zentao/presentation/pages/zentao_product_picker_page.dart';

import 'work_item_branch.dart';

/// Typed `state.extra` payload for [AppRoutes.leaveReminderLocationPicker].
class LocationPickerArgs {
  const LocationPickerArgs({required this.title, this.initial});

  final String title;
  final GeoPoint? initial;
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  refreshListenable: AppStateChangeNotify(getIt<AppCubit>()),
  redirect: (context, state) {
    final status = getIt<AppCubit>().state.status;
    final location = state.matchedLocation;
    final isOnboarding = location == AppRoutes.onboarding;
    final isSetupSchedule = location == AppRoutes.workScheduleSettings;

    if (status == AppStatus.loading) {
      return AppRoutes.login;
    }

    if (status == AppStatus.onboarding && !isOnboarding) {
      return AppRoutes.onboarding;
    }

    if (status == AppStatus.setupSchedule && !isSetupSchedule) {
      return AppRoutes.workScheduleSettings;
    }

    if (status == AppStatus.ready && isOnboarding) {
      return AppRoutes.home;
    }

    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnBoardPage(),
    ),
    GoRoute(
      path: AppRoutes.debug,
      builder: (context, state) => const DebugToolsPage(),
    ),
    GoRoute(
      path: AppRoutes.debugComponents,
      builder: (context, state) => const ComponentsShowcasePage(),
    ),
    GoRoute(
      path: AppRoutes.debugOnboardingPreview,
      builder: (context, state) => const OnBoardPage(),
    ),
    GoRoute(
      path: AppRoutes.debugNotificationsFlow,
      builder: (context, state) => const NotificationsDebugPage(),
    ),
    GoRoute(
      path: AppRoutes.workScheduleSettings,
      builder: (context, state) => const SettingSchedulePage(),
    ),
    GoRoute(
      path: AppRoutes.privacyPolicy,
      builder: (context, state) => const PrivacyPolicyPage(),
    ),
    GoRoute(
      path: AppRoutes.leaveReminderLocationPicker,
      builder: (context, state) {
        final args = state.extra as LocationPickerArgs?;
        return LocationPickerPage(
          title: args?.title ?? 'Pick a location',
          initial: args?.initial,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.attendance,
      builder: (context, state) => const LocationActivityPage(),
    ),
    GoRoute(
      path: AppRoutes.attendanceDetail,
      builder: (context, state) {
        final dateParam = state.pathParameters['date']!;
        return LocationActivityDayPage(date: DateTime.parse(dateParam));
      },
    ),
    GoRoute(
      path: AppRoutes.taskDetail,
      builder: (context, state) {
        final taskId = state.extra as int;
        return WorkItemDetailPage(taskId: taskId);
      },
    ),
    GoRoute(
      path: AppRoutes.taskTimes,
      builder: (context, state) => const WorkItemTimeLogPage(),
    ),
    GoRoute(
      path: AppRoutes.taskManualForm,
      builder: (context, state) => const ManualTaskFormPage(),
    ),
    GoRoute(
      path: AppRoutes.taskImportPlatformPicker,
      builder: (context, state) => const PlatformPickerPage(),
    ),
    GoRoute(
      path: AppRoutes.zentaoConnect,
      builder: (context, state) => const ZentaoConnectPage(),
    ),
    GoRoute(
      path: AppRoutes.zentaoProductPicker,
      builder: (context, state) {
        final kind = state.extra as ZentaoImportKind;
        return ZentaoProductPickerPage(kind: kind);
      },
    ),
    GoRoute(
      path: AppRoutes.bugSyncProducts,
      builder: (context, state) => const BugSyncProductsPage(),
    ),
    GoRoute(
      path: AppRoutes.attachmentViewer,
      builder: (context, state) {
        final attachment = state.extra as ZentaoBugAttachment;
        return AttachmentViewerPage(attachment: attachment);
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [HomeBranch(), CalendarBranch(), TaskBranch(), SettingBranch()],
    ),
  ],
);

class AppStateChangeNotify extends ChangeNotifier {
  AppStateChangeNotify(this._appCubit) {
    _subscription = _appCubit.stream.listen((state) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;
  final AppCubit _appCubit;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
