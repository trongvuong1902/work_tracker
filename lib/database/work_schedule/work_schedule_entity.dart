import 'package:objectbox/objectbox.dart';

@Entity()
class WorkScheduleEntity {
  @Id()
  int id = 0;

  int startMinute;

  int endMinute;

  int lunchMinutes;

  int lunchStartMinute;

  int reminderMinutes;

  int workingDaysMask;

  WorkScheduleEntity({
    required this.startMinute,
    required this.endMinute,
    required this.lunchMinutes,
    required this.lunchStartMinute,
    required this.reminderMinutes,
    required this.workingDaysMask,
  });
}
