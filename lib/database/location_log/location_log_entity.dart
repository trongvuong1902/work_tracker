import 'package:objectbox/objectbox.dart';

/// A single recorded arrival/departure event, captured every time the
/// geofence bridge reports a transition. Append-only — one row per event,
/// never upserted — mirrors `CommuteSampleEntity`, unlike `AttendanceEntity`
/// which is one row per day and upserted.
@Entity()
class LocationLogEntity {
  @Id()
  int id = 0;

  int dayKey;

  /// [LocationLogType] index — stored as a plain int, same convention as
  /// `AttendanceEntity.status`.
  int type;

  @Property(type: PropertyType.date)
  DateTime timestamp;

  double? latitude;
  double? longitude;
  String? address;

  LocationLogEntity({
    required this.dayKey,
    required this.type,
    required this.timestamp,
    this.latitude,
    this.longitude,
    this.address,
  });
}
