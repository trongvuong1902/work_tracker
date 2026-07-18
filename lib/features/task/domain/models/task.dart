import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../zentao/domain/models/zentao_bug_attachment.dart';

part 'task.freezed.dart';

@freezed
abstract class Task with _$Task {
  const factory Task({
    required int id,
    required String title,
    String? description,
    required bool done,
    required DateTime createdAt,
    int? zentaoTaskId,
    int? zentaoBugId,
    String? zentaoStatus,
    int? priority,
    String? notes,
    @Default(<ZentaoBugAttachment>[]) List<ZentaoBugAttachment> attachments,
    int? zentaoPriority,
    int? zentaoSeverity,
    int? zentaoProductId,
    String? zentaoProductName,
    int? zentaoProductPriority,
    DateTime? zentaoLastSyncedAt,
    DateTime? zentaoDetailSyncedAt,
    required int elapsedSeconds,
    DateTime? timerStartedAt,
    @Default(false) bool zentaoConfirmed,
  }) = _Task;
}

extension TaskX on Task {
  bool get isLinkedToZentao => zentaoTaskId != null;

  bool get isLinkedToZentaoBug => zentaoBugId != null;

  bool get isLinkedToAnyZentao => isLinkedToZentao || isLinkedToZentaoBug;

  bool get isTimerRunning => timerStartedAt != null;

  /// Elapsed tracked time as of [now] (defaults to the current time) —
  /// includes the in-progress running segment if the timer is currently
  /// started. Purely derived for live display; the authoritative
  /// accumulation happens in `TaskRepositoryImpl.stopTimer`.
  int currentElapsedSeconds([DateTime? now]) {
    final startedAt = timerStartedAt;
    if (startedAt == null) return elapsedSeconds;
    final reference = now ?? DateTime.now();
    return elapsedSeconds + reference.difference(startedAt).inSeconds;
  }
}
