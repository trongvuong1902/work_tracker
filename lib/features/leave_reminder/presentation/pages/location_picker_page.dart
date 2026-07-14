import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/leave_reminder/data/location_source.dart';

/// Tap-anywhere-to-drop-a-pin map picker, reused for both "Set Home" and
/// "Set Work" from the leave-reminder setup sheet. Pops the picked [LatLng]
/// back via `Navigator.pop(context, latLng)`, or null if dismissed.
class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({super.key, required this.title, this.initial});

  final String title;
  final LatLng? initial;

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  // Reasonable default center when there's no initial pin and the device's
  // current location can't be read (no permission, no GPS fix, etc).
  static const _fallbackCenter = LatLng(21.0278, 105.8342);

  GoogleMapController? _mapController;
  LatLng? _picked;
  late LatLng _initialCameraTarget;
  bool _isCentering = false;

  @override
  void initState() {
    super.initState();
    _picked = widget.initial;
    _initialCameraTarget = widget.initial ?? _fallbackCenter;
    if (widget.initial == null) {
      _loadInitialCameraPosition();
    }
  }

  Future<void> _loadInitialCameraPosition() async {
    try {
      final current = await getIt<LocationSource>().getCurrentLocation();
      if (current == null || !mounted) return;
      final target = LatLng(current.latitude, current.longitude);
      setState(() => _initialCameraTarget = target);
      await _mapController?.animateCamera(CameraUpdate.newLatLng(target));
    } catch (_) {
      // Permission may not be granted — keep the fallback center.
    }
  }

  Future<void> _centerOnMyLocation() async {
    setState(() => _isCentering = true);
    try {
      final current = await getIt<LocationSource>().getCurrentLocation();
      if (current != null && mounted) {
        await _mapController?.animateCamera(
          CameraUpdate.newLatLng(LatLng(current.latitude, current.longitude)),
        );
      }
    } finally {
      if (mounted) setState(() => _isCentering = false);
    }
    // Note: this only recenters the camera — it never sets/moves the marker.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: 'Confirm',
            onPressed: _picked == null
                ? null
                : () => Navigator.pop(context, _picked),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialCameraTarget,
              zoom: 15,
            ),
            trafficEnabled: true,
            myLocationButtonEnabled: false,
            onMapCreated: (controller) => _mapController = controller,
            onTap: (latLng) => setState(() => _picked = latLng),
            markers: {
              if (_picked != null)
                Marker(markerId: const MarkerId('picked'), position: _picked!),
            },
          ),
          Positioned(
            right: AppSpacing.space16,
            bottom: AppSpacing.space16,
            child: FloatingActionButton(
              heroTag: 'leave_reminder_center_on_location',
              backgroundColor: context.colors.surface,
              foregroundColor: context.colors.primary,
              onPressed: _isCentering ? null : _centerOnMyLocation,
              child: _isCentering
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}
