import 'package:objectbox/objectbox.dart';

@Entity()
class LeaveReminderSettingsEntity {
  @Id()
  int id = 0;

  bool enabled;

  double? homeLat;
  double? homeLng;

  double? workLat;
  double? workLng;

  int? lastCommuteMinutes;

  @Property(type: PropertyType.date)
  DateTime? lastCommuteUpdatedAt;

  LeaveReminderSettingsEntity({
    this.enabled = false,
    this.homeLat,
    this.homeLng,
    this.workLat,
    this.workLng,
    this.lastCommuteMinutes,
    this.lastCommuteUpdatedAt,
  });
}
