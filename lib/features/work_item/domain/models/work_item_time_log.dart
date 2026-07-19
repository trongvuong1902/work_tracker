import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_item_time_log.freezed.dart';

/// One task's tracked time for one calendar [day] (day-normalized to local
/// midnight). Domain view of `WorkItemTimeLogEntity`.
@freezed
abstract class WorkItemTimeLog with _$WorkItemTimeLog {
  const factory WorkItemTimeLog({
    required int id,
    required int taskId,
    required DateTime day,
    required int seconds,
  }) = _WorkItemTimeLog;
}
