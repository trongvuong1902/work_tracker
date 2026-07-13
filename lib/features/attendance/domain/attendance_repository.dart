import 'models/attendance.dart';

abstract class AttendanceRepository {
  Future<Attendance?> getTodayAttendance();
  Future<Attendance> checkIn(DateTime time);
  Future<Attendance> checkOut(DateTime time);
}
