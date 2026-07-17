import 'dart:async';
import 'dart:convert';

import 'package:google_maps_webservice/distance.dart' as gmaps_distance;
import 'package:injectable/injectable.dart';

import '../domain/models/geo_point.dart';
import '../domain/models/commute_estimate.dart';

abstract class CommuteRoutingClient {
  Future<CommuteEstimate> fetchCommuteEstimate({
    required GeoPoint from,
    required GeoPoint to,
  });
}

/// Traffic-aware commute estimate backed by Google's Distance Matrix API,
/// via the `google_maps_webservice` package's Distance Matrix client.
///
/// Note: `google_maps_webservice`'s typed [gmaps_distance.DistanceResponse]
/// model doesn't expose the `duration_in_traffic` field returned by the API
/// when a `departure_time` is supplied (only its `directions.dart` client
/// does). We still use the package's [gmaps_distance.GoogleDistanceMatrix]
/// to build the request URL and perform the HTTP call, but decode the raw
/// JSON body ourselves to read `duration_in_traffic`.
@LazySingleton(as: CommuteRoutingClient)
class GoogleDistanceMatrixRoutingClient implements CommuteRoutingClient {
  final gmaps_distance.GoogleDistanceMatrix _client;

  GoogleDistanceMatrixRoutingClient(this._client);

  @override
  Future<CommuteEstimate> fetchCommuteEstimate({
    required GeoPoint from,
    required GeoPoint to,
  }) async {
    final url = _client.buildUrl(
      origin: <gmaps_distance.Location>[
        gmaps_distance.Location(lat: from.latitude, lng: from.longitude),
      ],
      destination: <gmaps_distance.Location>[
        gmaps_distance.Location(lat: to.latitude, lng: to.longitude),
      ],
      travelMode: gmaps_distance.TravelMode.driving,
      departureTime: DateTime.now(),
    );

    final response = await _client.httpClient
        .get(Uri.parse(url))
        .timeout(const Duration(seconds: 10));
    final body = json.decode(response.body) as Map<String, dynamic>;

    if (body['status'] != 'OK') {
      throw Exception(
        'Distance Matrix request failed: ${body['status']} '
        '${body['error_message'] ?? ''}',
      );
    }

    final rows = body['rows'] as List<dynamic>;
    final elements = rows.first['elements'] as List<dynamic>;
    final element = elements.first as Map<String, dynamic>;

    if (element['status'] != 'OK') {
      throw Exception('Distance Matrix element status: ${element['status']}');
    }

    final duration = element['duration'] as Map<String, dynamic>;
    final durationInTraffic =
        element['duration_in_traffic'] as Map<String, dynamic>?;

    final durationSeconds = (duration['value'] as num).toInt();
    final durationInTrafficSeconds =
        (durationInTraffic?['value'] as num?)?.toInt() ?? durationSeconds;

    return CommuteEstimate(
      durationMinutes: (durationSeconds / 60).round(),
      durationInTrafficMinutes: (durationInTrafficSeconds / 60).round(),
    );
  }
}
