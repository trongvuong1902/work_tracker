import 'package:injectable/injectable.dart';
import 'package:objectbox/objectbox.dart';

import '../../../database/leave_reminder/leave_reminder_settings_entity.dart';

abstract class LeaveReminderDao {
  void save(LeaveReminderSettingsEntity entity);
  LeaveReminderSettingsEntity? get();
  void delete();
}

@LazySingleton(as: LeaveReminderDao)
class LeaveReminderDaoImpl implements LeaveReminderDao {
  final Box<LeaveReminderSettingsEntity> _box;

  LeaveReminderDaoImpl(this._box);

  @override
  void save(LeaveReminderSettingsEntity entity) {
    // A user has exactly one leave-reminder settings row. ObjectBox requires
    // id=0 to insert a new object (it assigns the id itself); reusing an
    // existing row's real id turns the put into an update of that same
    // singleton row.
    entity.id = get()?.id ?? 0;
    _box.put(entity);
  }

  @override
  LeaveReminderSettingsEntity? get() {
    final all = _box.getAll();
    return all.isEmpty ? null : all.first;
  }

  @override
  void delete() {
    final existing = get();
    if (existing != null) {
      _box.remove(existing.id);
    }
  }
}
