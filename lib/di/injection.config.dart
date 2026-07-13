// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:objectbox/objectbox.dart' as _i1034;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:work_tracker/app/cubit/app_cubit.dart' as _i108;
import 'package:work_tracker/database/attendance/attendance_entity.dart'
    as _i602;
import 'package:work_tracker/database/objectbox.g.dart' as _i625;
import 'package:work_tracker/database/work_schedule/work_schedule_entity.dart'
    as _i911;
import 'package:work_tracker/di/register_module.dart' as _i61;
import 'package:work_tracker/domain/repository/app_repository.dart' as _i204;
import 'package:work_tracker/domain/repository/app_repository_impl.dart'
    as _i927;
import 'package:work_tracker/features/attendance/data/attendance_dao.dart'
    as _i616;
import 'package:work_tracker/features/attendance/domain/attendance_repository.dart'
    as _i331;
import 'package:work_tracker/features/attendance/domain/attendance_repository_impl.dart'
    as _i284;
import 'package:work_tracker/features/home/presentation/cubit/home_page_cubit.dart'
    as _i594;
import 'package:work_tracker/features/schedule/data/work_schedule_dao.dart'
    as _i196;
import 'package:work_tracker/features/schedule/domain/work_schedule_repository.dart'
    as _i513;
import 'package:work_tracker/features/schedule/domain/work_schedule_repository_impl.dart'
    as _i625;
import 'package:work_tracker/features/schedule/presentation/cubit/setting_schedule_cubit.dart'
    as _i542;

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
    gh.lazySingleton<_i204.AppRepository>(
      () => _i927.AppRepositoryImpl(
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.singleton<_i625.Box<_i911.WorkScheduleEntity>>(
      () => registerModule.workScheduleBox(gh<_i625.Store>()),
    );
    gh.singleton<_i625.Box<_i602.AttendanceEntity>>(
      () => registerModule.attendanceBox(gh<_i625.Store>()),
    );
    gh.lazySingleton<_i616.AttendanceDao>(
      () => _i616.AttendanceDaoImpl(gh<_i625.Box<_i602.AttendanceEntity>>()),
    );
    gh.lazySingleton<_i196.WorkScheduleDao>(
      () =>
          _i196.WorkScheduleDaoImpl(gh<_i1034.Box<_i911.WorkScheduleEntity>>()),
    );
    gh.lazySingleton<_i513.WorkScheduleRepository>(
      () => _i625.WorkScheduleRepositoryImpl(gh<_i196.WorkScheduleDao>()),
    );
    gh.singleton<_i108.AppCubit>(
      () => _i108.AppCubit(
        gh<_i204.AppRepository>(),
        gh<_i513.WorkScheduleRepository>(),
      ),
    );
    gh.factory<_i542.SettingScheduleCubit>(
      () => _i542.SettingScheduleCubit(gh<_i513.WorkScheduleRepository>()),
    );
    gh.lazySingleton<_i331.AttendanceRepository>(
      () => _i284.AttendanceRepositoryImpl(
        gh<_i616.AttendanceDao>(),
        gh<_i513.WorkScheduleRepository>(),
      ),
    );
    gh.factory<_i594.HomePageCubit>(
      () => _i594.HomePageCubit(
        workScheduleRepository: gh<_i513.WorkScheduleRepository>(),
        attendanceRepository: gh<_i331.AttendanceRepository>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i61.RegisterModule {}
