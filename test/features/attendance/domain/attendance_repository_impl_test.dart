import 'package:flutter_test/flutter_test.dart';
import 'package:work_tracker/database/attendance/attendance_entity.dart';
import 'package:work_tracker/database/work_schedule/work_schedule_entity.dart';
import 'package:work_tracker/features/attendance/data/attendance_dao.dart';
import 'package:work_tracker/features/attendance/domain/attendance_repository_impl.dart';
import 'package:work_tracker/features/schedule/data/work_schedule_dao.dart';

/// Minimal hand-written fakes. No mocktail/bloc_test dependency is present
/// in pubspec.yaml yet, and these DAO interfaces (a handful of synchronous
/// methods each) are small enough that in-memory fakes are straightforward
/// and don't warrant adding a new dependency.
class FakeAttendanceDao implements AttendanceDao {
  final Map<int, AttendanceEntity> _byDayKey = {};

  @override
  AttendanceEntity? getByDayKey(int dayKey) => _byDayKey[dayKey];

  @override
  void save(AttendanceEntity entity) {
    entity.id = _byDayKey[entity.dayKey]?.id ?? _byDayKey.length + 1;
    _byDayKey[entity.dayKey] = entity;
  }

  @override
  void deleteByDayKey(int dayKey) {
    _byDayKey.remove(dayKey);
  }

  @override
  List<AttendanceEntity> getRecent({required int limit}) {
    final all = _byDayKey.values.toList()
      ..sort((a, b) => b.workDate.compareTo(a.workDate));
    return all.take(limit).toList();
  }

  @override
  List<AttendanceEntity> getByDayKeyRange({
    required int startDayKey,
    required int endDayKey,
  }) {
    return _byDayKey.values
        .where((e) => e.dayKey >= startDayKey && e.dayKey <= endDayKey)
        .toList();
  }
}

class FakeWorkScheduleDao implements WorkScheduleDao {
  FakeWorkScheduleDao({this.schedule});

  WorkScheduleEntity? schedule;

  @override
  void save(WorkScheduleEntity entity) {
    schedule = entity;
  }

  @override
  WorkScheduleEntity? get() => schedule;

  @override
  void delete() {
    schedule = null;
  }
}

void main() {
  // 9:00-18:00, 60 min lunch starting at 12:00.
  WorkScheduleEntity buildSchedule({
    int startMinute = 540,
    int endMinute = 1080,
    int lunchMinutes = 60,
    int lunchStartMinute = 720,
  }) => WorkScheduleEntity(
    startMinute: startMinute,
    endMinute: endMinute,
    lunchMinutes: lunchMinutes,
    lunchStartMinute: lunchStartMinute,
    reminderMinutes: 0,
    workingDaysMask: 0x1F,
  );

  group('checkIn (no existing record)', () {
    test('on-time arrival: lateMinutes is 0 and schedule fields are copied', () async {
      final attendanceDao = FakeAttendanceDao();
      final scheduleDao = FakeWorkScheduleDao(schedule: buildSchedule());
      final repo = AttendanceRepositoryImpl(attendanceDao, scheduleDao);

      final checkInTime = DateTime(2026, 7, 17, 9, 0);
      final result = await repo.checkIn(checkInTime);

      expect(result.lateMinutes, 0);
      expect(result.expectedStartMinute, 540);
      expect(result.expectedEndMinute, 1080);
      expect(result.lunchMinutes, 60);
      expect(result.expectedLunchStartMinute, 720);
      expect(result.checkIn, checkInTime);
      expect(result.checkOut, isNull);
      expect(result.workedMinutes, 0);
    });

    test('late arrival: lateMinutes reflects minutes past expectedStartMinute', () async {
      final attendanceDao = FakeAttendanceDao();
      final scheduleDao = FakeWorkScheduleDao(schedule: buildSchedule());
      final repo = AttendanceRepositoryImpl(attendanceDao, scheduleDao);

      final checkInTime = DateTime(2026, 7, 17, 9, 15);
      final result = await repo.checkIn(checkInTime);

      expect(result.lateMinutes, 15);
    });

    test('no schedule configured: expected*/lunch fields default to 0', () async {
      final attendanceDao = FakeAttendanceDao();
      final scheduleDao = FakeWorkScheduleDao(schedule: null);
      final repo = AttendanceRepositoryImpl(attendanceDao, scheduleDao);

      final checkInTime = DateTime(2026, 7, 17, 9, 15);
      final result = await repo.checkIn(checkInTime);

      expect(result.expectedStartMinute, 0);
      expect(result.expectedEndMinute, 0);
      expect(result.lunchMinutes, 0);
      expect(result.expectedLunchStartMinute, 0);
      // With expectedStartMinute defaulting to 0, any check-in time is "late".
      expect(result.lateMinutes, 9 * 60 + 15);
    });
  });

  group('checkOut', () {
    test('throws StateError if there is no existing check-in for the day', () async {
      final attendanceDao = FakeAttendanceDao();
      final scheduleDao = FakeWorkScheduleDao(schedule: buildSchedule());
      final repo = AttendanceRepositoryImpl(attendanceDao, scheduleDao);

      expect(
        () => repo.checkOut(DateTime(2026, 7, 17, 18, 0)),
        throwsA(isA<StateError>()),
      );
    });

    test('throws StateError if check-out time is not after check-in time', () async {
      final attendanceDao = FakeAttendanceDao();
      final scheduleDao = FakeWorkScheduleDao(schedule: buildSchedule());
      final repo = AttendanceRepositoryImpl(attendanceDao, scheduleDao);

      final checkInTime = DateTime(2026, 7, 17, 9, 0);
      await repo.checkIn(checkInTime);

      // Equal to check-in time.
      expect(
        () => repo.checkOut(checkInTime),
        throwsA(isA<StateError>()),
      );
      // Before check-in time.
      expect(
        () => repo.checkOut(checkInTime.subtract(const Duration(minutes: 1))),
        throwsA(isA<StateError>()),
      );
    });

    test('on-time arrival, on-time departure: no overtime/earlyLeave', () async {
      final attendanceDao = FakeAttendanceDao();
      final scheduleDao = FakeWorkScheduleDao(schedule: buildSchedule());
      final repo = AttendanceRepositoryImpl(attendanceDao, scheduleDao);

      await repo.checkIn(DateTime(2026, 7, 17, 9, 0));
      final result = await repo.checkOut(DateTime(2026, 7, 17, 18, 0));

      // 9h - 60min lunch = 480.
      expect(result.workedMinutes, 480);
      expect(result.overtimeMinutes, 0);
      expect(result.earlyLeaveMinutes, 0);
    });

    test(
      'overtime/earlyLeave are measured against the shifted expected end '
      '(expectedEndMinute + lateMinutes), not the raw schedule end',
      () async {
        final attendanceDao = FakeAttendanceDao();
        final scheduleDao = FakeWorkScheduleDao(schedule: buildSchedule());
        final repo = AttendanceRepositoryImpl(attendanceDao, scheduleDao);

        // Late by 15 minutes -> shifted expected end = 1080 + 15 = 1095 (18:15).
        await repo.checkIn(DateTime(2026, 7, 17, 9, 15));

        // Check out at 18:20 (1100) -> 5 minutes of overtime relative to the
        // shifted end, even though it's 20 minutes past the raw schedule end.
        final overtimeResult = await repo.checkOut(DateTime(2026, 7, 17, 18, 20));
        expect(overtimeResult.overtimeMinutes, 5);
        expect(overtimeResult.earlyLeaveMinutes, 0);
        // worked = (18:20 - 9:15) = 545 - 60 lunch = 485.
        expect(overtimeResult.workedMinutes, 485);
      },
    );

    test(
      'a late arrival that shifts the expected end forward turns a '
      'raw-schedule "on time" departure into an early leave',
      () async {
        final attendanceDao = FakeAttendanceDao();
        final scheduleDao = FakeWorkScheduleDao(schedule: buildSchedule());
        final repo = AttendanceRepositoryImpl(attendanceDao, scheduleDao);

        // Late by 15 minutes -> shifted expected end = 1095 (18:15).
        await repo.checkIn(DateTime(2026, 7, 17, 9, 15));

        // Check out exactly at the raw schedule end (18:00 / 1080), which is
        // now 15 minutes before the shifted expected end.
        final result = await repo.checkOut(DateTime(2026, 7, 17, 18, 0));

        expect(result.overtimeMinutes, 0);
        expect(result.earlyLeaveMinutes, 15);
      },
    );

    test('workedMinutes is floored at 0 when lunch exceeds worked span', () async {
      final attendanceDao = FakeAttendanceDao();
      final scheduleDao = FakeWorkScheduleDao(
        schedule: buildSchedule(lunchMinutes: 120),
      );
      final repo = AttendanceRepositoryImpl(attendanceDao, scheduleDao);

      await repo.checkIn(DateTime(2026, 7, 17, 9, 0));
      // Only 30 minutes between check-in/out, but lunch alone is 120.
      final result = await repo.checkOut(DateTime(2026, 7, 17, 9, 30));

      expect(result.workedMinutes, 0);
    });
  });

  group('editing check-in after check-out is already set', () {
    test(
      '_recalculateDerivedFields keeps workedMinutes/overtimeMinutes/'
      'earlyLeaveMinutes in sync with the corrected check-in',
      () async {
        final attendanceDao = FakeAttendanceDao();
        final scheduleDao = FakeWorkScheduleDao(schedule: buildSchedule());
        final repo = AttendanceRepositoryImpl(attendanceDao, scheduleDao);

        await repo.checkIn(DateTime(2026, 7, 17, 9, 0));
        final firstCheckOut = await repo.checkOut(DateTime(2026, 7, 17, 18, 0));
        expect(firstCheckOut.workedMinutes, 480);
        expect(firstCheckOut.overtimeMinutes, 0);
        expect(firstCheckOut.earlyLeaveMinutes, 0);

        // Correct the check-in to 30 minutes later, *after* check-out is
        // already set. lateMinutes goes 0 -> 30, so the shifted expected end
        // becomes 1080 + 30 = 1110 (18:30), 30 minutes after the (unchanged)
        // 18:00 check-out.
        final edited = await repo.checkIn(DateTime(2026, 7, 17, 9, 30));

        expect(edited.lateMinutes, 30);
        expect(edited.checkOut, DateTime(2026, 7, 17, 18, 0));
        // worked = (18:00 - 9:30) = 510 - 60 lunch = 450.
        expect(edited.workedMinutes, 450);
        expect(edited.overtimeMinutes, 0);
        expect(edited.earlyLeaveMinutes, 30);
      },
    );
  });

  group('checkIn re-check-in validation', () {
    test(
      'throws StateError when the new check-in time is not before the '
      'already-set check-out',
      () async {
        final attendanceDao = FakeAttendanceDao();
        final scheduleDao = FakeWorkScheduleDao(schedule: buildSchedule());
        final repo = AttendanceRepositoryImpl(attendanceDao, scheduleDao);

        await repo.checkIn(DateTime(2026, 7, 17, 9, 0));
        final checkOutTime = DateTime(2026, 7, 17, 18, 0);
        await repo.checkOut(checkOutTime);

        // Equal to check-out time.
        expect(
          () => repo.checkIn(checkOutTime),
          throwsA(isA<StateError>()),
        );
        // After check-out time.
        expect(
          () => repo.checkIn(checkOutTime.add(const Duration(minutes: 1))),
          throwsA(isA<StateError>()),
        );
      },
    );
  });

  group('isEdited/editedAt on checkOut', () {
    test(
      'first-time check-out does not set isEdited/editedAt, but re-setting '
      'an already-completed check-out does',
      () async {
        final attendanceDao = FakeAttendanceDao();
        final scheduleDao = FakeWorkScheduleDao(schedule: buildSchedule());
        final repo = AttendanceRepositoryImpl(attendanceDao, scheduleDao);

        await repo.checkIn(DateTime(2026, 7, 17, 9, 0));
        final firstCheckOut = await repo.checkOut(DateTime(2026, 7, 17, 18, 0));

        expect(firstCheckOut.isEdited, isFalse);
        expect(firstCheckOut.editedAt, isNull);

        final editedCheckOut = await repo.checkOut(DateTime(2026, 7, 17, 18, 30));

        expect(editedCheckOut.isEdited, isTrue);
        expect(editedCheckOut.editedAt, isNotNull);
      },
    );
  });

  group('getAttendanceForMonth', () {
    test('returns only entities within the requested year/month day-key range', () async {
      final attendanceDao = FakeAttendanceDao();
      final scheduleDao = FakeWorkScheduleDao(schedule: buildSchedule());
      final repo = AttendanceRepositoryImpl(attendanceDao, scheduleDao);

      // Jan 1 and Jan 31, 2026 -> in range. Dec 31, 2025 and Feb 1, 2026 ->
      // out of range.
      await repo.checkIn(DateTime(2026, 1, 1, 9, 0));
      await repo.checkIn(DateTime(2026, 1, 31, 9, 0));
      await repo.checkIn(DateTime(2025, 12, 31, 9, 0));
      await repo.checkIn(DateTime(2026, 2, 1, 9, 0));

      final result = await repo.getAttendanceForMonth(year: 2026, month: 1);

      expect(result.keys.toSet(), {20260101, 20260131});
      expect(result[20260101]!.checkIn, DateTime(2026, 1, 1, 9, 0));
      expect(result[20260131]!.checkIn, DateTime(2026, 1, 31, 9, 0));
    });

    test('handles a month with fewer days (February, non-leap year)', () async {
      final attendanceDao = FakeAttendanceDao();
      final scheduleDao = FakeWorkScheduleDao(schedule: buildSchedule());
      final repo = AttendanceRepositoryImpl(attendanceDao, scheduleDao);

      // 2026 is not a leap year, so February has 28 days.
      await repo.checkIn(DateTime(2026, 2, 28, 9, 0));
      // March 1st must NOT leak into February's range.
      await repo.checkIn(DateTime(2026, 3, 1, 9, 0));

      final result = await repo.getAttendanceForMonth(year: 2026, month: 2);

      expect(result.keys.toSet(), {20260228});
    });
  });

  group('watchAttendanceChanges (broadcast discipline)', () {
    test('getTodayAttendance is a pure read: it does NOT broadcast', () async {
      // Regression guard for the emit-on-read feedback loop that caused an
      // unbounded main-thread OOM: a listener (TodayActivityTimelineCubit)
      // read in response to an event, which re-emitted, ad infinitum.
      final attendanceDao = FakeAttendanceDao();
      final scheduleDao = FakeWorkScheduleDao(schedule: buildSchedule());
      final repo = AttendanceRepositoryImpl(attendanceDao, scheduleDao);

      final now = DateTime.now();
      await repo.checkIn(DateTime(now.year, now.month, now.day, 9, 0));

      final emissions = <Object?>[];
      final subscription = repo.watchAttendanceChanges().listen(emissions.add);

      await repo.getTodayAttendance();
      await repo.getTodayAttendance();
      await repo.getTodayAttendance();
      await Future<void>.delayed(Duration.zero);

      expect(emissions, isEmpty);
      await subscription.cancel();
    });

    test('mutations each emit exactly one event', () async {
      final attendanceDao = FakeAttendanceDao();
      final scheduleDao = FakeWorkScheduleDao(schedule: buildSchedule());
      final repo = AttendanceRepositoryImpl(attendanceDao, scheduleDao);

      final now = DateTime.now();
      final emissions = <Object?>[];
      final subscription = repo.watchAttendanceChanges().listen(emissions.add);

      await repo.checkIn(DateTime(now.year, now.month, now.day, 9, 0));
      await repo.checkOut(DateTime(now.year, now.month, now.day, 18, 0));
      repo.clearTodayAttendance();
      await Future<void>.delayed(Duration.zero);

      // checkIn, checkOut, clear -> 3 events, last is null (cleared).
      expect(emissions.length, 3);
      expect(emissions.last, isNull);
      await subscription.cancel();
    });
  });

  group('clearTodayAttendance', () {
    test('deletes today\'s record and emits null via watchAttendanceChanges', () async {
      final attendanceDao = FakeAttendanceDao();
      final scheduleDao = FakeWorkScheduleDao(schedule: buildSchedule());
      final repo = AttendanceRepositoryImpl(attendanceDao, scheduleDao);

      final now = DateTime.now();
      final todayCheckIn = DateTime(now.year, now.month, now.day, 9, 0);
      await repo.checkIn(todayCheckIn);

      final emissions = <Object?>[];
      final subscription = repo.watchAttendanceChanges().listen(emissions.add);

      repo.clearTodayAttendance();
      // Let the stream deliver the event.
      await Future<void>.delayed(Duration.zero);

      expect(emissions, [isNull]);
      expect(await repo.getTodayAttendance(), isNull);

      await subscription.cancel();
    });
  });
}
