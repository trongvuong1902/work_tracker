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
    final dayKey = _dayKeyOf(time);
    final existing = _dao.getByDayKey(dayKey);

    if (existing == null) {
      final schedule = _workdScheduleDao.get();
      final expectedStartMinute = schedule?.startMinute ?? 0;
      final entity = AttendanceEntity(
        workDate: _workDateOf(time),
        dayKey: dayKey,
        checkIn: time,
        checkOut: null,
        expectedStartMinute: expectedStartMinute,
        expectedEndMinute: schedule?.endMinute ?? 0,
        lunchMinutes: schedule?.lunchMinutes ?? 0,
        expectedLunchStartMinute: schedule?.lunchStartMinute ?? 0,
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
    _recalculateDerivedFields(existing);
    _dao.save(existing);
    _attendanceChangesController.add(_toModel(existing));
    return _toModel(existing);
  }

  @override
  Future<Attendance> checkOut(DateTime time) async {
    final existing = _dao.getByDayKey(_dayKeyOf(time));

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

    _recalculateDerivedFields(existing);

    _dao.save(existing);
    _attendanceChangesController.add(_toModel(existing));
    return _toModel(existing);
  }

  /// Recomputes [AttendanceEntity.workedMinutes],
  /// [AttendanceEntity.overtimeMinutes] and [AttendanceEntity.earlyLeaveMinutes]
  /// from [entity]'s current `checkIn`/`checkOut`/`lunchMinutes`/
  /// `expectedEndMinute`/`lateMinutes`. No-op if there's no check-out yet,
  /// since there's nothing to derive. Must be called after any change to
  /// `checkIn`, `checkOut` or `lateMinutes` so these derived fields never go
  /// stale (e.g. editing check-in after check-out is already set).
  void _recalculateDerivedFields(AttendanceEntity entity) {
    if (entity.checkOut == null) return;

    final workedMinutes =
        entity.checkOut!.difference(entity.checkIn!).inMinutes -
        entity.lunchMinutes;
    entity.workedMinutes = workedMinutes > 0 ? workedMinutes : 0;

    final checkOutMinute = _minuteOfDay(entity.checkOut!);
    // A late check-in pushes the expected leave time back by the same
    // amount, so overtime/early-leave are measured against that shifted
    // expected end time rather than the originally scheduled one.
    final shiftedExpectedEndMinute =
        entity.expectedEndMinute + entity.lateMinutes;
    entity.overtimeMinutes = checkOutMinute > shiftedExpectedEndMinute
        ? checkOutMinute - shiftedExpectedEndMinute
        : 0;
    entity.earlyLeaveMinutes = checkOutMinute < shiftedExpectedEndMinute
        ? shiftedExpectedEndMinute - checkOutMinute
        : 0;
  }

  int _lateMinutes(DateTime checkInTime, int expectedStartMinute) {
    final checkInMinute = _minuteOfDay(checkInTime);
    return checkInMinute > expectedStartMinute
        ? checkInMinute - expectedStartMinute
        : 0;
  }

  int _minuteOfDay(DateTime dateTime) => dateTime.hour * 60 + dateTime.minute;

  /// The date component of [time], with the time-of-day stripped off. Used
  /// to determine which day's record a [checkIn]/[checkOut] call affects —
  /// derived from the given [time], never from the clock.
  DateTime _workDateOf(DateTime time) =>
      DateTime(time.year, time.month, time.day);

  /// The `yyyyMMdd`-style day key for [time]'s date component. Used to
  /// determine which day's record a [checkIn]/[checkOut] call affects —
  /// derived from the given [time], never from the clock.
  int _dayKeyOf(DateTime time) {
    final workDate = _workDateOf(time);
    return workDate.year * 10000 + workDate.month * 100 + workDate.day;
  }

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
    expectedLunchStartMinute: entity.expectedLunchStartMinute,
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
  Future<List<Attendance>> getRecentAttendances({int limit = 10}) async {
    return _dao.getRecent(limit: limit).map(_toModel).toList();
  }

  @override
  Future<Map<int, Attendance>> getAttendanceForMonth({
    required int year,
    required int month,
  }) async {
    final startDayKey = year * 10000 + month * 100 + 1;
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final endDayKey = year * 10000 + month * 100 + daysInMonth;
    final entities = _dao.getByDayKeyRange(
      startDayKey: startDayKey,
      endDayKey: endDayKey,
    );
    return {for (final entity in entities) entity.dayKey: _toModel(entity)};
  }

  @override
  void clearTodayAttendance() {
    final dayKey = _todayDayKey();
    _dao.deleteByDayKey(dayKey);
    _attendanceChangesController.add(null);
  }

  @override
  Stream<Attendance?> watchAttendanceChanges() {
    return _attendanceChangesController.stream;
  }
}
