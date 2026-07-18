import '../../../core/time/time_format.dart';
import 'models/task.dart';
import 'models/task_time_session.dart';

/// One task's line in a daily report: its identity, total time worked that day,
/// and the individual sessions (real start/end) that make it up.
class DailyReportEntry {
  const DailyReportEntry({
    required this.taskId,
    required this.externalId,
    required this.title,
    required this.totalSeconds,
    required this.sessions,
  });

  final int taskId;
  final String? externalId;
  final String title;
  final int totalSeconds;
  final List<TaskTimeSession> sessions;
}

/// A day's worth of work across tasks, plus the grand total.
class DailyReport {
  const DailyReport({
    required this.day,
    required this.entries,
    required this.totalSeconds,
  });

  final DateTime day;
  final List<DailyReportEntry> entries;
  final int totalSeconds;

  bool get isEmpty => entries.isEmpty;
}

/// Builds the report for [day] from the tasks worked that day. [sessions] carry
/// the real clock start/end; [secondsByTask] is the authoritative per-task total
/// for the day (covers manual time edits that have no sessions). A task is
/// included if it has sessions or logged seconds that day; unknown tasks (not in
/// [tasks]) are skipped. Entries are sorted by total time desc.
DailyReport buildDailyReport({
  required DateTime day,
  required List<Task> tasks,
  required List<TaskTimeSession> sessions,
  required Map<int, int> secondsByTask,
}) {
  final tasksById = {for (final t in tasks) t.id: t};

  final sessionsByTask = <int, List<TaskTimeSession>>{};
  for (final session in sessions) {
    sessionsByTask.putIfAbsent(session.taskId, () => []).add(session);
  }

  final taskIds = <int>{...secondsByTask.keys, ...sessionsByTask.keys};

  final entries = <DailyReportEntry>[];
  for (final taskId in taskIds) {
    final task = tasksById[taskId];
    if (task == null) continue; // deleted task — nothing to name it with.

    final taskSessions = (sessionsByTask[taskId] ?? [])
      ..sort((a, b) => a.start.compareTo(b.start));
    final total = secondsByTask[taskId] ??
        taskSessions.fold<int>(0, (sum, s) => sum + s.durationSeconds);
    if (total <= 0 && taskSessions.isEmpty) continue;

    entries.add(
      DailyReportEntry(
        taskId: taskId,
        externalId: task.externalId,
        title: task.title,
        totalSeconds: total,
        sessions: taskSessions,
      ),
    );
  }

  entries.sort((a, b) => b.totalSeconds.compareTo(a.totalSeconds));
  final grandTotal = entries.fold<int>(0, (sum, e) => sum + e.totalSeconds);

  return DailyReport(day: day, entries: entries, totalSeconds: grandTotal);
}

/// Renders [report] as the copy-ready text body — one item per line, e.g.:
///
///     [2026-07-18] Daily report
///     #123 Crash on save · 09:05–10:20 · 1h 15m
///     #123 Crash on save · 14:00–15:00 · 1h 00m
///     #456 Fix login · 11:00–11:30 · 0h 30m
///     Total: 2h 45m
///
/// A task with logged time but no recorded sessions gets a single line with
/// just its total duration.
String renderDailyReportText(DailyReport report) {
  final buffer = StringBuffer();
  buffer.writeln(dailyReportTitle(report.day));

  if (report.isEmpty) {
    buffer.writeln('No time tracked.');
    return buffer.toString().trimRight();
  }

  for (final entry in report.entries) {
    final idPart = entry.externalId != null ? '#${entry.externalId} ' : '';
    final label = '$idPart${entry.title}';
    if (entry.sessions.isEmpty) {
      buffer.writeln('$label · ${TimeFormat.hMm(entry.totalSeconds ~/ 60)}');
    } else {
      for (final session in entry.sessions) {
        buffer.writeln(
          '$label · ${TimeFormat.hhMmFromDateTime(session.start)}'
          '–${TimeFormat.hhMmFromDateTime(session.end)}'
          ' · ${TimeFormat.hMm(session.durationSeconds ~/ 60)}',
        );
      }
    }
  }

  buffer.writeln('Total: ${TimeFormat.hMm(report.totalSeconds ~/ 60)}');
  return buffer.toString().trimRight();
}

/// The report title, `[yyyy-mm-dd] Daily report`.
String dailyReportTitle(DateTime day) {
  final y = day.year.toString().padLeft(4, '0');
  final m = day.month.toString().padLeft(2, '0');
  final d = day.day.toString().padLeft(2, '0');
  return '[$y-$m-$d] Daily report';
}
