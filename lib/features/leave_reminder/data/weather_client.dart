import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../domain/models/geo_point.dart';

abstract class WeatherClient {
  Future<int> fetchWeatherCode(GeoPoint location);
}

/// Fetches the current WMO weather code from Open-Meteo's free,
/// no-API-key-required forecast endpoint.
@LazySingleton(as: WeatherClient)
class OpenMeteoWeatherClient implements WeatherClient {
  static const _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  @override
  Future<int> fetchWeatherCode(GeoPoint location) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'latitude': location.latitude.toString(),
        'longitude': location.longitude.toString(),
        'current_weather': 'true',
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
    if (currentWeather == null || currentWeather['weathercode'] == null) {
      throw Exception('Open-Meteo response missing current_weather code');
    }

    return (currentWeather['weathercode'] as num).toInt();
  }
}
