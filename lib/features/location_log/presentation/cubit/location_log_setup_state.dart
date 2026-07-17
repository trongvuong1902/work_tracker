part of 'location_log_setup_cubit.dart';

@freezed
abstract class LocationLogSetupState with _$LocationLogSetupState {
  const factory LocationLogSetupState({
    @Default(true) bool isLoading,
    @Default(false) bool enabled,
    @Default(false) bool isTogglingEnabled,
    @Default(false) bool hasWorkLocation,
    String? errorMessage,
  }) = _LocationLogSetupState;
}
