import 'package:objectbox/objectbox.dart';

@Entity()
class AttendanceEntity {
  @Id()
  int id = 0;

  // Add other fields as needed
  @Property(type: PropertyType.date)
  DateTime workDate;

  int dayKey;

  @Property(type: PropertyType.date)
  DateTime? checkIn;

  @Property(type: PropertyType.date)
  DateTime? checkOut;

  int expectedStartMinute;

  int expectedEndMinute;

  int lunchMinutes;

  int workedMinutes;

  int lateMinutes;

  int overtimeMinutes;

  int earlyLeaveMinutes;

  int status;

  String? note;

  bool isEdited;

  @Property(type: PropertyType.date)
  DateTime? editedAt;

  AttendanceEntity({
    required this.workDate,
    required this.dayKey,
    required this.expectedStartMinute,
    required this.expectedEndMinute,
    required this.lunchMinutes,
    required this.workedMinutes,
    this.lateMinutes = 0,
    this.overtimeMinutes = 0,
    this.earlyLeaveMinutes = 0,
    this.status = 0,
    this.note,
    this.checkIn,
    this.checkOut,
    this.isEdited = false,
    this.editedAt,
  });
}
