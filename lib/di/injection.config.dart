// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as _i163;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_maps_webservice/distance.dart' as _i557;
import 'package:injectable/injectable.dart' as _i526;
import 'package:objectbox/objectbox.dart' as _i1034;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:work_tracker/app/cubit/app_cubit.dart' as _i108;
import 'package:work_tracker/core/notifications/notification_service.dart'
    as _i43;
import 'package:work_tracker/core/notifications/notification_service_impl.dart'
    as _i807;
import 'package:work_tracker/database/attendance/attendance_entity.dart'
    as _i602;
import 'package:work_tracker/database/checkout_reminder/checkout_reminder_settings_entity.dart'
    as _i337;
import 'package:work_tracker/database/leave_reminder/commute_sample_entity.dart'
    as _i793;
import 'package:work_tracker/database/leave_reminder/leave_reminder_settings_entity.dart'
    as _i1017;
import 'package:work_tracker/database/leave_reminder/notification_log_entity.dart'
    as _i329;
import 'package:work_tracker/database/location_log/location_log_entity.dart'
    as _i253;
import 'package:work_tracker/database/location_log/location_log_settings_entity.dart'
    as _i624;
import 'package:work_tracker/database/objectbox.g.dart' as _i625;
import 'package:work_tracker/database/task/task_entity.dart' as _i911;
import 'package:work_tracker/database/work_schedule/work_schedule_entity.dart'
    as _i911;
import 'package:work_tracker/di/register_module.dart' as _i61;
import 'package:work_tracker/domain/repository/app_repository.dart' as _i204;
import 'package:work_tracker/domain/repository/app_repository_impl.dart'
    as _i927;
import 'package:work_tracker/features/ai_assist/data/ai_client.dart' as _i692;
import 'package:work_tracker/features/ai_assist/domain/ai_repository.dart'
    as _i913;
import 'package:work_tracker/features/ai_assist/presentation/cubit/bug_ai_cubit.dart'
    as _i167;
import 'package:work_tracker/features/attendance/data/attendance_dao.dart'
    as _i616;
import 'package:work_tracker/features/attendance/domain/attendance_repository.dart'
    as _i331;
import 'package:work_tracker/features/attendance/domain/attendance_repository_impl.dart'
    as _i284;
import 'package:work_tracker/features/calendar/presentation/cubit/calendar_cubit.dart'
    as _i474;
import 'package:work_tracker/features/checkout_reminder/data/checkout_reminder_dao.dart'
    as _i226;
import 'package:work_tracker/features/checkout_reminder/data/checkout_reminder_datasource.dart'
    as _i654;
import 'package:work_tracker/features/checkout_reminder/data/checkout_reminder_datasource_impl.dart'
    as _i900;
import 'package:work_tracker/features/checkout_reminder/domain/checkout_reminder_repository.dart'
    as _i530;
import 'package:work_tracker/features/checkout_reminder/domain/checkout_reminder_repository_impl.dart'
    as _i308;
import 'package:work_tracker/features/checkout_reminder/presentation/cubit/checkout_reminder_setup_cubit.dart'
    as _i757;
import 'package:work_tracker/features/home/presentation/cubit/home_page_cubit.dart'
    as _i594;
import 'package:work_tracker/features/home/presentation/widgets/attendance_card/cubit/attendace_card_cubit.dart'
    as _i726;
import 'package:work_tracker/features/home/presentation/widgets/hero_card/cubit/hero_card_cubit.dart'
    as _i629;
import 'package:work_tracker/features/home/presentation/widgets/today_activity_timeline/cubit/today_activity_timeline_cubit.dart'
    as _i524;
import 'package:work_tracker/features/home/presentation/widgets/tomorrow_preview/cubit/tomorrow_preview_cubit.dart'
    as _i299;
import 'package:work_tracker/features/leave_reminder/data/commute_routing_client.dart'
    as _i925;
import 'package:work_tracker/features/leave_reminder/data/commute_sample_dao.dart'
    as _i150;
import 'package:work_tracker/features/leave_reminder/data/leave_reminder_dao.dart'
    as _i591;
import 'package:work_tracker/features/leave_reminder/data/leave_reminder_datasource.dart'
    as _i707;
import 'package:work_tracker/features/leave_reminder/data/leave_reminder_datasource_impl.dart'
    as _i14;
import 'package:work_tracker/features/leave_reminder/data/location_source.dart'
    as _i343;
import 'package:work_tracker/features/leave_reminder/data/notification_log_dao.dart'
    as _i814;
import 'package:work_tracker/features/leave_reminder/data/places_client.dart'
    as _i509;
import 'package:work_tracker/features/leave_reminder/data/reverse_geocoding_client.dart'
    as _i883;
import 'package:work_tracker/features/leave_reminder/data/weather_client.dart'
    as _i1043;
import 'package:work_tracker/features/leave_reminder/domain/leave_reminder_repository.dart'
    as _i468;
import 'package:work_tracker/features/leave_reminder/domain/leave_reminder_repository_impl.dart'
    as _i347;
import 'package:work_tracker/features/leave_reminder/presentation/cubit/leave_reminder_setup_cubit.dart'
    as _i262;
import 'package:work_tracker/features/location_log/data/location_log_dao.dart'
    as _i307;
import 'package:work_tracker/features/location_log/data/location_log_settings_dao.dart'
    as _i635;
import 'package:work_tracker/features/location_log/data/location_log_settings_datasource.dart'
    as _i697;
import 'package:work_tracker/features/location_log/data/location_log_settings_datasource_impl.dart'
    as _i552;
import 'package:work_tracker/features/location_log/data/location_watch_service.dart'
    as _i492;
import 'package:work_tracker/features/location_log/domain/location_log_repository.dart'
    as _i771;
import 'package:work_tracker/features/location_log/domain/location_log_repository_impl.dart'
    as _i339;
import 'package:work_tracker/features/location_log/domain/location_watch_orchestrator.dart'
    as _i1034;
import 'package:work_tracker/features/location_log/presentation/cubit/location_activity_cubit.dart'
    as _i571;
import 'package:work_tracker/features/location_log/presentation/cubit/location_activity_day_cubit.dart'
    as _i142;
import 'package:work_tracker/features/location_log/presentation/cubit/location_log_setup_cubit.dart'
    as _i488;
import 'package:work_tracker/features/schedule/data/work_schedule_dao.dart'
    as _i196;
import 'package:work_tracker/features/schedule/data/work_schedule_datasource.dart'
    as _i762;
import 'package:work_tracker/features/schedule/data/work_schedule_datasource_impl.dart'
    as _i339;
import 'package:work_tracker/features/schedule/domain/work_schedule_repository.dart'
    as _i513;
import 'package:work_tracker/features/schedule/domain/work_schedule_repository_impl.dart'
    as _i625;
import 'package:work_tracker/features/schedule/presentation/cubit/setting_schedule_cubit.dart'
    as _i542;
import 'package:work_tracker/features/task/data/task_dao.dart' as _i344;
import 'package:work_tracker/features/task/domain/task_repository.dart'
    as _i1026;
import 'package:work_tracker/features/task/domain/task_repository_impl.dart'
    as _i383;
import 'package:work_tracker/features/task/presentation/cubit/bug_sync_cubit.dart'
    as _i987;
import 'package:work_tracker/features/task/presentation/cubit/bug_sync_products_cubit.dart'
    as _i970;
import 'package:work_tracker/features/task/presentation/cubit/task_detail_cubit.dart'
    as _i629;
import 'package:work_tracker/features/task/presentation/cubit/task_list_cubit.dart'
    as _i482;
import 'package:work_tracker/features/zentao/data/zentao_client.dart' as _i376;
import 'package:work_tracker/features/zentao/data/zentao_credentials_store.dart'
    as _i1;
import 'package:work_tracker/features/zentao/data/zentao_sync_prefs.dart'
    as _i522;
import 'package:work_tracker/features/zentao/domain/zentao_repository.dart'
    as _i298;
import 'package:work_tracker/features/zentao/domain/zentao_repository_impl.dart'
    as _i1023;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    await gh.singletonAsync<_i625.Store>(
      () => registerModule.store,
      preResolve: true,
    );
    gh.lazySingleton<_i163.FlutterLocalNotificationsPlugin>(
      () => registerModule.flutterLocalNotificationsPlugin(),
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.flutterSecureStorage(),
    );
    gh.lazySingleton<_i557.GoogleDistanceMatrix>(
      () => registerModule.distanceMatrixClient(),
    );
    gh.lazySingleton<_i343.LocationSource>(() => _i343.LocationSourceImpl());
    gh.lazySingleton<_i376.ZentaoClient>(() => _i376.ZentaoRestClient());
    gh.lazySingleton<_i692.AiClient>(() => _i692.OpenAiCompatibleAiClient());
    gh.lazySingleton<_i1.ZentaoCredentialsStore>(
      () => _i1.ZentaoCredentialsStore(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i509.PlacesClient>(() => _i509.GooglePlacesClient());
    gh.lazySingleton<_i492.LocationWatchService>(
      () => _i492.LocationWatchServiceImpl(),
    );
    gh.lazySingleton<_i883.ReverseGeocodingClient>(
      () => _i883.GoogleReverseGeocodingClient(),
    );
    gh.lazySingleton<_i1043.WeatherClient>(
      () => _i1043.OpenMeteoWeatherClient(),
    );
    gh.lazySingleton<_i204.AppRepository>(
      () => _i927.AppRepositoryImpl(
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i925.CommuteRoutingClient>(
      () => _i925.GoogleDistanceMatrixRoutingClient(
        gh<_i557.GoogleDistanceMatrix>(),
      ),
    );
    gh.lazySingleton<_i522.ZentaoSyncPrefs>(
      () => _i522.ZentaoSyncPrefs(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i43.NotificationService>(
      () => _i807.NotificationServiceImpl(
        gh<_i163.FlutterLocalNotificationsPlugin>(),
      ),
    );
    gh.lazySingleton<_i298.ZentaoRepository>(
      () => _i1023.ZentaoRepositoryImpl(
        gh<_i376.ZentaoClient>(),
        gh<_i1.ZentaoCredentialsStore>(),
      ),
    );
    gh.singleton<_i625.Box<_i911.WorkScheduleEntity>>(
      () => registerModule.workScheduleBox(gh<_i625.Store>()),
    );
    gh.singleton<_i625.Box<_i602.AttendanceEntity>>(
      () => registerModule.attendanceBox(gh<_i625.Store>()),
    );
    gh.singleton<_i625.Box<_i1017.LeaveReminderSettingsEntity>>(
      () => registerModule.leaveReminderBox(gh<_i625.Store>()),
    );
    gh.singleton<_i625.Box<_i793.CommuteSampleEntity>>(
      () => registerModule.commuteSampleBox(gh<_i625.Store>()),
    );
    gh.singleton<_i625.Box<_i329.NotificationLogEntity>>(
      () => registerModule.notificationLogBox(gh<_i625.Store>()),
    );
    gh.singleton<_i625.Box<_i337.CheckoutReminderSettingsEntity>>(
      () => registerModule.checkoutReminderBox(gh<_i625.Store>()),
    );
    gh.singleton<_i625.Box<_i253.LocationLogEntity>>(
      () => registerModule.locationLogBox(gh<_i625.Store>()),
    );
    gh.singleton<_i625.Box<_i624.LocationLogSettingsEntity>>(
      () => registerModule.locationLogSettingsBox(gh<_i625.Store>()),
    );
    gh.singleton<_i625.Box<_i911.TaskEntity>>(
      () => registerModule.taskBox(gh<_i625.Store>()),
    );
    gh.lazySingleton<_i616.AttendanceDao>(
      () => _i616.AttendanceDaoImpl(gh<_i625.Box<_i602.AttendanceEntity>>()),
    );
    gh.factory<_i970.BugSyncProductsCubit>(
      () => _i970.BugSyncProductsCubit(
        gh<_i298.ZentaoRepository>(),
        gh<_i522.ZentaoSyncPrefs>(),
      ),
    );
    gh.lazySingleton<_i913.AiRepository>(
      () => _i913.AiRepositoryImpl(
        gh<_i692.AiClient>(),
        gh<_i298.ZentaoRepository>(),
      ),
    );
    gh.lazySingleton<_i150.CommuteSampleDao>(
      () => _i150.CommuteSampleDaoImpl(
        gh<_i625.Box<_i793.CommuteSampleEntity>>(),
      ),
    );
    gh.lazySingleton<_i344.TaskDao>(
      () => _i344.TaskDaoImpl(gh<_i625.Box<_i911.TaskEntity>>()),
    );
    gh.lazySingleton<_i635.LocationLogSettingsDao>(
      () => _i635.LocationLogSettingsDaoImpl(
        gh<_i1034.Box<_i624.LocationLogSettingsEntity>>(),
      ),
    );
    gh.lazySingleton<_i226.CheckoutReminderDao>(
      () => _i226.CheckoutReminderDaoImpl(
        gh<_i1034.Box<_i337.CheckoutReminderSettingsEntity>>(),
      ),
    );
    gh.lazySingleton<_i814.NotificationLogDao>(
      () => _i814.NotificationLogDaoImpl(
        gh<_i625.Box<_i329.NotificationLogEntity>>(),
      ),
    );
    gh.lazySingleton<_i307.LocationLogDao>(
      () => _i307.LocationLogDaoImpl(gh<_i625.Box<_i253.LocationLogEntity>>()),
    );
    gh.lazySingleton<_i591.LeaveReminderDao>(
      () => _i591.LeaveReminderDaoImpl(
        gh<_i1034.Box<_i1017.LeaveReminderSettingsEntity>>(),
      ),
    );
    gh.lazySingleton<_i196.WorkScheduleDao>(
      () =>
          _i196.WorkScheduleDaoImpl(gh<_i1034.Box<_i911.WorkScheduleEntity>>()),
    );
    gh.lazySingleton<_i762.WorkScheduleDatasource>(
      () => _i339.WorkScheduleDatasourceImpl(gh<_i196.WorkScheduleDao>()),
    );
    gh.lazySingleton<_i1026.TaskRepository>(
      () => _i383.TaskRepositoryImpl(
        gh<_i344.TaskDao>(),
        gh<_i298.ZentaoRepository>(),
      ),
    );
    gh.factory<_i167.BugAiCubit>(
      () => _i167.BugAiCubit(gh<_i913.AiRepository>()),
    );
    gh.lazySingleton<_i697.LocationLogSettingsDatasource>(
      () => _i552.LocationLogSettingsDatasourceImpl(
        gh<_i635.LocationLogSettingsDao>(),
      ),
    );
    gh.lazySingleton<_i331.AttendanceRepository>(
      () => _i284.AttendanceRepositoryImpl(
        gh<_i616.AttendanceDao>(),
        gh<_i196.WorkScheduleDao>(),
      ),
    );
    gh.lazySingleton<_i513.WorkScheduleRepository>(
      () =>
          _i625.WorkScheduleRepositoryImpl(gh<_i762.WorkScheduleDatasource>()),
    );
    gh.lazySingleton<_i654.CheckoutReminderDatasource>(
      () =>
          _i900.CheckoutReminderDatasourceImpl(gh<_i226.CheckoutReminderDao>()),
    );
    gh.factory<_i542.SettingScheduleCubit>(
      () => _i542.SettingScheduleCubit(gh<_i513.WorkScheduleRepository>()),
    );
    gh.lazySingleton<_i771.LocationLogRepository>(
      () => _i339.LocationLogRepositoryImpl(
        gh<_i307.LocationLogDao>(),
        gh<_i697.LocationLogSettingsDatasource>(),
        gh<_i43.NotificationService>(),
      ),
    );
    gh.factory<_i987.BugSyncCubit>(
      () => _i987.BugSyncCubit(
        gh<_i298.ZentaoRepository>(),
        gh<_i1026.TaskRepository>(),
        gh<_i522.ZentaoSyncPrefs>(),
      ),
    );
    gh.lazySingleton<_i707.LeaveReminderDatasource>(
      () => _i14.LeaveReminderDatasourceImpl(gh<_i591.LeaveReminderDao>()),
    );
    gh.factory<_i524.TodayActivityTimelineCubit>(
      () => _i524.TodayActivityTimelineCubit(
        locationLogRepository: gh<_i771.LocationLogRepository>(),
        attendanceRepository: gh<_i331.AttendanceRepository>(),
      ),
    );
    gh.factory<_i571.LocationActivityCubit>(
      () => _i571.LocationActivityCubit(
        gh<_i771.LocationLogRepository>(),
        gh<_i331.AttendanceRepository>(),
      ),
    );
    gh.factory<_i142.LocationActivityDayCubit>(
      () => _i142.LocationActivityDayCubit(
        gh<_i771.LocationLogRepository>(),
        gh<_i331.AttendanceRepository>(),
      ),
    );
    gh.factory<_i474.CalendarCubit>(
      () => _i474.CalendarCubit(
        gh<_i331.AttendanceRepository>(),
        gh<_i513.WorkScheduleRepository>(),
      ),
    );
    gh.factory<_i629.TaskDetailCubit>(
      () => _i629.TaskDetailCubit(gh<_i1026.TaskRepository>()),
    );
    gh.factory<_i482.TaskListCubit>(
      () => _i482.TaskListCubit(gh<_i1026.TaskRepository>()),
    );
    gh.singleton<_i108.AppCubit>(
      () => _i108.AppCubit(
        gh<_i204.AppRepository>(),
        gh<_i513.WorkScheduleRepository>(),
      ),
    );
    gh.lazySingleton<_i468.LeaveReminderRepository>(
      () => _i347.LeaveReminderRepositoryImpl(
        gh<_i707.LeaveReminderDatasource>(),
        gh<_i925.CommuteRoutingClient>(),
        gh<_i1043.WeatherClient>(),
        gh<_i43.NotificationService>(),
        gh<_i460.SharedPreferences>(),
        gh<_i513.WorkScheduleRepository>(),
        gh<_i331.AttendanceRepository>(),
        gh<_i150.CommuteSampleDao>(),
        gh<_i814.NotificationLogDao>(),
      ),
    );
    gh.singleton<_i1034.LocationWatchOrchestrator>(
      () => _i1034.LocationWatchOrchestrator(
        gh<_i492.LocationWatchService>(),
        gh<_i771.LocationLogRepository>(),
        gh<_i331.AttendanceRepository>(),
        gh<_i513.WorkScheduleRepository>(),
        gh<_i468.LeaveReminderRepository>(),
      ),
    );
    gh.factory<_i726.AttendaceCardCubit>(
      () => _i726.AttendaceCardCubit(
        attendanceRepository: gh<_i331.AttendanceRepository>(),
        workScheduleRepository: gh<_i513.WorkScheduleRepository>(),
      ),
    );
    gh.lazySingleton<_i530.CheckoutReminderRepository>(
      () => _i308.CheckoutReminderRepositoryImpl(
        gh<_i654.CheckoutReminderDatasource>(),
        gh<_i43.NotificationService>(),
        gh<_i331.AttendanceRepository>(),
      ),
    );
    gh.factory<_i757.CheckoutReminderSetupCubit>(
      () => _i757.CheckoutReminderSetupCubit(
        gh<_i530.CheckoutReminderRepository>(),
      ),
    );
    gh.factory<_i594.HomePageCubit>(
      () => _i594.HomePageCubit(
        workScheduleRepository: gh<_i513.WorkScheduleRepository>(),
        attendanceRepository: gh<_i331.AttendanceRepository>(),
        leaveReminderRepository: gh<_i468.LeaveReminderRepository>(),
      ),
    );
    gh.factory<_i262.LeaveReminderSetupCubit>(
      () => _i262.LeaveReminderSetupCubit(
        gh<_i468.LeaveReminderRepository>(),
        gh<_i513.WorkScheduleRepository>(),
      ),
    );
    gh.factory<_i488.LocationLogSetupCubit>(
      () => _i488.LocationLogSetupCubit(
        gh<_i771.LocationLogRepository>(),
        gh<_i468.LeaveReminderRepository>(),
        gh<_i1034.LocationWatchOrchestrator>(),
      ),
    );
    gh.factory<_i629.HeroCardCubit>(
      () => _i629.HeroCardCubit(
        attendanceRepository: gh<_i331.AttendanceRepository>(),
        leaveReminderRepository: gh<_i468.LeaveReminderRepository>(),
      ),
    );
    gh.factory<_i299.TomorrowPreviewCubit>(
      () => _i299.TomorrowPreviewCubit(
        attendanceRepository: gh<_i331.AttendanceRepository>(),
        leaveReminderRepository: gh<_i468.LeaveReminderRepository>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i61.RegisterModule {}
