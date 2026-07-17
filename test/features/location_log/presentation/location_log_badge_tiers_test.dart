import 'package:flutter_test/flutter_test.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';
import 'package:work_tracker/features/location_log/domain/models/location_log.dart';
import 'package:work_tracker/features/location_log/domain/models/location_log_type.dart';
import 'package:work_tracker/features/location_log/presentation/location_log_badge_tiers.dart';
import 'package:work_tracker/features/location_log/presentation/widgets/location_log_badge.dart';

Attendance _attendance({DateTime? checkIn, DateTime? checkOut}) => Attendance(
  workDate: DateTime(2026, 7, 17),
  dayKey: 20260717,
  checkIn: checkIn,
  checkOut: checkOut,
  expectedStartMinute: 540,
  expectedEndMinute: 1080,
  lunchMinutes: 60,
  expectedLunchStartMinute: 720,
);

LocationLog _log(LocationLogType type, DateTime timestamp) =>
    LocationLog(dayKey: 20260717, type: type, timestamp: timestamp);

void main() {
  group('computeLocationLogBadgeTiers — arrivals', () {
    test(
      'an arrival whose timestamp matches attendance.checkIn is tiered '
      'assigned',
      () {
        final at = DateTime(2026, 7, 17, 9);
        final log = _log(LocationLogType.arrival, at);

        final result = computeLocationLogBadgeTiers(
          events: [log],
          attendance: _attendance(checkIn: at),
        );

        expect(result.badges[log], LocationLogBadgeTier.assigned);
      },
    );

    test(
      'an arrival whose timestamp does NOT match an already-set '
      'attendance.checkIn is tiered notUsed',
      () {
        final log = _log(
          LocationLogType.arrival,
          DateTime(2026, 7, 17, 9, 5),
        );
        // checkIn was set from elsewhere (e.g. manual check-in), at a
        // different time than this log entry.
        final attendance = _attendance(checkIn: DateTime(2026, 7, 17, 8, 55));

        final result = computeLocationLogBadgeTiers(
          events: [log],
          attendance: attendance,
        );

        expect(result.badges[log], LocationLogBadgeTier.notUsed);
      },
    );

    test(
      'an arrival is tiered none when attendance has no check-in at all',
      () {
        final log = _log(LocationLogType.arrival, DateTime(2026, 7, 17, 9));

        final result = computeLocationLogBadgeTiers(
          events: [log],
          attendance: _attendance(),
        );

        expect(result.badges[log], LocationLogBadgeTier.none);
      },
    );

    test('an arrival is tiered none when attendance is null', () {
      final log = _log(LocationLogType.arrival, DateTime(2026, 7, 17, 9));

      final result = computeLocationLogBadgeTiers(
        events: [log],
        attendance: null,
      );

      expect(result.badges[log], LocationLogBadgeTier.none);
    });

    test(
      'only the chronologically first arrival of the day is ever eligible '
      'for assigned/notUsed — later arrivals are always none, even if one '
      'happens to match checkIn',
      () {
        final earlier = _log(
          LocationLogType.arrival,
          DateTime(2026, 7, 17, 8, 50),
        );
        final later = _log(
          LocationLogType.arrival,
          DateTime(2026, 7, 17, 9, 10),
        );
        // checkIn matches the SECOND (later) log, not the first — this
        // must not matter, since only the first chronological arrival is
        // ever considered.
        final attendance = _attendance(checkIn: later.timestamp);

        final result = computeLocationLogBadgeTiers(
          events: [earlier, later],
          attendance: attendance,
        );

        expect(result.badges[earlier], LocationLogBadgeTier.notUsed);
        expect(result.badges[later], LocationLogBadgeTier.none);
      },
    );
  });

  group('computeLocationLogBadgeTiers — departures', () {
    test(
      'a departure whose timestamp matches attendance.checkOut is tiered '
      'assigned',
      () {
        final at = DateTime(2026, 7, 17, 18);
        final log = _log(LocationLogType.departure, at);

        final result = computeLocationLogBadgeTiers(
          events: [log],
          attendance: _attendance(checkOut: at),
        );

        expect(result.badges[log], LocationLogBadgeTier.assigned);
      },
    );

    test(
      'a departure whose timestamp does NOT match an already-set '
      'attendance.checkOut is tiered notUsed',
      () {
        final log = _log(
          LocationLogType.departure,
          DateTime(2026, 7, 17, 18, 5),
        );
        final attendance = _attendance(
          checkOut: DateTime(2026, 7, 17, 17, 55),
        );

        final result = computeLocationLogBadgeTiers(
          events: [log],
          attendance: attendance,
        );

        expect(result.badges[log], LocationLogBadgeTier.notUsed);
      },
    );

    test(
      'a departure is tiered none when attendance has no check-out at all',
      () {
        final log = _log(LocationLogType.departure, DateTime(2026, 7, 17, 18));

        final result = computeLocationLogBadgeTiers(
          events: [log],
          attendance: _attendance(),
        );

        expect(result.badges[log], LocationLogBadgeTier.none);
      },
    );

    test(
      'only the chronologically first departure of the day is ever '
      'eligible for assigned/notUsed',
      () {
        final earlier = _log(
          LocationLogType.departure,
          DateTime(2026, 7, 17, 18),
        );
        final later = _log(
          LocationLogType.departure,
          DateTime(2026, 7, 17, 19),
        );
        final attendance = _attendance(checkOut: later.timestamp);

        final result = computeLocationLogBadgeTiers(
          events: [earlier, later],
          attendance: attendance,
        );

        expect(result.badges[earlier], LocationLogBadgeTier.notUsed);
        expect(result.badges[later], LocationLogBadgeTier.none);
      },
    );
  });

  group('computeLocationLogBadgeTiers — arrivals and departures are tracked '
      'independently', () {
    test(
      'a matching arrival and a matching departure on the same day are '
      'both assigned',
      () {
        final arrivalAt = DateTime(2026, 7, 17, 9);
        final departureAt = DateTime(2026, 7, 17, 18);
        final arrival = _log(LocationLogType.arrival, arrivalAt);
        final departure = _log(LocationLogType.departure, departureAt);

        final result = computeLocationLogBadgeTiers(
          events: [arrival, departure],
          attendance: _attendance(checkIn: arrivalAt, checkOut: departureAt),
        );

        expect(result.badges[arrival], LocationLogBadgeTier.assigned);
        expect(result.badges[departure], LocationLogBadgeTier.assigned);
      },
    );
  });

  group('computeLocationLogBadgeTiers — sorting', () {
    test(
      'sorted is chronologically ordered regardless of input order, and '
      'badge computation follows the sorted (not input) order',
      () {
        final first = _log(LocationLogType.arrival, DateTime(2026, 7, 17, 8));
        final second = _log(
          LocationLogType.arrival,
          DateTime(2026, 7, 17, 8, 30),
        );
        final third = _log(
          LocationLogType.departure,
          DateTime(2026, 7, 17, 18),
        );

        // Deliberately out of chronological order.
        final result = computeLocationLogBadgeTiers(
          events: [third, second, first],
          attendance: _attendance(checkIn: first.timestamp),
        );

        expect(result.sorted, [first, second, third]);
        // The earliest arrival (by timestamp, not input position) is the
        // one matched against checkIn.
        expect(result.badges[first], LocationLogBadgeTier.assigned);
        expect(result.badges[second], LocationLogBadgeTier.none);
      },
    );
  });
}
