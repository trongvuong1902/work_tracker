import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../domain/models/geo_point.dart';

abstract class ReverseGeocodingClient {
  Future<String> reverseGeocode(GeoPoint point);
}

/// Resolves a coordinate to a human-readable address via Google's Geocoding
/// API, called every time a pin is placed in the location picker (search
/// selection, default GPS pin, or manual map tap).
@LazySingleton(as: ReverseGeocodingClient)
class GoogleReverseGeocodingClient implements ReverseGeocodingClient {
  static const _baseUrl = 'https://maps.googleapis.com/maps/api/geocode/json';
  static const _apiKey = String.fromEnvironment('GOOGLE_MAPS_API_KEY');

  @override
  Future<String> reverseGeocode(GeoPoint point) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'latlng': '${point.latitude},${point.longitude}',
        'key': _apiKey,
      },
    );
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Geocoding request failed: ${response.statusCode}');
    }
    final body = json.decode(response.body) as Map<String, dynamic>;
    if (body['status'] != 'OK') {
      throw Exception('Geocoding failed: ${body['status']}');
    }
    final results = body['results'] as List<dynamic>;
    if (results.isEmpty) throw Exception('Geocoding returned no results');
    return (results.first as Map<String, dynamic>)['formatted_address']
        as String;
  }
}
