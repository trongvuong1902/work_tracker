import '../../../core/time/time_format.dart';
import '../../attendance/domain/models/attendance.dart';
import 'models/work_item.dart';
import 'models/work_item_time_session.dart';

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
  final List<WorkItemTimeSession> sessions;
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
  required List<WorkItem> tasks,
  required List<WorkItemTimeSession> sessions,
  required Map<int, int> secondsByTask,
}) {
  final tasksById = {for (final t in tasks) t.id: t};

  final sessionsByTask = <int, List<WorkItemTimeSession>>{};
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
///
/// When [attendance] is given, an Attendance block is prepended above a
/// "Tasks" header, e.g.:
///
///     [2026-07-19] Daily report
///
///     Attendance
///     Check-in:  09:12 (12m late)
///     Check-out: 18:05 (35m overtime)
///     Worked:    8h 05m of 8h 00m
///
///     Tasks
///     #1234 Fix crash on save · 09:20–10:35 · 1h 15m
///     Total: 1h 15m
///
/// The check-out line is omitted while [Attendance.checkOut] is still null
/// (not yet checked out today).
String renderDailyReportText(DailyReport report, {Attendance? attendance}) {
  final buffer = StringBuffer();
  buffer.writeln(dailyReportTitle(report.day));

  if (attendance != null) {
    buffer.writeln();
    buffer.writeln('Attendance');
    for (final line in _attendanceReportLines(attendance)) {
      buffer.writeln(line);
    }
    buffer.writeln();
    buffer.writeln('Tasks');
  }

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

/// The "Attendance" block's body lines for [renderDailyReportText] — check-in
/// (with a late label when late), check-out (omitted while still null, with
/// an overtime/early label when applicable), and worked-vs-planned time.
/// [Attendance.checkIn] is assumed non-null: a row only exists once checked in.
List<String> _attendanceReportLines(Attendance attendance) {
  final checkIn = attendance.checkIn;
  if (checkIn == null) return const [];

  final lines = <String>[];

  final lateSuffix = attendance.lateMinutes > 0
      ? ' (${TimeFormat.hMm(attendance.lateMinutes)} late)'
      : '';
  lines.add('Check-in:  ${TimeFormat.hhMmFromDateTime(checkIn)}$lateSuffix');

  final checkOut = attendance.checkOut;
  if (checkOut != null) {
    final String checkOutSuffix;
    if (attendance.overtimeMinutes > 0) {
      checkOutSuffix = ' (${TimeFormat.hMm(attendance.overtimeMinutes)} overtime)';
    } else if (attendance.earlyLeaveMinutes > 0) {
      checkOutSuffix = ' (${TimeFormat.hMm(attendance.earlyLeaveMinutes)} early)';
    } else {
      checkOutSuffix = '';
    }
    lines.add('Check-out: ${TimeFormat.hhMmFromDateTime(checkOut)}$checkOutSuffix');
  }

  final plannedMinutes =
      attendance.expectedEndMinute -
      attendance.expectedStartMinute -
      attendance.lunchMinutes;
  final workedMinutes = checkOut != null
      ? attendance.workedMinutes
      : _workedSoFarMinutes(attendance);
  lines.add(
    'Worked:    ${TimeFormat.hMm(workedMinutes)} of ${TimeFormat.hMm(plannedMinutes)}',
  );

  return lines;
}

/// A live estimate of minutes worked so far today while still checked in
/// (i.e. before [Attendance.workedMinutes] itself gets computed at
/// check-out) — elapsed time since check-in, minus the scheduled lunch.
int _workedSoFarMinutes(Attendance attendance) {
  final checkIn = attendance.checkIn;
  if (checkIn == null) return 0;
  final elapsed = DateTime.now().difference(checkIn).inMinutes -
      attendance.lunchMinutes;
  return elapsed > 0 ? elapsed : 0;
}
