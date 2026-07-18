import 'package:objectbox/objectbox.dart';

/// One task's tracked time for one calendar day. Written going forward when a
/// running timer segment is finalized; a segment spanning midnight is split so
/// each day gets its own row. There is at most one row per (taskId, day) — it
/// is incremented rather than duplicated.
@Entity()
class TaskTimeLogEntity {
  @Id()
  int id = 0;

  // The logical TaskEntity.id this time belongs to.
  int taskId;

  // Day-normalized to local midnight — the calendar day the work happened.
  @Property(type: PropertyType.date)
  DateTime day;

  int seconds;

  TaskTimeLogEntity({
    required this.taskId,
    required this.day,
    required this.seconds,
  });
}
