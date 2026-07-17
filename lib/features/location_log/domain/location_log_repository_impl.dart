import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../core/notifications/notification_service.dart';
import '../../../database/location_log/location_log_entity.dart';
import '../data/location_log_dao.dart';
import '../data/location_log_settings_datasource.dart';
import '../location_log_constants.dart';
import 'location_log_repository.dart';
import 'models/location_log.dart';
import 'models/location_log_type.dart';

@LazySingleton(as: LocationLogRepository)
class LocationLogRepositoryImpl implements LocationLogRepository {
  final LocationLogDao _dao;
  final LocationLogSettingsDatasource _settingsDatasource;
  final NotificationService _notificationService;

  LocationLogRepositoryImpl(
    this._dao,
    this._settingsDatasource,
    this._notificationService,
  );

  final _logsChangesController =
      StreamController<List<LocationLog>>.broadcast();

  @override
  Future<LocationLog> recordArrival({
    required DateTime at,
    double? lat,
    double? lng,
  }) => _record(type: LocationLogType.arrival, at: at, lat: lat, lng: lng);

  @override
  Future<LocationLog> recordDeparture({
    required DateTime at,
    double? lat,
    double? lng,
  }) => _record(type: LocationLogType.departure, at: at, lat: lat, lng: lng);

  Future<LocationLog> _record({
    required LocationLogType type,
    required DateTime at,
    double? lat,
    double? lng,
  }) async {
    final dayKey = _dayKeyOf(at);
    final entity = LocationLogEntity(
      dayKey: dayKey,
      type: type.index,
      timestamp: at,
      latitude: lat,
      longitude: lng,
    );
    _dao.insert(entity);

    final time =
        '${at.hour.toString().padLeft(2, '0')}:'
        '${at.minute.toString().padLeft(2, '0')}';
    await _notificationService.show(
      id: type == LocationLogType.arrival
          ? kArrivalLogNotificationId
          : kDepartureLogNotificationId,
      title: type == LocationLogType.arrival
          ? '📍 Arrived at work'
          : '🚪 Left work',
      body: 'Detected at $time',
    );

    _logsChangesController.add(_dao.getByDayKey(dayKey).map(_toModel).toList());

    return _toModel(entity);
  }

  @override
  Future<List<LocationLog>> getLogsForDay(DateTime day) async {
    return _dao.getByDayKey(_dayKeyOf(day)).map(_toModel).toList();
  }

  @override
  Future<List<LocationLog>> getLogsForDayRange({
    required DateTime start,
    required DateTime end,
  }) async {
    return _dao
        .getByDayKeyRange(
          startDayKey: _dayKeyOf(start),
          endDayKey: _dayKeyOf(end),
        )
        .map(_toModel)
        .toList();
  }

  @override
  Future<List<LocationLog>> getRecentLogs({int limit = 20}) async {
    return _dao.getRecent(limit: limit).map(_toModel).toList();
  }

  @override
  Stream<List<LocationLog>> watchLogsChanges() => _logsChangesController.stream;

  @override
  Future<bool> isEnabled() async {
    final settings = await _settingsDatasource.getSettings();
    return settings.enabled;
  }

  @override
  Future<void> setEnabled(bool enabled) async {
    final settings = await _settingsDatasource.getSettings();
    await _settingsDatasource.saveSettings(settings.copyWith(enabled: enabled));
  }

  /// The `yyyyMMdd`-style day key for [time]'s date component. Same
  /// derivation as `AttendanceRepositoryImpl._dayKeyOf`.
  int _dayKeyOf(DateTime time) {
    final workDate = DateTime(time.year, time.month, time.day);
    return workDate.year * 10000 + workDate.month * 100 + workDate.day;
  }

  LocationLog _toModel(LocationLogEntity entity) => LocationLog(
    dayKey: entity.dayKey,
    type: LocationLogType.values[entity.type],
    timestamp: entity.timestamp,
    latitude: entity.latitude,
    longitude: entity.longitude,
    address: entity.address,
  );
}
