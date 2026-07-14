import 'package:work_tracker/features/schedule/domain/models/work_schedule.dart';

abstract class WorkScheduleDatasource {
  Future<void> saveWorkSchedule(WorkSchedule workSchedule);
  Future<WorkSchedule?> getSchedule();
  int get workingDaysMask;
}
