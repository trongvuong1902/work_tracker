import 'package:freezed_annotation/freezed_annotation.dart';

part 'hourly_weather_point.freezed.dart';

@freezed
abstract class HourlyWeatherPoint with _$HourlyWeatherPoint {
  const factory HourlyWeatherPoint({
    required DateTime time,
    required double temperature,
    required int weatherCode,
  }) = _HourlyWeatherPoint;
}
