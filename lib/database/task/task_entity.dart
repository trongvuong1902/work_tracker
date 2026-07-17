import 'package:objectbox/objectbox.dart';

@Entity()
class TaskEntity {
  @Id()
  int id = 0;

  String title;

  String? description;

  bool done;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  // null for manual tasks; set for tasks imported from Zentao. Mutually
  // exclusive with zentaoBugId — a row is never linked to both.
  int? zentaoTaskId;

  // null for manual tasks and task-linked tasks; set for tasks imported
  // from a Zentao bug. Mutually exclusive with zentaoTaskId.
  int? zentaoBugId;

  String? zentaoStatus;

  // Bug-only rich fields, persisted so the task list can sort offline. Null
  // for manual and task-linked rows.
  int? zentaoPriority;

  int? zentaoSeverity;

  int? zentaoProductId;

  String? zentaoProductName;

  int? zentaoProductPriority;

  @Property(type: PropertyType.date)
  DateTime? zentaoLastSyncedAt;

  int elapsedSeconds;

  // Non-null while the timer is running; the wall-clock time it was
  // started, so elapsed time can be derived even if the app is killed and
  // reopened mid-run.
  @Property(type: PropertyType.date)
  DateTime? timerStartedAt;

  TaskEntity({
    required this.title,
    this.description,
    required this.done,
    required this.createdAt,
    this.zentaoTaskId,
    this.zentaoBugId,
    this.zentaoStatus,
    this.zentaoPriority,
    this.zentaoSeverity,
    this.zentaoProductId,
    this.zentaoProductName,
    this.zentaoProductPriority,
    this.zentaoLastSyncedAt,
    required this.elapsedSeconds,
    this.timerStartedAt,
  });
}
