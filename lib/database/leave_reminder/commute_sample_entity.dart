import 'package:objectbox/objectbox.dart';

/// A single recorded commute-duration reading, captured on every successful
/// live commute-estimate fetch (subject to [kCommuteSampleCooldown]) and
/// used to compute a rolling average over [kCommuteHistoryWindow]. Pruned
/// past the window and wiped entirely whenever Home or Work changes (an
/// average spanning a location change is meaningless).
@Entity()
class CommuteSampleEntity {
  @Id()
  int id = 0;

  int minutes;

  @Property(type: PropertyType.date)
  DateTime capturedAt;

  CommuteSampleEntity({required this.minutes, required this.capturedAt});
}
