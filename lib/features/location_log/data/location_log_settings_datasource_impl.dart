import 'package:injectable/injectable.dart';

import '../../../database/location_log/location_log_settings_entity.dart';
import '../domain/models/location_log_settings.dart';
import 'location_log_settings_dao.dart';
import 'location_log_settings_datasource.dart';

@LazySingleton(as: LocationLogSettingsDatasource)
class LocationLogSettingsDatasourceImpl
    implements LocationLogSettingsDatasource {
  final LocationLogSettingsDao _dao;

  LocationLogSettingsDatasourceImpl(this._dao);

  @override
  Future<LocationLogSettings> getSettings() async {
    final entity = _dao.get();
    return entity == null ? const LocationLogSettings() : _toModel(entity);
  }

  @override
  Future<void> saveSettings(LocationLogSettings settings) async {
    _dao.save(_toEntity(settings));
  }

  LocationLogSettings _toModel(LocationLogSettingsEntity entity) =>
      LocationLogSettings(enabled: entity.enabled);

  LocationLogSettingsEntity _toEntity(LocationLogSettings settings) =>
      LocationLogSettingsEntity(enabled: settings.enabled);
}
