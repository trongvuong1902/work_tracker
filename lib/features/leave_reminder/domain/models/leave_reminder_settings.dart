import 'package:freezed_annotation/freezed_annotation.dart';

import 'geo_point.dart';

part 'leave_reminder_settings.freezed.dart';

@freezed
abstract class LeaveReminderSettings with _$LeaveReminderSettings {
  const factory LeaveReminderSettings({
    @Default(false) bool enabled,
    GeoPoint? home,
    GeoPoint? work,
    int? lastCommuteMinutes,
    DateTime? lastCommuteUpdatedAt,
  }) = _LeaveReminderSettings;
}
