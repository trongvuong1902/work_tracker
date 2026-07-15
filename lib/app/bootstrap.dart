// This file is responsible for:
// * Initialize ObjectBox
// * Initialize Local Notifications
// * Configure Timezone
// * Register GetIt
// * Setup BlocObserver
// * Handle global errors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';
import 'package:work_tracker/app/app.dart';
import 'package:work_tracker/core/notifications/notification_service.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/checkout_reminder/domain/checkout_reminder_repository.dart';
import 'package:work_tracker/features/leave_reminder/data/leave_reminder_background_dispatcher.dart';
import 'package:work_tracker/features/leave_reminder/domain/leave_reminder_repository.dart';

Future<void> bootstrap() async {
  await configureDependencies();

  await getIt<NotificationService>().initialize();
  Workmanager().initialize(leaveReminderCallbackDispatcher);
  unawaited(getIt<LeaveReminderRepository>().scheduleTodayReminders().catchError((_) {}));
  // Force-construct so its constructor subscribes to the attendance stream
  // before any check-in/check-out can happen.
  getIt<CheckoutReminderRepository>();

  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
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
    debugPrint('onChange -- ${bloc.runtimeType}, $change');
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
