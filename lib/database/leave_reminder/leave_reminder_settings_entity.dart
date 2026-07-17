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

  /// JSON-encoded list of `{lat, lng, address, enabled}` maps, one per
  /// commute waypoint (stop), in add-order. Nullable/additive column —
  /// existing rows have no value and are treated as an empty list.
  String? waypointsJson;

  /// Radius (meters) around [workLat]/[workLng] used by the geofence to
  /// detect arrival/departure — absorbs GPS drift.
  int workRadiusMeters;

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
    this.waypointsJson,
    this.workRadiusMeters = 150,
  });
}
