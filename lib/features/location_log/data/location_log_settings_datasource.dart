import '../domain/models/location_log_settings.dart';

abstract class LocationLogSettingsDatasource {
  Future<LocationLogSettings> getSettings();
  Future<void> saveSettings(LocationLogSettings settings);
}
