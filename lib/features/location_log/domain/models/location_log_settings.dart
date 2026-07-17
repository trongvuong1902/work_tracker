import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_log_settings.freezed.dart';

@freezed
abstract class LocationLogSettings with _$LocationLogSettings {
  const factory LocationLogSettings({@Default(false) bool enabled}) =
      _LocationLogSettings;
}
