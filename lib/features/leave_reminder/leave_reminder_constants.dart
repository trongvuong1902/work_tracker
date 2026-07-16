/// Default lead time (minutes) for the "heads-up" notification before the
/// computed leave time, used until the user picks their own value via
/// [kHeadsUpLeadOptions] in the leave-reminder setup sheet.
const int kDefaultHeadsUpLeadMinutes = 15;

/// Selectable values (minutes) for the "notify before leaving" heads-up lead
/// time.
const List<int> kHeadsUpLeadOptions = [5, 10, 15, 20, 30, 45, 60];

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
