import 'package:freezed_annotation/freezed_annotation.dart';

import 'location_log_type.dart';

part 'location_log.freezed.dart';

/// A single recorded arrival/departure event at the user's work location.
/// Append-only — every event is its own row, never upserted.
@freezed
abstract class LocationLog with _$LocationLog {
  const factory LocationLog({
    required int dayKey,
    required LocationLogType type,
    required DateTime timestamp,
    double? latitude,
    double? longitude,
    String? address,
  }) = _LocationLog;
}
