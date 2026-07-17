/// Unique name used to register/cancel the Workmanager one-off task that
/// fires ~30 minutes before the scheduled check-in time, triggering
/// [LocationWatchOrchestrator.startArrivalWatchIfScheduled].
const String kLocationWatchWorkmanagerTaskName =
    'location_watch_arrival_trigger';

const int kArrivalLogNotificationId = 9201;
const int kDepartureLogNotificationId = 9202;
