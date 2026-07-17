import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_webservice/distance.dart';
import 'package:injectable/injectable.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart'
    show defaultStoreDirectory;
import 'package:shared_preferences/shared_preferences.dart';

import '../database/attendance/attendance_entity.dart';
import '../database/checkout_reminder/checkout_reminder_settings_entity.dart';
import '../database/leave_reminder/commute_sample_entity.dart';
import '../database/leave_reminder/leave_reminder_settings_entity.dart';
import '../database/leave_reminder/notification_log_entity.dart';
import '../database/location_log/location_log_entity.dart';
import '../database/location_log/location_log_settings_entity.dart';
import '../database/objectbox.g.dart';
import '../database/task/task_entity.dart';
import '../database/work_schedule/work_schedule_entity.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  // The leave reminder feature's Workmanager background isolate also calls
  // configureDependencies(), independently, in the same OS process. ObjectBox
  // only allows one native Store open per directory per process, so attach to
  // it instead of opening a second one whenever one is already open.
  @preResolve
  @singleton
  Future<Store> get store async {
    final directory = (await defaultStoreDirectory()).path;
    return Store.isOpen(directory)
        ? Store.attach(getObjectBoxModel(), directory)
        : await openStore(directory: directory);
  }

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
  Box<CommuteSampleEntity> commuteSampleBox(Store store) =>
      store.box<CommuteSampleEntity>();

  @singleton
  Box<NotificationLogEntity> notificationLogBox(Store store) =>
      store.box<NotificationLogEntity>();

  @singleton
  Box<CheckoutReminderSettingsEntity> checkoutReminderBox(Store store) =>
      store.box<CheckoutReminderSettingsEntity>();

  @singleton
  Box<LocationLogEntity> locationLogBox(Store store) =>
      store.box<LocationLogEntity>();

  @singleton
  Box<LocationLogSettingsEntity> locationLogSettingsBox(Store store) =>
      store.box<LocationLogSettingsEntity>();

  @singleton
  Box<TaskEntity> taskBox(Store store) => store.box<TaskEntity>();

  @lazySingleton
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin() =>
      FlutterLocalNotificationsPlugin();

  // First feature in the app that persists a raw password locally (the
  // Zentao connect form) — needs actual encryption, unlike the unencrypted
  // SharedPreferences used everywhere else.
  @lazySingleton
  FlutterSecureStorage flutterSecureStorage() => const FlutterSecureStorage();

  // Requires a Google Cloud API key with the Distance Matrix API enabled,
  // provided at build time via --dart-define=GOOGLE_MAPS_API_KEY=... — never
  // hardcode a real key in source.
  @lazySingleton
  GoogleDistanceMatrix distanceMatrixClient() => GoogleDistanceMatrix(
    apiKey: const String.fromEnvironment('GOOGLE_MAPS_API_KEY'),
  );
}
