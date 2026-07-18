import 'package:objectbox/objectbox.dart';

/// One completed work session on a task: the wall-clock [start] and [end] of a
/// timer run. Written when a running segment is finalized (a segment spanning
/// midnight is split into one row per day). Unlike `TaskTimeLogEntity` (which
/// only accumulates seconds per day), this preserves the real clock times so
/// the daily report can show start/end per session.
@Entity()
class TaskTimeSessionEntity {
  @Id()
  int id = 0;

  int taskId;

  @Property(type: PropertyType.date)
  DateTime start;

  @Property(type: PropertyType.date)
  DateTime end;

  TaskTimeSessionEntity({
    required this.taskId,
    required this.start,
    required this.end,
  });
}
