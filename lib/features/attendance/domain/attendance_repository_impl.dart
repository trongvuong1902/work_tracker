import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:work_tracker/features/schedule/data/work_schedule_dao.dart';

import '../../../database/attendance/attendance_entity.dart';
import '../data/attendance_dao.dart';
import 'attendance_repository.dart';
import 'models/attendance.dart';

@LazySingleton(as: AttendanceRepository)
class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceDao _dao;
  final WorkScheduleDao _workdScheduleDao;

  AttendanceRepositoryImpl(this._dao, this._workdScheduleDao);

  final _attendanceChangesController =
      StreamController<Attendance?>.broadcast();

  @override
  Future<Attendance?> getTodayAttendance() async {
    final entity = _dao.getByDayKey(_todayDayKey());
    _attendanceChangesController.add(entity == null ? null : _toModel(entity));
    return entity == null ? null : _toModel(entity);
  }

  @override
  Future<Attendance> checkIn(DateTime time) async {
    final dayKey = _todayDayKey();
    final existing = _dao.getByDayKey(dayKey);

    if (existing == null) {
      final schedule = _workdScheduleDao.get();
      final expectedStartMinute = schedule?.startMinute ?? 0;
      final entity = AttendanceEntity(
        workDate: _todayWorkDate(),
        dayKey: dayKey,
        checkIn: time,
        checkOut: null,
        expectedStartMinute: expectedStartMinute,
        expectedEndMinute: schedule?.endMinute ?? 0,
        lunchMinutes: schedule?.lunchMinutes ?? 0,
        workedMinutes: 0,
        lateMinutes: _lateMinutes(time, expectedStartMinute),
      );
      _dao.save(entity);
      _attendanceChangesController.add(_toModel(entity));
      return _toModel(entity);
    }

    if (existing.checkOut != null && !time.isBefore(existing.checkOut!)) {
      throw StateError('Check-in time must be before check-out time');
    }

    existing.checkIn = time;
    existing.lateMinutes = _lateMinutes(time, existing.expectedStartMinute);
    existing.isEdited = true;
    existing.editedAt = DateTime.now();
    _dao.save(existing);
    _attendanceChangesController.add(_toModel(existing));
    return _toModel(existing);
  }

  @override
  Future<Attendance> checkOut(DateTime time) async {
    final existing = _dao.getByDayKey(_todayDayKey());

    if (existing == null || existing.checkIn == null) {
      throw StateError('Cannot check out before checking in');
    }

    if (!time.isAfter(existing.checkIn!)) {
      throw StateError('Check-out time must be after check-in time');
    }

    // Only a genuine edit (re-setting an already-completed check-out) counts
    // as "edited" — the first check-out of the day is the normal flow.
    if (existing.checkOut != null) {
      existing.isEdited = true;
      existing.editedAt = DateTime.now();
    }
    existing.checkOut = time;

    final workedMinutes =
        time.difference(existing.checkIn!).inMinutes - existing.lunchMinutes;
    existing.workedMinutes = workedMinutes > 0 ? workedMinutes : 0;

    final checkOutMinute = _minuteOfDay(time);
    existing.overtimeMinutes = checkOutMinute > existing.expectedEndMinute
        ? checkOutMinute - existing.expectedEndMinute
        : 0;
    existing.earlyLeaveMinutes = checkOutMinute < existing.expectedEndMinute
        ? existing.expectedEndMinute - checkOutMinute
        : 0;

    _dao.save(existing);
    _attendanceChangesController.add(_toModel(existing));
    return _toModel(existing);
  }

  int _lateMinutes(DateTime checkInTime, int expectedStartMinute) {
    final checkInMinute = _minuteOfDay(checkInTime);
    return checkInMinute > expectedStartMinute
        ? checkInMinute - expectedStartMinute
        : 0;
  }

  int _minuteOfDay(DateTime dateTime) => dateTime.hour * 60 + dateTime.minute;

  DateTime _todayWorkDate() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  int _todayDayKey() {
    final workDate = _todayWorkDate();
    return workDate.year * 10000 + workDate.month * 100 + workDate.day;
  }

  Attendance _toModel(AttendanceEntity entity) => Attendance(
    workDate: entity.workDate,
    dayKey: entity.dayKey,
    checkIn: entity.checkIn,
    checkOut: entity.checkOut,
    expectedStartMinute: entity.expectedStartMinute,
    expectedEndMinute: entity.expectedEndMinute,
    lunchMinutes: entity.lunchMinutes,
    workedMinutes: entity.workedMinutes,
    lateMinutes: entity.lateMinutes,
    overtimeMinutes: entity.overtimeMinutes,
    earlyLeaveMinutes: entity.earlyLeaveMinutes,
    status: entity.status,
    note: entity.note,
    isEdited: entity.isEdited,
    editedAt: entity.editedAt,
  );

  @override
  void clearTodayAttendance() {
    final dayKey = _todayDayKey();
    _dao.deleteByDayKey(dayKey);
  }

  @override
  Stream<Attendance?> watchAttendanceChanges() {
    return _attendanceChangesController.stream;
  }
}
