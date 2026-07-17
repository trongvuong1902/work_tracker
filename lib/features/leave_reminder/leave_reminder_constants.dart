/// Default lead time (minutes) for the "heads-up" notification before the
/// computed leave time, used until the user picks their own value via
/// [kHeadsUpLeadOptions] in the leave-reminder setup sheet.
const int kDefaultHeadsUpLeadMinutes = 15;

/// Selectable values (minutes) for the "notify before leaving" heads-up lead
/// time.
const List<int> kHeadsUpLeadOptions = [5, 10, 15, 20, 30, 45, 60];

/// Selectable values (meters) for the work-location geofence radius used by
/// the location-activity arrival/departure watch.
const List<int> kWorkRadiusOptions = [
  50,
  75,
  100,
  125,
  150,
  200,
  250,
  300,
  400,
  500,
];

/// Number of consecutive on-time check-ins required to trigger the
/// "on-time streak" discovery prompt for leave reminders.
const int kOnTimeStreakTarget = 3;

/// Local notification id for the morning "heads-up" (weather + traffic +
/// planned leave time) reminder.
const int kHeadsUpNotificationId = 9001;

/// Local notification id for the "time to leave" alert.
const int kLeaveNowNotificationId = 9002;

/// Unique name used to register/cancel the Workmanager periodic task that
/// recomputes and reschedules today's leave reminders.
const String kLeaveReminderWorkmanagerTaskName = 'leave_reminder_daily_refresh';

/// SharedPreferences key backing the "intro prompt already shown" flag —
/// the leave-reminder setup sheet auto-triggers at most once, ever.
const String kIntroPromptShownKey = 'leave_reminder_intro_prompt_shown';

/// How far back commute samples are kept/considered when computing the
/// rolling average commute duration. Samples older than this are pruned.
const Duration kCommuteHistoryWindow = Duration(days: 14);

/// Minimum spacing enforced between recorded commute samples — successful
/// live fetches within this window of the most recent sample don't add a
/// new one, so rapid manual refreshes (or frequent background runs) can't
/// skew the average with near-duplicate readings.
const Duration kCommuteSampleCooldown = Duration(minutes: 15);

/// Maximum number of optional "stop" waypoints allowed along the commute
/// route, in addition to the fixed Home/Work endpoints.
const int kMaxCommuteWaypoints = 3;

/// How far back scheduled-notification log entries are kept/considered —
/// a debug-only fire/no-fire trace, not an averaging input, so a much
/// shorter window than [kCommuteHistoryWindow] is enough.
const Duration kNotificationLogWindow = Duration(days: 7);
