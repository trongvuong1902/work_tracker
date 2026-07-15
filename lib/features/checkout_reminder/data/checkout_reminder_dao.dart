import 'package:injectable/injectable.dart';
import 'package:objectbox/objectbox.dart';

import '../../../database/checkout_reminder/checkout_reminder_settings_entity.dart';

abstract class CheckoutReminderDao {
  void save(CheckoutReminderSettingsEntity entity);
  CheckoutReminderSettingsEntity? get();
}

@LazySingleton(as: CheckoutReminderDao)
class CheckoutReminderDaoImpl implements CheckoutReminderDao {
  final Box<CheckoutReminderSettingsEntity> _box;

  CheckoutReminderDaoImpl(this._box);

  @override
  void save(CheckoutReminderSettingsEntity entity) {
    // A user has exactly one checkout-reminder settings row. ObjectBox
    // requires id=0 to insert a new object (it assigns the id itself);
    // reusing an existing row's real id turns the put into an update of
    // that same singleton row.
    entity.id = get()?.id ?? 0;
    _box.put(entity);
  }

  @override
  CheckoutReminderSettingsEntity? get() {
    final all = _box.getAll();
    return all.isEmpty ? null : all.first;
  }
}
