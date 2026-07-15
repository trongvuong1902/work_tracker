import 'package:injectable/injectable.dart';

import '../../../database/checkout_reminder/checkout_reminder_settings_entity.dart';
import '../domain/models/checkout_reminder_settings.dart';
import 'checkout_reminder_dao.dart';
import 'checkout_reminder_datasource.dart';

@LazySingleton(as: CheckoutReminderDatasource)
class CheckoutReminderDatasourceImpl implements CheckoutReminderDatasource {
  final CheckoutReminderDao _dao;

  CheckoutReminderDatasourceImpl(this._dao);

  @override
  Future<CheckoutReminderSettings> getSettings() async {
    final entity = _dao.get();
    return entity == null
        ? const CheckoutReminderSettings()
        : _toModel(entity);
  }

  @override
  Future<void> saveSettings(CheckoutReminderSettings settings) async {
    _dao.save(_toEntity(settings));
  }

  CheckoutReminderSettings _toModel(CheckoutReminderSettingsEntity entity) =>
      CheckoutReminderSettings(
        enabled: entity.enabled,
        leadMinutes: entity.leadMinutes,
      );

  CheckoutReminderSettingsEntity _toEntity(
    CheckoutReminderSettings settings,
  ) => CheckoutReminderSettingsEntity(
    enabled: settings.enabled,
    leadMinutes: settings.leadMinutes,
  );
}
