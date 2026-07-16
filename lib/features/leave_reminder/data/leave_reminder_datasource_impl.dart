import 'package:injectable/injectable.dart';

import '../../../database/leave_reminder/leave_reminder_settings_entity.dart';
import '../domain/models/geo_point.dart';
import '../domain/models/leave_reminder_settings.dart';
import 'leave_reminder_dao.dart';
import 'leave_reminder_datasource.dart';

@LazySingleton(as: LeaveReminderDatasource)
class LeaveReminderDatasourceImpl implements LeaveReminderDatasource {
  final LeaveReminderDao _dao;

  LeaveReminderDatasourceImpl(this._dao);

  @override
  Future<LeaveReminderSettings> getSettings() async {
    final entity = _dao.get();
    return entity == null ? const LeaveReminderSettings() : _toModel(entity);
  }

  @override
  Future<void> saveSettings(LeaveReminderSettings settings) async {
    _dao.save(_toEntity(settings));
  }

  @override
  Future<void> saveCommuteCache(int minutes, DateTime updatedAt) async {
    final entity = _dao.get() ?? LeaveReminderSettingsEntity();
    entity.lastCommuteMinutes = minutes;
    entity.lastCommuteUpdatedAt = updatedAt;
    _dao.save(entity);
  }

  LeaveReminderSettings _toModel(LeaveReminderSettingsEntity entity) =>
      LeaveReminderSettings(
        enabled: entity.enabled,
        home: entity.homeLat != null && entity.homeLng != null
            ? GeoPoint(
                latitude: entity.homeLat!,
                longitude: entity.homeLng!,
                address: entity.homeAddress,
              )
            : null,
        work: entity.workLat != null && entity.workLng != null
            ? GeoPoint(
                latitude: entity.workLat!,
                longitude: entity.workLng!,
                address: entity.workAddress,
              )
            : null,
        lastCommuteMinutes: entity.lastCommuteMinutes,
        lastCommuteUpdatedAt: entity.lastCommuteUpdatedAt,
        headsUpLeadMinutes: entity.headsUpLeadMinutes,
      );

  LeaveReminderSettingsEntity _toEntity(LeaveReminderSettings settings) =>
      LeaveReminderSettingsEntity(
        enabled: settings.enabled,
        homeLat: settings.home?.latitude,
        homeLng: settings.home?.longitude,
        homeAddress: settings.home?.address,
        workLat: settings.work?.latitude,
        workLng: settings.work?.longitude,
        workAddress: settings.work?.address,
        lastCommuteMinutes: settings.lastCommuteMinutes,
        lastCommuteUpdatedAt: settings.lastCommuteUpdatedAt,
        headsUpLeadMinutes: settings.headsUpLeadMinutes,
      );
}
