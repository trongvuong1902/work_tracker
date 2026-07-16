import 'models/weather_snapshot.dart';

/// Looks up the best available weather reading for [target] within
/// [snapshot].
///
/// When [target] is within [nearNowThreshold] of `snapshot.currentTime`, the
/// current conditions are reused instead of a separately indexed forecast
/// bucket — this avoids two adjacent digest lines showing inconsistent
/// readings for two nearly-identical clock times. Otherwise, the hourly
/// point whose time is closest to [target] is used. Returns `null` when no
/// hourly forecast is available.
({int weatherCode, double temperature})? weatherReadingAt(
  WeatherSnapshot snapshot,
  DateTime target, {
  Duration nearNowThreshold = const Duration(minutes: 45),
}) {
  if (target.difference(snapshot.currentTime).abs() <= nearNowThreshold) {
    return (
      weatherCode: snapshot.currentWeatherCode,
      temperature: snapshot.currentTemperature,
    );
  }

  if (snapshot.hourly.isEmpty) return null;

  var closest = snapshot.hourly.first;
  var closestDiff = closest.time.difference(target).abs();
  for (final point in snapshot.hourly.skip(1)) {
    final diff = point.time.difference(target).abs();
    if (diff < closestDiff) {
      closest = point;
      closestDiff = diff;
    }
  }

  return (weatherCode: closest.weatherCode, temperature: closest.temperature);
}
