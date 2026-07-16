import 'package:freezed_annotation/freezed_annotation.dart';

import 'hourly_weather_point.dart';

part 'weather_snapshot.freezed.dart';

@freezed
abstract class WeatherSnapshot with _$WeatherSnapshot {
  const factory WeatherSnapshot({
    required DateTime currentTime,
    required int currentWeatherCode,
    required double currentTemperature,
    required List<HourlyWeatherPoint> hourly,
  }) = _WeatherSnapshot;
}
