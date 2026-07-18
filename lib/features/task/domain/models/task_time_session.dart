import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_time_session.freezed.dart';

/// A single completed work session on a task — the wall-clock [start] and
/// [end]. Domain view of `TaskTimeSessionEntity`.
@freezed
abstract class TaskTimeSession with _$TaskTimeSession {
  const factory TaskTimeSession({
    required int id,
    required int taskId,
    required DateTime start,
    required DateTime end,
  }) = _TaskTimeSession;

  const TaskTimeSession._();

  int get durationSeconds => end.difference(start).inSeconds;
}
