part of 'location_activity_day_cubit.dart';

@freezed
abstract class LocationActivityDayState with _$LocationActivityDayState {
  const factory LocationActivityDayState({
    @Default(true) bool isLoading,
    @Default(<LocationLog>[]) List<LocationLog> events,
    @Default(<LocationLog, LocationLogBadgeTier>{})
    Map<LocationLog, LocationLogBadgeTier> badges,
  }) = _LocationActivityDayState;
}
