import 'package:flutter_test/flutter_test.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';
import 'package:work_tracker/features/home/presentation/widgets/hero_card/hero_card_model.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/geo_point.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/leave_reminder_settings.dart';
import 'package:work_tracker/features/schedule/domain/models/work_schedule.dart';

const _schedule = WorkSchedule(
  startMinuteOfDay: 540, // 09:00
  endMinuteOfDay: 1080, // 18:00
  lunchMinutes: 60,
  lunchStartMinuteOfDay: 720,
  reminderMinutes: 10,
);

const _home = GeoPoint(latitude: 1, longitude: 1);
const _work = GeoPoint(latitude: 2, longitude: 2);

/// Fully set-up settings (enabled + both locations), i.e. everything the
/// resolver needs to fall through to its later branches.
const _readySettings = LeaveReminderSettings(
  enabled: true,
  home: _home,
  work: _work,
);

void main() {
  group('resolveLeaveReminderCtaKind', () {
    test('no active schedule -> noActiveSchedule', () {
      final kind = resolveLeaveReminderCtaKind(
        schedule: null,
        isWorkingDay: true,
        settings: _readySettings,
        averageCommuteMinutes: 30,
      );
      expect(kind, LeaveReminderCtaKind.noActiveSchedule);
    });

    test('reminders disabled -> remindersDisabled', () {
      final kind = resolveLeaveReminderCtaKind(
        schedule: _schedule,
        isWorkingDay: true,
        settings: const LeaveReminderSettings(
          enabled: false,
          home: _home,
          work: _work,
        ),
        averageCommuteMinutes: 30,
      );
      expect(kind, LeaveReminderCtaKind.remindersDisabled);
    });

    test('home unset -> remindersDisabled', () {
      final kind = resolveLeaveReminderCtaKind(
        schedule: _schedule,
        isWorkingDay: true,
        settings: const LeaveReminderSettings(
          enabled: true,
          home: null,
          work: _work,
        ),
        averageCommuteMinutes: 30,
      );
      expect(kind, LeaveReminderCtaKind.remindersDisabled);
    });

    test('work unset -> remindersDisabled', () {
      final kind = resolveLeaveReminderCtaKind(
        schedule: _schedule,
        isWorkingDay: true,
        settings: const LeaveReminderSettings(
          enabled: true,
          home: _home,
          work: null,
        ),
        averageCommuteMinutes: 30,
      );
      expect(kind, LeaveReminderCtaKind.remindersDisabled);
    });

    test('reminders on but no commute average yet -> learningCommute', () {
      final kind = resolveLeaveReminderCtaKind(
        schedule: _schedule,
        isWorkingDay: true,
        settings: _readySettings,
        averageCommuteMinutes: null, // < 2 samples
      );
      expect(kind, LeaveReminderCtaKind.learningCommute);
    });

    test('fully set up but not a working day -> dayOff', () {
      final kind = resolveLeaveReminderCtaKind(
        schedule: _schedule,
        isWorkingDay: false,
        settings: _readySettings,
        averageCommuteMinutes: 30,
      );
      expect(kind, LeaveReminderCtaKind.dayOff);
    });

    test('everything set up on a working day -> null', () {
      final kind = resolveLeaveReminderCtaKind(
        schedule: _schedule,
        isWorkingDay: true,
        settings: _readySettings,
        averageCommuteMinutes: 30,
      );
      expect(kind, isNull);
    });

    group('branch precedence (as implemented)', () {
      test('null schedule wins even when reminders are also disabled', () {
        final kind = resolveLeaveReminderCtaKind(
          schedule: null,
          isWorkingDay: false,
          settings: const LeaveReminderSettings(enabled: false),
          averageCommuteMinutes: null,
        );
        expect(kind, LeaveReminderCtaKind.noActiveSchedule);
      });

      test(
        'remindersDisabled wins over learningCommute and dayOff',
        () {
          final kind = resolveLeaveReminderCtaKind(
            schedule: _schedule,
            isWorkingDay: false,
            settings: const LeaveReminderSettings(enabled: false),
            averageCommuteMinutes: null,
          );
          expect(kind, LeaveReminderCtaKind.remindersDisabled);
        },
      );

      test('learningCommute wins over dayOff', () {
        final kind = resolveLeaveReminderCtaKind(
          schedule: _schedule,
          isWorkingDay: false, // would be dayOff...
          settings: _readySettings,
          averageCommuteMinutes: null, // ...but no average takes precedence
        );
        expect(kind, LeaveReminderCtaKind.learningCommute);
      });
    });
  });

  group('HeroCardModel.fromAttendance', () {
    // Anchor everything off "now" with safe margins so the working vs.
    // approaching-check-out boundary is deterministic regardless of when the
    // suite runs. leaveAt is derived as checkIn + (expectedEnd - expectedStart)
    // minutes, so we pick those to place "now" on the intended side of the
    // (leaveAt - 30m) threshold.
    Attendance building({
      required DateTime? checkIn,
      DateTime? checkOut,
      int expectedStartMinute = 0,
      int expectedEndMinute = 480,
      int expectedLunchStartMinute = 720,
      int lunchMinutes = 60,
    }) {
      final now = DateTime.now();
      return Attendance(
        workDate: DateTime(now.year, now.month, now.day),
        dayKey: 20260719,
        checkIn: checkIn,
        checkOut: checkOut,
        expectedStartMinute: expectedStartMinute,
        expectedEndMinute: expectedEndMinute,
        lunchMinutes: lunchMinutes,
        expectedLunchStartMinute: expectedLunchStartMinute,
      );
    }

    test('check-in null -> beforeCheckIn', () {
      final model = HeroCardModel.fromAttendance(building(checkIn: null));
      final kind = model!.maybeWhen(
        beforeCheckIn: (_, _, _) => 'beforeCheckIn',
        orElse: () => 'other',
      );
      expect(kind, 'beforeCheckIn');
    });

    test(
      'checked in, not out, well before (leaveAt - 30m) -> working',
      () {
        final now = DateTime.now();
        // total = 600 min; leaveAt = now + 600m, threshold = now + 570m.
        // now is comfortably before the threshold.
        final attendance = building(
          checkIn: now,
          expectedStartMinute: 0,
          expectedEndMinute: 600,
        );

        final model = HeroCardModel.fromAttendance(attendance);

        final leaveAt = model!.maybeWhen(
          working: (checkIn, leaveAt, breakStart, breakEnd) => leaveAt,
          orElse: () => null,
        );
        expect(leaveAt, isNotNull, reason: 'expected the working state');
        expect(leaveAt, now.add(const Duration(minutes: 600)));
      },
    );

    test(
      'checked in, not out, within 30m of leaveAt -> approachingCheckOut',
      () {
        final now = DateTime.now();
        const total = 480;
        // Place leaveAt 10 minutes in the future: now + 10 is within the
        // 30-minute approaching window, so threshold (leaveAt - 30m) is
        // already in the past.
        final checkIn = now.add(const Duration(minutes: 10 - total));
        final attendance = building(
          checkIn: checkIn,
          expectedStartMinute: 0,
          expectedEndMinute: total,
        );

        final model = HeroCardModel.fromAttendance(attendance);

        final scheduledEnd = model!.maybeWhen(
          approachingCheckOut: (checkIn, scheduledEnd) => scheduledEnd,
          orElse: () => null,
        );
        expect(
          scheduledEnd,
          isNotNull,
          reason: 'expected the approachingCheckOut state',
        );
        expect(scheduledEnd, checkIn.add(const Duration(minutes: total)));
      },
    );

    test(
      'checked in, not out, past leaveAt -> approachingCheckOut',
      () {
        final now = DateTime.now();
        const total = 480;
        // leaveAt = now - 5m (already past) -> still approachingCheckOut.
        final checkIn = now.add(const Duration(minutes: -5 - total));
        final attendance = building(
          checkIn: checkIn,
          expectedStartMinute: 0,
          expectedEndMinute: total,
        );

        final model = HeroCardModel.fromAttendance(attendance);

        final kind = model!.maybeWhen(
          approachingCheckOut: (_, _) => 'approaching',
          orElse: () => 'other',
        );
        expect(kind, 'approaching');
      },
    );

    test('checked out -> afterCheckOut with checkOutAt set', () {
      final now = DateTime.now();
      final checkOut = DateTime(now.year, now.month, now.day, 18, 5);
      final attendance = building(
        checkIn: DateTime(now.year, now.month, now.day, 9, 0),
        checkOut: checkOut,
      );

      final model = HeroCardModel.fromAttendance(attendance);

      final checkOutAt = model!.maybeWhen(
        afterCheckOut: (checkOutAt) => checkOutAt,
        orElse: () => null,
      );
      expect(checkOutAt, checkOut);
    });

    test('kApproachingCheckOutThresholdMinutes is 30', () {
      expect(kApproachingCheckOutThresholdMinutes, 30);
    });
  });
}
