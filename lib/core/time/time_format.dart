const monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

/// Monday-first weekday initials (Mon..Sun).
const weekdayInitials = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

abstract final class TimeFormat {
  static String hhMm(int minuteOfDay) {
    final hours = (minuteOfDay ~/ 60) % 24;
    final minutes = minuteOfDay % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  static String hhMmFromDateTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  static String hMm(int totalMinutes) {
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    return '${hours}h ${minutes.toString().padLeft(2, '0')}m';
  }

  static String mSs(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes}m ${seconds.toString().padLeft(2, '0')}s';
  }

  /// Formats a date as "Month Year" (e.g. "July 2026").
  static String monthYearLabel(DateTime date) {
    return '${monthNames[date.month - 1]} ${date.year}';
  }

  /// Formats [totalMinutes] as a plain total-minutes label (e.g. "245m"),
  /// used as the alternate display format for hour/minute durations like
  /// [hMm].
  static String totalMinutesLabel(int totalMinutes) => '${totalMinutes}m';
}
