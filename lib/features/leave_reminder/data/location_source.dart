import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import '../domain/models/geo_point.dart';

/// Wraps `geolocator`'s permission + current-position APIs. Used only for
/// the map picker's "center on my location" convenience button — never for
/// continuous tracking or auto-setting a pin.
abstract class LocationSource {
  /// Returns the device's current position, requesting When-In-Use
  /// permission if needed. Returns null if permission is denied or the
  /// location service is unavailable.
  Future<GeoPoint?> getCurrentLocation();
}

@LazySingleton(as: LocationSource)
class LocationSourceImpl implements LocationSource {
  @override
  Future<GeoPoint?> getCurrentLocation() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
        ),
      );
      return GeoPoint(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (_) {
      return null;
    }
  }
}
