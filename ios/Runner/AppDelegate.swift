import Flutter
import GoogleMaps
import UIKit
import workmanager_apple

/// Unique Workmanager task identifier used to recompute and reschedule the
/// leave-reminder notifications daily. Must match `kLeaveReminderWorkmanagerTaskName`
/// in `lib/features/leave_reminder/leave_reminder_constants.dart` and the
/// `BGTaskSchedulerPermittedIdentifiers` entry in Info.plist.
private let leaveReminderBackgroundTaskIdentifier = "leave_reminder_daily_refresh"

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if let mapsApiKey = Bundle.main.object(forInfoDictionaryKey: "GMSApiKey") as? String,
      !mapsApiKey.isEmpty
    {
      GMSServices.provideAPIKey(mapsApiKey)
    }

    // Must be registered before this method returns, per Apple's
    // BGTaskScheduler requirements.
    WorkmanagerPlugin.registerPeriodicTask(
      withIdentifier: leaveReminderBackgroundTaskIdentifier,
      frequency: NSNumber(value: 6 * 60 * 60)
    )

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
