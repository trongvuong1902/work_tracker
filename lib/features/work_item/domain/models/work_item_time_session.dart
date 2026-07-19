import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_item_time_session.freezed.dart';

/// A single completed work session on a task — the wall-clock [start] and
/// [end]. Domain view of `WorkItemTimeSessionEntity`.
@freezed
abstract class WorkItemTimeSession with _$WorkItemTimeSession {
  const factory WorkItemTimeSession({
    required int id,
    required int taskId,
    required DateTime start,
    required DateTime end,
  }) = _WorkItemTimeSession;

  const WorkItemTimeSession._();

  int get durationSeconds => end.difference(start).inSeconds;
}
