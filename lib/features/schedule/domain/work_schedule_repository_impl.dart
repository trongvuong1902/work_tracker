import 'package:injectable/injectable.dart';
import 'package:work_tracker/features/schedule/data/work_schedule_datasource.dart';
import 'models/work_schedule.dart';
import 'work_schedule_repository.dart';

@LazySingleton(as: WorkScheduleRepository)
class WorkScheduleRepositoryImpl implements WorkScheduleRepository {
  final WorkScheduleDatasource dataSource;

  WorkScheduleRepositoryImpl(this.dataSource);

  @override
  Future<void> saveWorkSchedule(WorkSchedule workSchedule) async {
    await dataSource.saveWorkSchedule(workSchedule);
  }

  @override
  Future<WorkSchedule?> getCurrentActiveSchedule() async {
    try {
      return await dataSource.getSchedule();
    } catch (e) {
      return null;
    }
  }

  @override
  bool isWorkingDay(DateTime dateTime) {
    final mask = dataSource.workingDaysMask;
    final weekDay = dateTime.weekday; // 1 (Monday) to 7 (Sunday)
    return (mask & (1 << (weekDay - 1))) != 0;
  }
}
