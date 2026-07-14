/// Discovery trigger that caused the leave-reminder setup sheet to
/// auto-pop right after a check-in.
enum LeaveReminderPromptTrigger {
  /// The user just landed a streak of [kOnTimeStreakTarget] consecutive
  /// on-time check-ins.
  onTimeStreak,

  /// This check-in is the user's first-ever late one (no prior check-in in
  /// history has a positive `lateMinutes`).
  firstLateCheckIn,
}
