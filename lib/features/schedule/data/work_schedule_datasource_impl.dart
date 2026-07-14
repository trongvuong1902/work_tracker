import 'package:injectable/injectable.dart';
import 'package:work_tracker/database/work_schedule/work_schedule_entity.dart';
import 'package:work_tracker/features/schedule/data/work_schedule_dao.dart';
import 'package:work_tracker/features/schedule/data/work_schedule_datasource.dart';
import 'package:work_tracker/features/schedule/domain/models/work_schedule.dart';

@LazySingleton(as: WorkScheduleDatasource)
class WorkScheduleDatasourceImpl implements WorkScheduleDatasource {
  final WorkScheduleDao _workScheduleDao;
  WorkScheduleDatasourceImpl(this._workScheduleDao);

  @override
  Future<WorkSchedule> getSchedule() async {
    final schedule = _workScheduleDao.get();
    if (schedule == null) {
      throw Exception('No active WorkSchedule found');
    }
    return _toModel(schedule);
  }

  WorkSchedule _toModel(WorkScheduleEntity entity) => WorkSchedule(
    startMinuteOfDay: entity.startMinute,
    endMinuteOfDay: entity.endMinute,
    lunchMinutes: entity.lunchMinutes,
    reminderMinutes: entity.reminderMinutes,
    workingDaysMask: entity.workingDaysMask,
  );

  @override
  Future<void> saveWorkSchedule(WorkSchedule workSchedule) async {
    return _workScheduleDao.save(toEntity(workSchedule));
  }

  WorkScheduleEntity toEntity(WorkSchedule workSchedule) => WorkScheduleEntity(
    startMinute: workSchedule.startMinuteOfDay,
    endMinute: workSchedule.endMinuteOfDay,
    lunchMinutes: workSchedule.lunchMinutes,
    reminderMinutes: workSchedule.reminderMinutes,
    workingDaysMask: workSchedule.workingDaysMask ?? 0,
  );

  @override
  int get workingDaysMask => _workScheduleDao.get()?.workingDaysMask ?? 0;
}
