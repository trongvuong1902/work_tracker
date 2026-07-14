/// Default working-days bitmask used when no schedule has been saved yet.
/// Bit0..Bit6 correspond to DateTime.weekday 1..7 (Mon..Sun) via
/// `1 << (weekday - 1)`. This default covers Monday-Friday (0b0011111).
const int kDefaultWorkingDaysMask = 31;

/// Selectable values (minutes) for [WorkSchedule.reminderMinutes] — how many
/// minutes before [WorkSchedule.startMinuteOfDay] the user wants to arrive.
/// Shared between the schedule setup screen and the leave-reminder sheet so
/// both editors offer the same options.
const List<int> kReminderBufferOptions = [
  0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60,
];
