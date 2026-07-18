import 'package:flutter_test/flutter_test.dart';
import 'package:work_tracker/features/task/domain/daily_report.dart';
import 'package:work_tracker/features/task/domain/models/task.dart';
import 'package:work_tracker/features/task/domain/models/task_source.dart';
import 'package:work_tracker/features/task/domain/models/task_time_session.dart';

Task _task({
  required int id,
  required String title,
  String? externalId,
}) => Task(
  id: id,
  title: title,
  done: false,
  createdAt: DateTime(2026, 1, 1),
  elapsedSeconds: 0,
  source: externalId == null ? TaskSource.manual : TaskSource.zentao,
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
        TaskTimeSession(
          id: 1,
          taskId: 1,
          start: DateTime(2026, 7, 18, 9, 5),
          end: DateTime(2026, 7, 18, 10, 20),
        ),
        TaskTimeSession(
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
          TaskTimeSession(
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
}
