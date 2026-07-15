import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_webservice/distance.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/attendance/attendance_entity.dart';
import '../database/checkout_reminder/checkout_reminder_settings_entity.dart';
import '../database/leave_reminder/leave_reminder_settings_entity.dart';
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

  @singleton
  Box<LeaveReminderSettingsEntity> leaveReminderBox(Store store) =>
      store.box<LeaveReminderSettingsEntity>();

  @singleton
  Box<CheckoutReminderSettingsEntity> checkoutReminderBox(Store store) =>
      store.box<CheckoutReminderSettingsEntity>();

  @lazySingleton
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin() =>
      FlutterLocalNotificationsPlugin();

  // Requires a Google Cloud API key with the Distance Matrix API enabled,
  // provided at build time via --dart-define=GOOGLE_MAPS_API_KEY=... — never
  // hardcode a real key in source.
  @lazySingleton
  GoogleDistanceMatrix distanceMatrixClient() => GoogleDistanceMatrix(
    apiKey: const String.fromEnvironment('GOOGLE_MAPS_API_KEY'),
  );
}
