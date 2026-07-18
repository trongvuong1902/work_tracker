import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_time_log.freezed.dart';

/// One task's tracked time for one calendar [day] (day-normalized to local
/// midnight). Domain view of `TaskTimeLogEntity`.
@freezed
abstract class TaskTimeLog with _$TaskTimeLog {
  const factory TaskTimeLog({
    required int id,
    required int taskId,
    required DateTime day,
    required int seconds,
  }) = _TaskTimeLog;
}
