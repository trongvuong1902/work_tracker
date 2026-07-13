import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_schedule.freezed.dart';

@freezed
abstract class WorkSchedule with _$WorkSchedule {
  const factory WorkSchedule({
    required int startMinuteOfDay, // 540 (09:00)

    required int endMinuteOfDay, // 1080 (18:00)

    required int lunchMinutes,

    required int reminderMinutes,

    int? workingDaysMask,
  }) = _WorkSchedule;
}
