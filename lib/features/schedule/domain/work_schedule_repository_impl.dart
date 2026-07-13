import 'package:injectable/injectable.dart';

import '../../../database/work_schedule/work_schedule_entity.dart';
import '../data/work_schedule_dao.dart';
import 'models/work_schedule.dart';
import 'work_schedule_constants.dart';
import 'work_schedule_repository.dart';

@LazySingleton(as: WorkScheduleRepository)
class WorkScheduleRepositoryImpl implements WorkScheduleRepository {
  final WorkScheduleDao _dao;

  WorkScheduleRepositoryImpl(this._dao);

  @override
  Future<void> saveWorkSchedule(WorkSchedule workSchedule) async {
    _dao.save(_toEntity(workSchedule));
  }

  @override
  Future<WorkSchedule?> getCurrentActiveSchedule() async {
    final entity = _dao.get();
    return entity == null ? null : _toModel(entity);
  }

  @override
  bool isWorkingDay(DateTime dateTime) {
    final mask = _dao.get()?.workingDaysMask ?? kDefaultWorkingDaysMask;
    final weekDay = dateTime.weekday; // 1 (Monday) to 7 (Sunday)
    return (mask & (1 << (weekDay - 1))) != 0;
  }

  WorkScheduleEntity _toEntity(WorkSchedule model) => WorkScheduleEntity(
        startMinute: model.startMinuteOfDay,
        endMinute: model.endMinuteOfDay,
        lunchMinutes: model.lunchMinutes,
        reminderMinutes: model.reminderMinutes,
        workingDaysMask: model.workingDaysMask ?? kDefaultWorkingDaysMask,
      );

  WorkSchedule _toModel(WorkScheduleEntity entity) => WorkSchedule(
        startMinuteOfDay: entity.startMinute,
        endMinuteOfDay: entity.endMinute,
        lunchMinutes: entity.lunchMinutes,
        reminderMinutes: entity.reminderMinutes,
        workingDaysMask: entity.workingDaysMask,
      );
}
