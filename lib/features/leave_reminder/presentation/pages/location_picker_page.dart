import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/buttons/primary_button.dart';
import 'package:work_tracker/core/radius/app_radius.dart';
import 'package:work_tracker/core/shadow/app_shadow.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/leave_reminder/data/location_source.dart';
import 'package:work_tracker/features/leave_reminder/data/places_client.dart';
import 'package:work_tracker/features/leave_reminder/data/reverse_geocoding_client.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/geo_point.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/place_suggestion.dart';

/// Tap-anywhere-to-drop-a-pin map picker, reused for both "Set Home" and
/// "Set Work" from the leave-reminder setup sheet. Also supports free-text
/// address search with autocomplete, and defaults to the device's current
/// GPS position (reverse-geocoded) as the initial pick when opened fresh.
/// Pops the picked [GeoPoint] (coordinate + resolved/fallback label) back
/// via `Navigator.pop(context, geoPoint)`, or null if dismissed.
class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({super.key, required this.title, this.initial});

  final String title;
  final GeoPoint? initial;

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  // Reasonable default center when there's no initial pin and the device's
  // current location can't be read (no permission, no GPS fix, etc).
  static const _fallbackCenter = LatLng(21.0278, 105.8342);

  GoogleMapController? _mapController;
  LatLng? _picked;
  String? _pickedAddress;
  bool _isResolvingLabel = false;
  late LatLng _initialCameraTarget;
  bool _isCentering = false;
  bool _isResolvingInitialLocation = false;

  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  List<PlaceSuggestion> _suggestions = [];
  bool _isSearching = false;
  String? _searchError;
  Timer? _searchDebounce;
  Timer? _reverseGeocodeDebounce;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    _picked = initial != null
        ? LatLng(initial.latitude, initial.longitude)
        : null;
    _pickedAddress = initial?.address;
    _initialCameraTarget = _picked ?? _fallbackCenter;
    _searchFocusNode.addListener(() => setState(() {}));
    if (widget.initial == null) {
      _isResolvingInitialLocation = true;
      _loadInitialCameraPosition();
    }
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _reverseGeocodeDebounce?.cancel();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadInitialCameraPosition() async {
    try {
      final current = await getIt<LocationSource>().getCurrentLocation();
      if (current == null || !mounted) return;
      final target = LatLng(current.latitude, current.longitude);
      setState(() {
        _initialCameraTarget = target;
        _picked =
            target; // default GPS pin is now an actual pick, not just a recenter
      });
      await _mapController?.animateCamera(CameraUpdate.newLatLng(target));
      await _resolveLabelNow(target);
    } catch (_) {
      // Permission may not be granted, or GPS failed — keep the fallback
      // center, no pin.
    } finally {
      if (mounted) setState(() => _isResolvingInitialLocation = false);
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

  void _onMapTapped(LatLng point) {
    _searchController.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      _suggestions = [];
      _searchError = null;
      _picked = point;
    });
    _scheduleReverseGeocode(point);
  }

  void _onSearchChanged(String query) {
    setState(() {}); // refresh trailing clear/spinner state immediately
    _searchDebounce?.cancel();
    if (query.trim().isEmpty) {
      setState(() {
        _isSearching = false;
        _suggestions = [];
        _searchError = null;
      });
      return;
    }
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      _runAutocomplete(query);
    });
  }

  Future<void> _runAutocomplete(String query) async {
    setState(() {
      _isSearching = true;
      _searchError = null;
    });
    try {
      final results = await getIt<PlacesClient>().autocomplete(query);
      if (!mounted || _searchController.text != query) return;
      setState(() {
        _suggestions = results;
        _isSearching = false;
      });
    } catch (_) {
      if (!mounted || _searchController.text != query) return;
      setState(() {
        _suggestions = [];
        _isSearching = false;
        _searchError = "Couldn't load suggestions — check your connection.";
      });
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _suggestions = [];
      _isSearching = false;
      _searchError = null;
    });
  }

  Future<void> _onSuggestionSelected(PlaceSuggestion suggestion) async {
    _searchController.text = suggestion.primaryText;
    FocusScope.of(context).unfocus();
    setState(() {
      _suggestions = [];
      _searchError = null;
    });
    try {
      final location = await getIt<PlacesClient>().getPlaceLocation(
        suggestion.placeId,
      );
      if (!mounted) return;
      final point = LatLng(location.latitude, location.longitude);
      await _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(point, 16),
      );
      setState(() => _picked = point);
      _scheduleReverseGeocode(point);
    } catch (_) {
      // Silent fallback, consistent with the app's existing quiet-degrade
      // convention for location features.
    }
  }

  void _scheduleReverseGeocode(LatLng point) {
    _reverseGeocodeDebounce?.cancel();
    setState(() => _isResolvingLabel = true);
    _reverseGeocodeDebounce = Timer(const Duration(milliseconds: 500), () {
      _resolveLabelNow(point);
    });
  }

  Future<void> _resolveLabelNow(LatLng point) async {
    try {
      final address = await getIt<ReverseGeocodingClient>().reverseGeocode(
        GeoPoint(latitude: point.latitude, longitude: point.longitude),
      );
      if (!mounted || _picked != point) return;
      setState(() {
        _pickedAddress = address;
        _isResolvingLabel = false;
      });
    } catch (_) {
      if (!mounted || _picked != point) return;
      setState(() {
        _pickedAddress = null;
        _isResolvingLabel = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _initialCameraTarget,
                    zoom: 15,
                  ),
                  trafficEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  onMapCreated: (controller) => _mapController = controller,
                  onTap: _onMapTapped,
                  markers: {
                    if (_picked != null)
                      Marker(
                        markerId: const MarkerId('picked'),
                        position: _picked!,
                      ),
                  },
                ),
                if (!_isResolvingInitialLocation)
                  Positioned(
                    top: AppSpacing.space16,
                    left: AppSpacing.space16,
                    right: AppSpacing.space16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _SearchBar(
                          controller: _searchController,
                          focusNode: _searchFocusNode,
                          isSearching: _isSearching,
                          onChanged: _onSearchChanged,
                          onClear: _clearSearch,
                        ),
                        const SizedBox(height: AppSpacing.space8),
                        if (_searchFocusNode.hasFocus &&
                            _searchController.text.trim().isNotEmpty)
                          _SuggestionsDropdown(
                            suggestions: _suggestions,
                            isLoading: _isSearching,
                            errorMessage: _searchError,
                            onSelected: _onSuggestionSelected,
                          )
                        else if (_picked != null)
                          _SelectedLocationCard(
                            address: _pickedAddress,
                            isResolving: _isResolvingLabel,
                            point: _picked!,
                          ),
                      ],
                    ),
                  ),
                if (!_isResolvingInitialLocation)
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
                if (_isResolvingInitialLocation)
                  Positioned.fill(
                    child: ColoredBox(
                      color: context.colors.surface.withValues(alpha: 0.85),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: AppSpacing.space8),
                            Text(
                              'Finding your location…',
                              style: AppTypography.caption(
                                context,
                              )?.copyWith(color: context.colors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.space16),
              child: PrimaryButton(
                label: 'Confirm',
                onPressed: _picked == null
                    ? null
                    : () => Navigator.pop(
                        context,
                        GeoPoint(
                          latitude: _picked!.latitude,
                          longitude: _picked!.longitude,
                          address: _pickedAddress,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// `ShadowCard`-style search input surface — the app's first free-text
/// input component, so kept single-use/inline here rather than promoted
/// to `lib/components/`.
class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.controller,
    required this.focusNode,
    required this.isSearching,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isSearching;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(AppRadius.radius12),
        boxShadow: AppShadow.small,
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
      child: Row(
        children: [
          isSearching
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: context.colors.textSecondary,
                  ),
                )
              : Icon(Icons.search, color: context.colors.textSecondary),
          const SizedBox(width: AppSpacing.space8),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              onChanged: onChanged,
              style: AppTypography.body(
                context,
              )?.copyWith(color: context.colors.textSecondary),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.space16,
                ),
                hintText: 'Search for an address',
                hintStyle: AppTypography.body(
                  context,
                )?.copyWith(color: context.colors.textSecondary),
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            IconButton(
              icon: Icon(Icons.close, color: context.colors.textSecondary),
              onPressed: onClear,
              visualDensity: VisualDensity.compact,
            ),
        ],
      ),
    );
  }
}

class _SuggestionsDropdown extends StatelessWidget {
  const _SuggestionsDropdown({
    required this.suggestions,
    required this.isLoading,
    required this.errorMessage,
    required this.onSelected,
  });

  final List<PlaceSuggestion> suggestions;
  final bool isLoading;
  final String? errorMessage;
  final ValueChanged<PlaceSuggestion> onSelected;

  @override
  Widget build(BuildContext context) {
    // Avoids a flashing empty dropdown while the debounce/request is still
    // in flight and nothing has been resolved yet.
    if (isLoading && suggestions.isEmpty && errorMessage == null) {
      return const SizedBox.shrink();
    }

    Widget content;
    if (errorMessage != null) {
      content = _MessageRow(icon: Icons.error_outline, message: errorMessage!);
    } else if (suggestions.isEmpty) {
      content = const _MessageRow(
        icon: Icons.search_off,
        message: 'No matching addresses.',
      );
    } else {
      content = ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 260),
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: suggestions.length,
          separatorBuilder: (_, _) =>
              Divider(height: 1, color: context.colors.divider),
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return InkWell(
              onTap: () => onSelected(suggestion),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space16,
                  vertical: AppSpacing.space12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      suggestion.primaryText,
                      style: AppTypography.body(
                        context,
                      )?.copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (suggestion.secondaryText.isNotEmpty)
                      Text(
                        suggestion.secondaryText,
                        style: AppTypography.caption(
                          context,
                        )?.copyWith(color: context.colors.textSecondary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(AppRadius.radius12),
        boxShadow: AppShadow.small,
      ),
      child: content,
    );
  }
}

class _MessageRow extends StatelessWidget {
  const _MessageRow({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space16,
        vertical: AppSpacing.space16,
      ),
      child: Row(
        children: [
          Icon(icon, color: context.colors.textSecondary, size: 20),
          const SizedBox(width: AppSpacing.space8),
          Expanded(
            child: Text(
              message,
              style: AppTypography.body(
                context,
              )?.copyWith(color: context.colors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectedLocationCard extends StatelessWidget {
  const _SelectedLocationCard({
    required this.address,
    required this.isResolving,
    required this.point,
  });

  final String? address;
  final bool isResolving;
  final LatLng point;

  @override
  Widget build(BuildContext context) {
    final String title;
    final String? subtitle;
    if (isResolving) {
      title = 'Selected location';
      subtitle = null;
    } else if (address != null) {
      title = address!;
      subtitle = null;
    } else {
      title =
          '${point.latitude.toStringAsFixed(5)}, '
          '${point.longitude.toStringAsFixed(5)}';
      subtitle = null;
    }

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(AppRadius.radius12),
        boxShadow: AppShadow.small,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space16,
        vertical: AppSpacing.space12,
      ),
      child: Row(
        children: [
          Icon(Icons.place, color: context.colors.primary),
          const SizedBox(width: AppSpacing.space8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.label(
                    context,
                  )?.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: AppTypography.caption(
                      context,
                    )?.copyWith(color: context.colors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          if (isResolving)
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
        ],
      ),
    );
  }
}
