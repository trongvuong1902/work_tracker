import 'package:objectbox/objectbox.dart';

@Entity()
class LeaveReminderSettingsEntity {
  @Id()
  int id = 0;

  bool enabled;

  double? homeLat;
  double? homeLng;
  String? homeAddress;

  double? workLat;
  double? workLng;
  String? workAddress;

  int? lastCommuteMinutes;

  @Property(type: PropertyType.date)
  DateTime? lastCommuteUpdatedAt;

  int headsUpLeadMinutes;

  LeaveReminderSettingsEntity({
    this.enabled = false,
    this.homeLat,
    this.homeLng,
    this.homeAddress,
    this.workLat,
    this.workLng,
    this.workAddress,
    this.lastCommuteMinutes,
    this.lastCommuteUpdatedAt,
    this.headsUpLeadMinutes = 15,
  });
}
