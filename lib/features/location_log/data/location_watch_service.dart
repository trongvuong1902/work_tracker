import 'dart:async';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

/// Thin wrapper around [Geolocator]'s position stream, translating raw
/// position updates into inside/outside-radius transition callbacks. The
/// only class in the location-log feature that touches geolocator's
/// streaming API directly — kept as a seam so it can be faked in tests.
abstract class LocationWatchService {
  /// Starts watching the device's position relative to a circle of
  /// [radiusMeters] around ([centerLat], [centerLng]). [onInside]/[onOutside]
  /// fire only on a transition — i.e. they're never called again while the
  /// device stays on the same side of the boundary as the last reading.
  void start({
    required double centerLat,
    required double centerLng,
    required int radiusMeters,
    required void Function() onInside,
    required void Function() onOutside,
  });

  /// Cancels the internal position stream subscription, if any.
  void stop();
}

@LazySingleton(as: LocationWatchService)
class LocationWatchServiceImpl implements LocationWatchService {
  StreamSubscription<Position>? _subscription;

  /// Whether the last reading was inside the radius. `null` until the first
  /// reading arrives, so that reading always fires a callback regardless of
  /// which side of the boundary it lands on.
  bool? _wasInside;

  @override
  void start({
    required double centerLat,
    required double centerLng,
    required int radiusMeters,
    required void Function() onInside,
    required void Function() onOutside,
  }) {
    stop();
    _wasInside = null;

    _subscription = Geolocator.getPositionStream(
      locationSettings: _locationSettings,
    ).listen((position) {
      final distance = Geolocator.distanceBetween(
        centerLat,
        centerLng,
        position.latitude,
        position.longitude,
      );
      final isInside = distance <= radiusMeters;
      if (_wasInside == isInside) return; // no transition — don't spam.
      _wasInside = isInside;
      isInside ? onInside() : onOutside();
    });
  }

  @override
  void stop() {
    _subscription?.cancel();
    _subscription = null;
    _wasInside = null;
  }

  LocationSettings get _locationSettings {
    if (Platform.isAndroid) {
      return AndroidSettings(
        distanceFilter: 25,
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationTitle: 'WorkTracker',
          notificationText: 'Tracking arrival/departure at work',
        ),
      );
    }
    if (Platform.isIOS) {
      return AppleSettings(
        distanceFilter: 25,
        allowBackgroundLocationUpdates: true,
        pauseLocationUpdatesAutomatically: true,
      );
    }
    return const LocationSettings(distanceFilter: 25);
  }
}
