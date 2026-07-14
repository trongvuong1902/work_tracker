import 'package:workmanager/workmanager.dart';

import '../../../di/injection.dart';
import '../domain/leave_reminder_repository.dart';

/// Workmanager entry point. Runs in a separate background isolate, so DI
/// needs to be re-configured from scratch before it can resolve
/// [LeaveReminderRepository].
///
/// Best-effort: the daily Distance Matrix refresh happens here, but failures
/// are swallowed since the app-open fallback (`bootstrap.dart`) covers any
/// misses, especially on iOS where background execution is opportunistic.
@pragma('vm:entry-point')
void leaveReminderCallbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      await configureDependencies();
      await getIt<LeaveReminderRepository>().scheduleTodayReminders();
    } catch (_) {
      // Swallow errors — best-effort background refresh.
    }
    return true;
  });
}
