import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/attendance/attendance_entity.dart';
import '../database/objectbox.g.dart';
import '../database/work_schedule/work_schedule_entity.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @preResolve
  @singleton
  Future<Store> get store => openStore();

  @singleton
  Box<WorkScheduleEntity> workScheduleBox(Store store) =>
      store.box<WorkScheduleEntity>();

  @singleton
  Box<AttendanceEntity> attendanceBox(Store store) =>
      store.box<AttendanceEntity>();
}
