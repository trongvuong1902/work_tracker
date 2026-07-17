import 'package:objectbox/objectbox.dart';
import 'package:workmanager/workmanager.dart';

import '../../../di/injection.dart';
import '../../location_log/domain/location_watch_orchestrator.dart';
import '../../location_log/location_log_constants.dart';
import '../domain/leave_reminder_repository.dart';
import '../leave_reminder_constants.dart';

/// Workmanager entry point. Runs in a separate background isolate, so DI
/// needs to be re-configured from scratch before it can resolve any
/// dependency. `Workmanager().initialize(...)` only accepts a single
/// top-level callback for the whole app, so every background task type
/// (leave-reminder refresh, location-watch arrival trigger) branches off
/// this one dispatcher rather than registering separate ones.
///
/// Best-effort: each branch's failure is swallowed since the app-open
/// fallback (`bootstrap.dart`) covers any misses, especially on iOS where
/// background execution is opportunistic.
@pragma('vm:entry-point')
void appBackgroundCallbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      await configureDependencies();
      switch (task) {
        case kLeaveReminderWorkmanagerTaskName:
          await getIt<LeaveReminderRepository>().scheduleTodayReminders();
        case kLocationWatchWorkmanagerTaskName:
          await getIt<LocationWatchOrchestrator>()
              .startArrivalWatchIfScheduled();
      }
    } catch (_) {
      // Swallow errors — best-effort background refresh.
    } finally {
      // Release this isolate's Store handle so it never lingers and blocks
      // the next openStore() call (background or main-isolate cold start).
      if (getIt.isRegistered<Store>()) {
        getIt<Store>().close();
      }
      await getIt.reset();
    }
    return true;
  });
}
