import 'package:injectable/injectable.dart';

import '../../../database/attendance/attendance_entity.dart';
import '../../schedule/domain/work_schedule_repository.dart';
import '../data/attendance_dao.dart';
import 'attendance_repository.dart';
import 'models/attendance.dart';

@LazySingleton(as: AttendanceRepository)
class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceDao _dao;
  final WorkScheduleRepository _workScheduleRepository;

  AttendanceRepositoryImpl(this._dao, this._workScheduleRepository);

  @override
  Future<Attendance?> getTodayAttendance() async {
    final entity = _dao.getByDayKey(_todayDayKey());
    return entity == null ? null : _toModel(entity);
  }

  @override
  Future<Attendance> checkIn(DateTime time) async {
    final dayKey = _todayDayKey();
    final existing = _dao.getByDayKey(dayKey);

    if (existing == null) {
      final schedule = await _workScheduleRepository.getCurrentActiveSchedule();
      final entity = AttendanceEntity(
        workDate: _todayWorkDate(),
        dayKey: dayKey,
        checkIn: time,
        expectedStartMinute: schedule?.startMinuteOfDay ?? 0,
        expectedEndMinute: schedule?.endMinuteOfDay ?? 0,
        lunchMinutes: schedule?.lunchMinutes ?? 0,
        workedMinutes: 0,
      );
      _dao.save(entity);
      return _toModel(entity);
    }

    if (existing.checkOut != null && !time.isBefore(existing.checkOut!)) {
      throw StateError('Check-in time must be before check-out time');
    }

    existing.checkIn = time;
    existing.isEdited = true;
    existing.editedAt = DateTime.now();
    _dao.save(existing);
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
    _dao.save(existing);
    return _toModel(existing);
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
        workedMinutes: entity.workedMinutes,
        lateMinutes: entity.lateMinutes,
        overtimeMinutes: entity.overtimeMinutes,
        earlyLeaveMinutes: entity.earlyLeaveMinutes,
        status: entity.status,
        note: entity.note,
        isEdited: entity.isEdited,
        editedAt: entity.editedAt,
      );
}
