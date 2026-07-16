import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../domain/models/geo_point.dart';
import '../domain/models/hourly_weather_point.dart';
import '../domain/models/weather_snapshot.dart';

abstract class WeatherClient {
  Future<WeatherSnapshot> fetchWeatherSnapshot(GeoPoint location);
}

/// Fetches current conditions plus an hourly forecast from Open-Meteo's
/// free, no-API-key-required forecast endpoint in a single combined call.
@LazySingleton(as: WeatherClient)
class OpenMeteoWeatherClient implements WeatherClient {
  static const _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  @override
  Future<WeatherSnapshot> fetchWeatherSnapshot(GeoPoint location) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'latitude': location.latitude.toString(),
        'longitude': location.longitude.toString(),
        'current_weather': 'true',
        'hourly': 'temperature_2m,weathercode',
        'timezone': 'auto',
        'forecast_days': '1',
      },
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception(
        'Open-Meteo request failed with status ${response.statusCode}',
      );
    }

    final body = json.decode(response.body) as Map<String, dynamic>;
    final currentWeather = body['current_weather'] as Map<String, dynamic>?;
    if (currentWeather == null ||
        currentWeather['weathercode'] == null ||
        currentWeather['temperature'] == null ||
        currentWeather['time'] == null) {
      throw Exception('Open-Meteo response missing current_weather block');
    }

    final hourly = body['hourly'] as Map<String, dynamic>?;
    if (hourly == null ||
        hourly['time'] == null ||
        hourly['temperature_2m'] == null ||
        hourly['weathercode'] == null) {
      throw Exception('Open-Meteo response missing hourly block');
    }

    final hourlyTimes = hourly['time'] as List<dynamic>;
    final hourlyTemperatures = hourly['temperature_2m'] as List<dynamic>;
    final hourlyWeatherCodes = hourly['weathercode'] as List<dynamic>;

    final hourlyPoints = <HourlyWeatherPoint>[
      for (var i = 0; i < hourlyTimes.length; i++)
        HourlyWeatherPoint(
          time: DateTime.parse(hourlyTimes[i] as String),
          temperature: (hourlyTemperatures[i] as num).toDouble(),
          weatherCode: (hourlyWeatherCodes[i] as num).toInt(),
        ),
    ];

    return WeatherSnapshot(
      currentTime: DateTime.parse(currentWeather['time'] as String),
      currentWeatherCode: (currentWeather['weathercode'] as num).toInt(),
      currentTemperature: (currentWeather['temperature'] as num).toDouble(),
      hourly: hourlyPoints,
    );
  }
}
