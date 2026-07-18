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

  // Single task priority, 1..5 (1 = most urgent), computed from the Zentao
  // severity + priority. Null for tasks with no priority.
  int? priority;

  // Free-text notes; for bug tasks this holds the mapped comment/action
  // history. Null when empty.
  String? notes;

  // JSON-encoded list of task attachments ({id,title,fileExtension,sizeBytes}).
  // Null when the task has none / hasn't been detail-synced yet.
  String? zentaoAttachmentsJson;

  // Bug-only raw fields, kept for the detail popup. Null for manual and
  // task-linked rows.
  int? zentaoPriority;

  int? zentaoSeverity;

  int? zentaoProductId;

  String? zentaoProductName;

  int? zentaoProductPriority;

  @Property(type: PropertyType.date)
  DateTime? zentaoLastSyncedAt;

  // When the bug's full detail (description/notes/attachments) was last
  // fetched. Null means it hasn't been fetched yet — the detail screen pulls
  // it lazily on first open.
  @Property(type: PropertyType.date)
  DateTime? zentaoDetailSyncedAt;

  int elapsedSeconds;

  // Non-null while the timer is running; the wall-clock time it was
  // started, so elapsed time can be derived even if the app is killed and
  // reopened mid-run.
  @Property(type: PropertyType.date)
  DateTime? timerStartedAt;

  // Bug-only: whether the linked Zentao bug has been confirmed. Seeded from
  // the server on sync and set to true after the app confirms it on the first
  // Start-timer, so subsequent starts don't re-confirm. Always false for
  // manual/task-linked rows.
  bool zentaoConfirmed;

  // Bug-only: the account of whoever opened (created) the Zentao bug — used as
  // the resolve assignee. Null until enriched from the bug detail.
  String? zentaoOpenedBy;

  TaskEntity({
    required this.title,
    this.description,
    required this.done,
    required this.createdAt,
    this.zentaoTaskId,
    this.zentaoBugId,
    this.zentaoStatus,
    this.priority,
    this.notes,
    this.zentaoAttachmentsJson,
    this.zentaoPriority,
    this.zentaoSeverity,
    this.zentaoProductId,
    this.zentaoProductName,
    this.zentaoProductPriority,
    this.zentaoLastSyncedAt,
    this.zentaoDetailSyncedAt,
    required this.elapsedSeconds,
    this.timerStartedAt,
    this.zentaoConfirmed = false,
    this.zentaoOpenedBy,
  });
}
