import 'models/attendance.dart';

abstract class AttendanceRepository {
  Future<Attendance?> getTodayAttendance();

  /// Creates today's check-in, or corrects an existing one. The **date
  /// component of [time]** determines which day's record is affected — not
  /// necessarily today — so this can also be used to create/correct a past
  /// day's check-in (e.g. from the Calendar tab).
  Future<Attendance> checkIn(DateTime time);

  /// Creates today's check-out, or corrects an existing one. The **date
  /// component of [time]** determines which day's record is affected — not
  /// necessarily today — so this can also be used to create/correct a past
  /// day's check-out (e.g. from the Calendar tab).
  Future<Attendance> checkOut(DateTime time);
  Stream<Attendance?> watchAttendanceChanges();

  /// Most-recent-first attendance history, capped at [limit] rows.
  Future<List<Attendance>> getRecentAttendances({int limit = 10});

  /// Attendance rows for the given [year]/[month], keyed by dayKey
  /// (`yyyyMMdd`).
  Future<Map<int, Attendance>> getAttendanceForMonth({
    required int year,
    required int month,
  });

  void clearTodayAttendance();
}
