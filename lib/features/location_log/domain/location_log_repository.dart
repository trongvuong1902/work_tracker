import 'models/location_log.dart';

abstract class LocationLogRepository {
  Future<LocationLog> recordArrival({
    required DateTime at,
    double? lat,
    double? lng,
  });

  Future<LocationLog> recordDeparture({
    required DateTime at,
    double? lat,
    double? lng,
  });

  Future<List<LocationLog>> getLogsForDay(DateTime day);

  /// Logs whose day (by date, not exact time) falls within
  /// `[start, end]` inclusive — used by Screen A's day-grouped pagination.
  Future<List<LocationLog>> getLogsForDayRange({
    required DateTime start,
    required DateTime end,
  });

  Future<List<LocationLog>> getRecentLogs({int limit = 20});

  /// Broadcast stream of the most recently recorded logs, pushed on every
  /// [recordArrival]/[recordDeparture] call.
  Stream<List<LocationLog>> watchLogsChanges();

  Future<bool> isEnabled();

  Future<void> setEnabled(bool enabled);
}
