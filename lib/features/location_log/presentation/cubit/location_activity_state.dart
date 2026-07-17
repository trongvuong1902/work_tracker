part of 'location_activity_cubit.dart';

@freezed
abstract class LocationActivityState with _$LocationActivityState {
  const factory LocationActivityState.loading() = _Loading;

  const factory LocationActivityState.notEnabled() = _NotEnabled;

  const factory LocationActivityState.enabledNoEvents() = _EnabledNoEvents;

  const factory LocationActivityState.populated({
    required List<LocationActivityDaySection> sections,
    required bool canLoadMore,
    required bool isLoadingMore,
  }) = _Populated;
}

/// One day's worth of events + their computed audit-badge tiers, as shown
/// in one [LocationLogDaySection] on Screen A.
@freezed
abstract class LocationActivityDaySection with _$LocationActivityDaySection {
  const factory LocationActivityDaySection({
    required DateTime date,
    required List<LocationLog> events,
    required Map<LocationLog, LocationLogBadgeTier> badges,
  }) = _LocationActivityDaySection;
}
