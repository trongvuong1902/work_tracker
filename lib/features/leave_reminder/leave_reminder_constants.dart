/// Fixed lead time (minutes) for the "heads-up" notification before the
/// computed leave time. Not user-configurable for MVP.
const int kDefaultHeadsUpLeadMinutes = 45;

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
const String kLeaveReminderWorkmanagerTaskName =
    'leave_reminder_daily_refresh';

/// SharedPreferences key backing the "intro prompt already shown" flag —
/// the leave-reminder setup sheet auto-triggers at most once, ever.
const String kIntroPromptShownKey = 'leave_reminder_intro_prompt_shown';
