import 'package:freezed_annotation/freezed_annotation.dart';

import 'geo_point.dart';

part 'commute_waypoint.freezed.dart';

@freezed
abstract class CommuteWaypoint with _$CommuteWaypoint {
  const factory CommuteWaypoint({
    required GeoPoint location,
    @Default(true) bool enabled,
  }) = _CommuteWaypoint;
}
