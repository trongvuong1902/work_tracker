import 'package:injectable/injectable.dart';
import 'package:objectbox/objectbox.dart';

import '../../../database/location_log/location_log_settings_entity.dart';

abstract class LocationLogSettingsDao {
  void save(LocationLogSettingsEntity entity);
  LocationLogSettingsEntity? get();
}

@LazySingleton(as: LocationLogSettingsDao)
class LocationLogSettingsDaoImpl implements LocationLogSettingsDao {
  final Box<LocationLogSettingsEntity> _box;

  LocationLogSettingsDaoImpl(this._box);

  @override
  void save(LocationLogSettingsEntity entity) {
    // A user has exactly one location-log settings row. ObjectBox requires
    // id=0 to insert a new object (it assigns the id itself); reusing an
    // existing row's real id turns the put into an update of that same
    // singleton row.
    entity.id = get()?.id ?? 0;
    _box.put(entity);
  }

  @override
  LocationLogSettingsEntity? get() {
    final all = _box.getAll();
    return all.isEmpty ? null : all.first;
  }
}
