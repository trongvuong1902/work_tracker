import 'package:flutter_test/flutter_test.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';
import 'package:work_tracker/features/work_item/domain/daily_report.dart';
import 'package:work_tracker/features/work_item/domain/models/work_item.dart';
import 'package:work_tracker/features/work_item/domain/models/work_item_source.dart';
import 'package:work_tracker/features/work_item/domain/models/work_item_time_session.dart';

WorkItem _task({
  required int id,
  required String title,
  String? externalId,
}) => WorkItem(
  id: id,
  title: title,
  done: false,
  createdAt: DateTime(2026, 1, 1),
  elapsedSeconds: 0,
  source: externalId == null ? WorkItemSource.manual : WorkItemSource.zentao,
  externalId: externalId,
);

void main() {
  final day = DateTime(2026, 7, 18);

  group('buildDailyReport', () {
    test('groups sessions per task, sorts by total desc, sums grand total', () {
      final tasks = [
        _task(id: 1, title: 'Crash on save', externalId: '123'),
        _task(id: 2, title: 'Fix login', externalId: '456'),
      ];
      final sessions = [
        WorkItemTimeSession(
          id: 1,
          taskId: 1,
          start: DateTime(2026, 7, 18, 9, 5),
          end: DateTime(2026, 7, 18, 10, 20),
        ),
        WorkItemTimeSession(
          id: 2,
          taskId: 2,
          start: DateTime(2026, 7, 18, 11, 0),
          end: DateTime(2026, 7, 18, 11, 30),
        ),
      ];
      final secondsByTask = {1: 75 * 60, 2: 30 * 60};

      final report = buildDailyReport(
        day: day,
        tasks: tasks,
        sessions: sessions,
        secondsByTask: secondsByTask,
      );

      expect(report.entries, hasLength(2));
      expect(report.entries.first.taskId, 1); // more time → first
      expect(report.entries.first.externalId, '123');
      expect(report.entries.first.sessions, hasLength(1));
      expect(report.totalSeconds, (75 + 30) * 60);
    });

    test('includes a task with logged seconds but no sessions', () {
      final report = buildDailyReport(
        day: day,
        tasks: [_task(id: 1, title: 'Manual work')],
        sessions: const [],
        secondsByTask: {1: 20 * 60},
      );

      expect(report.entries, hasLength(1));
      expect(report.entries.single.sessions, isEmpty);
      expect(report.entries.single.totalSeconds, 20 * 60);
    });

    test('skips time for an unknown (deleted) task', () {
      final report = buildDailyReport(
        day: day,
        tasks: const [],
        sessions: const [],
        secondsByTask: {99: 10 * 60},
      );
      expect(report.entries, isEmpty);
      expect(report.totalSeconds, 0);
    });
  });

  group('renderDailyReportText', () {
    test('renders title, per-task lines, sessions, and total', () {
      final report = buildDailyReport(
        day: day,
        tasks: [_task(id: 1, title: 'Crash on save', externalId: '123')],
        sessions: [
          WorkItemTimeSession(
            id: 1,
            taskId: 1,
            start: DateTime(2026, 7, 18, 9, 5),
            end: DateTime(2026, 7, 18, 10, 20),
          ),
        ],
        secondsByTask: {1: 75 * 60},
      );

      final text = renderDailyReportText(report);

      expect(text, contains('[2026-07-18] Daily report'));
      expect(text, contains('#123 Crash on save · 09:05–10:20 · 1h 15m'));
      expect(text, contains('Total: 1h 15m'));
    });

    test('empty report renders a no-time line', () {
      final report = buildDailyReport(
        day: day,
        tasks: const [],
        sessions: const [],
        secondsByTask: const {},
      );
      expect(renderDailyReportText(report), contains('No time tracked'));
    });
  });

  group('renderDailyReportText — attendance block', () {
    // A single-task report reused across the attendance cases so the "Tasks"
    // section is identical and we can focus on the prepended Attendance block.
    DailyReport oneTaskReport() => buildDailyReport(
      day: DateTime(2026, 7, 19),
      tasks: [_task(id: 1, title: 'Fix crash on save', externalId: '1234')],
      sessions: [
        WorkItemTimeSession(
          id: 1,
          taskId: 1,
          start: DateTime(2026, 7, 19, 9, 20),
          end: DateTime(2026, 7, 19, 10, 35),
        ),
      ],
      secondsByTask: {1: 75 * 60},
    );

    test(
      'with check-in + check-out: renders an Attendance block (check-in + '
      'late label, check-out + overtime label, worked-of-planned) above the '
      'existing Tasks section',
      () {
        // Fully fixed times: lateMinutes/overtimeMinutes/workedMinutes are
        // stored snapshot fields on a completed row, so nothing here depends
        // on the wall clock.
        final attendance = Attendance(
          workDate: DateTime(2026, 7, 19),
          dayKey: 20260719,
          checkIn: DateTime(2026, 7, 19, 9, 12),
          checkOut: DateTime(2026, 7, 19, 18, 5),
          expectedStartMinute: 540, // 09:00
          expectedEndMinute: 1080, // 18:00
          lunchMinutes: 60,
          expectedLunchStartMinute: 720,
          workedMinutes: 485, // 8h 05m
          lateMinutes: 12,
          overtimeMinutes: 35,
        );

        final text = renderDailyReportText(
          oneTaskReport(),
          attendance: attendance,
        );

        expect(text, contains('[2026-07-19] Daily report'));
        // Exact formatting via the TimeFormat helpers the impl uses:
        // hhMmFromDateTime for clock times, hMm for durations.
        expect(text, contains('Attendance'));
        expect(text, contains('Check-in:  09:12 (0h 12m late)'));
        expect(text, contains('Check-out: 18:05 (0h 35m overtime)'));
        // planned = 1080 - 540 - 60 = 480 (8h 00m); worked = 485 (8h 05m).
        expect(text, contains('Worked:    8h 05m of 8h 00m'));

        // Attendance block sits above the Tasks section.
        expect(text, contains('Tasks'));
        expect(text, contains('#1234 Fix crash on save · 09:20–10:35 · 1h 15m'));
        expect(text, contains('Total: 1h 15m'));
        expect(text.indexOf('Attendance'), lessThan(text.indexOf('Tasks')));
        expect(
          text.indexOf('Check-out:'),
          lessThan(text.indexOf('Tasks')),
        );
      },
    );

    test(
      'early-leave check-out gets an "early" label instead of "overtime"',
      () {
        final attendance = Attendance(
          workDate: DateTime(2026, 7, 19),
          dayKey: 20260719,
          checkIn: DateTime(2026, 7, 19, 9, 0),
          checkOut: DateTime(2026, 7, 19, 17, 20),
          expectedStartMinute: 540,
          expectedEndMinute: 1080,
          lunchMinutes: 60,
          expectedLunchStartMinute: 720,
          workedMinutes: 440,
          earlyLeaveMinutes: 40,
        );

        final text = renderDailyReportText(
          oneTaskReport(),
          attendance: attendance,
        );

        expect(text, contains('Check-out: 17:20 (0h 40m early)'));
        expect(text, isNot(contains('overtime')));
      },
    );

    test(
      'State C (checkOut == null, mid-day): check-out line is omitted, but '
      'check-in and worked-so-far still render',
      () {
        // Anchor check-in off "now" (mirroring the checkout_reminder tests)
        // so the live worked-so-far estimate is exercised deterministically
        // for the parts we assert (the row's own check-in time + planned).
        final now = DateTime.now();
        final checkIn = now.subtract(const Duration(minutes: 200));
        final attendance = Attendance(
          workDate: DateTime(now.year, now.month, now.day),
          dayKey: 20260719,
          checkIn: checkIn,
          // checkOut left null: still checked in.
          expectedStartMinute: 540,
          expectedEndMinute: 1080,
          lunchMinutes: 60,
          expectedLunchStartMinute: 720,
          lateMinutes: 0,
        );

        final text = renderDailyReportText(
          oneTaskReport(),
          attendance: attendance,
        );

        expect(text, contains('Attendance'));
        // check-in time is taken straight off the row, so it's exact.
        expect(text, contains('Check-in:  ${_hhMm(checkIn)}'));
        expect(text, isNot(contains('late'))); // lateMinutes == 0
        // No check-out yet: that whole line must be absent.
        expect(text, isNot(contains('Check-out:')));
        // Worked-so-far still renders against the planned 8h 00m.
        expect(text, contains(RegExp(r'Worked:\s+\d+h \d\dm of 8h 00m')));
        expect(text, contains('Tasks'));
      },
    );

    test(
      'with NO attendance (null): output is unchanged from the task-only '
      'format — no Attendance/Tasks headers (regression guard for existing '
      'callers)',
      () {
        final report = oneTaskReport();

        final text = renderDailyReportText(report);

        expect(text, contains('[2026-07-19] Daily report'));
        expect(text, contains('#1234 Fix crash on save · 09:20–10:35 · 1h 15m'));
        expect(text, contains('Total: 1h 15m'));
        // The task-only format has neither the Attendance block nor a "Tasks"
        // header (that header only appears once an attendance block precedes
        // it).
        expect(text, isNot(contains('Attendance')));
        expect(text, isNot(contains('Check-in:')));
        expect(text, isNot(contains('Tasks')));
      },
    );
  });
}

/// Local mirror of `TimeFormat.hhMmFromDateTime`, so the expected check-in
/// label is derived independently of the impl rather than by reusing it.
String _hhMm(DateTime dt) =>
    '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
