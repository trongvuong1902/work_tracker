part of 'today_activity_timeline_cubit.dart';

@freezed
abstract class TodayActivityTimelineState with _$TodayActivityTimelineState {
  const factory TodayActivityTimelineState.notEnabled() = _NotEnabled;

  const factory TodayActivityTimelineState.noEventsToday() = _NoEventsToday;

  const factory TodayActivityTimelineState.populated({
    required List<LocationLog> events,
    required Map<LocationLog, LocationLogBadgeTier> badges,
  }) = _Populated;
}
