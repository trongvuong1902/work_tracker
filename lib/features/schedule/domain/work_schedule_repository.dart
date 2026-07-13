import 'models/work_schedule.dart';

abstract class WorkScheduleRepository {
  Future<void> saveWorkSchedule(WorkSchedule workSchedule);
  Future<WorkSchedule?> getCurrentActiveSchedule();
  bool isWorkingDay(DateTime dateTime);
}
