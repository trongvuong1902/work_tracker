import 'package:work_tracker/features/attendance/domain/models/attendance.dart';
import 'package:work_tracker/features/location_log/domain/models/location_log.dart';
import 'package:work_tracker/features/location_log/domain/models/location_log_type.dart';
import 'package:work_tracker/features/location_log/presentation/widgets/location_log_badge.dart';

/// Result of [computeLocationLogBadgeTiers]: the same [events] passed in,
/// sorted chronologically, alongside the audit-badge tier computed for each.
typedef LocationLogBadgeTiersResult = ({
  List<LocationLog> sorted,
  Map<LocationLog, LocationLogBadgeTier> badges,
});

/// Computes the 3-tier audit badge (see [LocationLogBadgeTier]) for every
/// event in a **single day's** [events], given that day's [attendance]
/// record. Shared by [TodayActivityTimelineCubit]-style single-day callers
/// and the multi-day Location Activity history screens — each day is
/// computed independently since "first arrival/departure of the day" only
/// makes sense within one day's events.
LocationLogBadgeTiersResult computeLocationLogBadgeTiers({
  required List<LocationLog> events,
  required Attendance? attendance,
}) {
  final sorted = [...events]
    ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

  final badges = <LocationLog, LocationLogBadgeTier>{};
  var firstArrivalSeen = false;
  var firstDepartureSeen = false;
  for (final log in sorted) {
    if (log.type == LocationLogType.arrival) {
      if (firstArrivalSeen) {
        badges[log] = LocationLogBadgeTier.none;
        continue;
      }
      firstArrivalSeen = true;
      if (attendance?.checkIn == log.timestamp) {
        badges[log] = LocationLogBadgeTier.assigned;
      } else if (attendance?.checkIn != null) {
        badges[log] = LocationLogBadgeTier.notUsed;
      } else {
        badges[log] = LocationLogBadgeTier.none;
      }
    } else {
      if (firstDepartureSeen) {
        badges[log] = LocationLogBadgeTier.none;
        continue;
      }
      firstDepartureSeen = true;
      if (attendance?.checkOut == log.timestamp) {
        badges[log] = LocationLogBadgeTier.assigned;
      } else if (attendance?.checkOut != null) {
        badges[log] = LocationLogBadgeTier.notUsed;
      } else {
        badges[log] = LocationLogBadgeTier.none;
      }
    }
  }

  return (sorted: sorted, badges: badges);
}
