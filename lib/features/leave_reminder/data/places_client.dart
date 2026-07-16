import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../domain/models/geo_point.dart';
import '../domain/models/place_suggestion.dart';

abstract class PlacesClient {
  Future<List<PlaceSuggestion>> autocomplete(String query);
  Future<GeoPoint> getPlaceLocation(String placeId);
}

/// Address-search autocomplete + place-details lookup backed by Google's
/// Places API, called directly over HTTP (no `google_place`/similar package
/// — it's discontinued upstream and pins the pre-1.x `http` API this
/// project's `dependency_overrides` doesn't cover), decoded the same way as
/// [GoogleReverseGeocodingClient].
@LazySingleton(as: PlacesClient)
class GooglePlacesClient implements PlacesClient {
  static const _autocompleteUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static const _detailsUrl =
      'https://maps.googleapis.com/maps/api/place/details/json';
  static const _apiKey = String.fromEnvironment('GOOGLE_MAPS_API_KEY');

  @override
  Future<List<PlaceSuggestion>> autocomplete(String query) async {
    final uri = Uri.parse(
      _autocompleteUrl,
    ).replace(queryParameters: {'input': query, 'key': _apiKey});
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Autocomplete request failed: ${response.statusCode}');
    }
    final body = json.decode(response.body) as Map<String, dynamic>;
    if (body['status'] != 'OK' && body['status'] != 'ZERO_RESULTS') {
      throw Exception('Autocomplete failed: ${body['status']}');
    }
    final predictions = body['predictions'] as List<dynamic>? ?? [];
    return [
      for (final prediction in predictions)
        _toSuggestion(prediction as Map<String, dynamic>),
    ];
  }

  @override
  Future<GeoPoint> getPlaceLocation(String placeId) async {
    final uri = Uri.parse(_detailsUrl).replace(
      queryParameters: {
        'place_id': placeId,
        'key': _apiKey,
        'fields': 'geometry',
      },
    );
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Place details request failed: ${response.statusCode}');
    }
    final body = json.decode(response.body) as Map<String, dynamic>;
    if (body['status'] != 'OK') {
      throw Exception('Place details failed: ${body['status']}');
    }
    final result = body['result'] as Map<String, dynamic>;
    final geometry = result['geometry'] as Map<String, dynamic>;
    final location = geometry['location'] as Map<String, dynamic>;
    return GeoPoint(
      latitude: (location['lat'] as num).toDouble(),
      longitude: (location['lng'] as num).toDouble(),
    );
  }

  PlaceSuggestion _toSuggestion(Map<String, dynamic> prediction) {
    final structuredFormatting =
        prediction['structured_formatting'] as Map<String, dynamic>?;
    final primaryText =
        structuredFormatting?['main_text'] as String? ??
        prediction['description'] as String;
    final secondaryText =
        structuredFormatting?['secondary_text'] as String? ?? '';
    return PlaceSuggestion(
      placeId: prediction['place_id'] as String,
      primaryText: primaryText,
      secondaryText: secondaryText,
    );
  }
}
