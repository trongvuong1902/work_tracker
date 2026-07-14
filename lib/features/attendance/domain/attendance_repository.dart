import 'models/attendance.dart';

abstract class AttendanceRepository {
  Future<Attendance?> getTodayAttendance();
  Future<Attendance> checkIn(DateTime time);
  Future<Attendance> checkOut(DateTime time);
  Stream<Attendance?> watchAttendanceChanges();

  /// Most-recent-first attendance history, capped at [limit] rows.
  Future<List<Attendance>> getRecentAttendances({int limit = 10});

  void clearTodayAttendance();
}
