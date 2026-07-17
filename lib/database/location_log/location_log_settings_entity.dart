import 'package:objectbox/objectbox.dart';

@Entity()
class LocationLogSettingsEntity {
  @Id()
  int id = 0;

  bool enabled;

  LocationLogSettingsEntity({this.enabled = false});
}
