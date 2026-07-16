import 'package:flutter_test/flutter_test.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';
import 'package:work_tracker/features/calendar/domain/models/month_summary.dart';

/// Builds an [Attendance] with only the fields relevant to
/// [deriveMonthSummary] varying; the rest are fixed, unused placeholders.
Attendance _attendance({int lateMinutes = 0, int overtimeMinutes = 0}) {
  return Attendance(
    workDate: DateTime(2026, 7, 1),
    dayKey: 20260701,
    expectedStartMinute: 540,
    expectedEndMinute: 1080,
    lunchMinutes: 60,
    expectedLunchStartMinute: 720,
    lateMinutes: lateMinutes,
    overtimeMinutes: overtimeMinutes,
  );
}

void main() {
  group('deriveMonthSummary', () {
    test('empty input returns an all-zero MonthSummary', () {
      final summary = deriveMonthSummary(const <Attendance>[]);

      expect(summary, const MonthSummary());
      expect(summary.totalLateMinutes, 0);
      expect(summary.lateDayCount, 0);
      expect(summary.totalOvertimeMinutes, 0);
    });

    test('sums lateMinutes and overtimeMinutes across multiple attendances', () {
      final attendances = [
        _attendance(lateMinutes: 10, overtimeMinutes: 30),
        _attendance(lateMinutes: 5, overtimeMinutes: 0),
        _attendance(lateMinutes: 0, overtimeMinutes: 45),
      ];

      final summary = deriveMonthSummary(attendances);

      expect(summary.totalLateMinutes, 15);
      expect(summary.totalOvertimeMinutes, 75);
    });

    test('counts only attendances with lateMinutes > 0 toward lateDayCount', () {
      final attendances = [
        _attendance(lateMinutes: 10),
        _attendance(lateMinutes: 0),
        _attendance(lateMinutes: 1),
        _attendance(lateMinutes: 0),
      ];

      final summary = deriveMonthSummary(attendances);

      expect(summary.lateDayCount, 2);
    });

    test(
      'an attendance with lateMinutes: 0 does not affect totals or lateDayCount',
      () {
        final summary = deriveMonthSummary([
          _attendance(lateMinutes: 0, overtimeMinutes: 0),
        ]);

        expect(summary, const MonthSummary());
      },
    );
  });
}
