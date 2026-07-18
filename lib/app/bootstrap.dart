// This file is responsible for:
// * Initialize ObjectBox
// * Initialize Local Notifications
// * Configure Timezone
// * Register GetIt
// * Setup BlocObserver
// * Handle global errors

import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';
import 'package:work_tracker/app/app.dart';
import 'package:work_tracker/core/notifications/notification_service.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/checkout_reminder/domain/checkout_reminder_repository.dart';
import 'package:work_tracker/features/leave_reminder/data/leave_reminder_background_dispatcher.dart';
import 'package:work_tracker/features/leave_reminder/domain/leave_reminder_repository.dart';
import 'package:work_tracker/features/location_log/domain/location_log_repository.dart';
import 'package:work_tracker/features/location_log/domain/location_watch_orchestrator.dart';

Future<void> bootstrap() async {
  // Firebase/Crashlytics is not essential to core app function (attendance/
  // task tracking works without it), so a failure here must never block
  // startup.
  try {
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  } catch (error, stack) {
    debugPrint('bootstrap: Firebase.initializeApp() failed: $error\n$stack');
  }

  // ObjectBox/DI underpins the whole app, so a failure here is fatal: report
  // it (best-effort) and show a minimal fallback screen instead of hanging
  // on the native splash forever.
  try {
    await configureDependencies();
  } catch (error, stack) {
    debugPrint('bootstrap: configureDependencies() failed: $error\n$stack');
    try {
      await FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    } catch (_) {
      // Best-effort only; Firebase itself may have failed to init above.
    }
    runApp(const BootstrapFailedApp());
    return;
  }

  try {
    await getIt<NotificationService>().initialize();
  } catch (error, stack) {
    debugPrint(
      'bootstrap: NotificationService.initialize() failed: $error\n$stack',
    );
  }

  try {
    Workmanager().initialize(appBackgroundCallbackDispatcher);
  } catch (error, stack) {
    debugPrint('bootstrap: Workmanager().initialize() failed: $error\n$stack');
  }

  unawaited(
    getIt<LeaveReminderRepository>().scheduleTodayReminders().catchError(
      (_) {},
    ),
  );
  // Force-construct so its constructor subscribes to the attendance stream
  // before any check-in/check-out can happen.
  getIt<CheckoutReminderRepository>();

  try {
    if (await getIt<LocationLogRepository>().isEnabled()) {
      final orchestrator = getIt<LocationWatchOrchestrator>();
      await orchestrator.resumeIfNeeded();
      await orchestrator.scheduleNextArrivalWatch();
    }
  } catch (error, stack) {
    debugPrint(
      'bootstrap: location watch resume/schedule failed: $error\n$stack',
    );
  }

  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

/// Minimal last-resort fallback shown when [configureDependencies] fails,
/// so the native splash screen always resolves to something visible.
class BootstrapFailedApp extends StatelessWidget {
  const BootstrapFailedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'WorkTracker failed to start. Please restart the app.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // debugPrint('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }
}
