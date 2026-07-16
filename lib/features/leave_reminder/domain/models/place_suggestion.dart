import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_suggestion.freezed.dart';

/// Presentation-only row for the location picker's address-search dropdown.
/// Never persisted — resolving a suggestion to a coordinate/label happens
/// via [PlacesClient.getPlaceLocation] followed by a reverse-geocode call.
@freezed
abstract class PlaceSuggestion with _$PlaceSuggestion {
  const factory PlaceSuggestion({
    required String placeId,
    required String primaryText,
    required String secondaryText,
  }) = _PlaceSuggestion;
}
