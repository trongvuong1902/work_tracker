import 'package:flutter_test/flutter_test.dart';
import 'package:work_tracker/app/cubit/app_cubit.dart';
import 'package:work_tracker/domain/repository/app_repository.dart';
import 'package:work_tracker/features/schedule/domain/models/work_schedule.dart';
import 'package:work_tracker/features/schedule/domain/work_schedule_constants.dart';
import 'package:work_tracker/features/schedule/domain/work_schedule_repository.dart';

/// Minimal hand-written fakes. No mocktail/bloc_test dependency is present
/// in pubspec.yaml yet; these interfaces are small enough that fakes are
/// straightforward here.
class FakeAppRepository implements AppRepository {
  FakeAppRepository({this.isOnboardingCompleted = false});

  @override
  bool isOnboardingCompleted;

  int completeOnboardingCallCount = 0;

  @override
  Future<void> completeOnboarding() async {
    completeOnboardingCallCount++;
    isOnboardingCompleted = true;
  }
}

class FakeWorkScheduleRepository implements WorkScheduleRepository {
  FakeWorkScheduleRepository({this.schedule});

  WorkSchedule? schedule;

  @override
  Future<WorkSchedule?> getCurrentActiveSchedule() async => schedule;

  @override
  Future<void> saveWorkSchedule(WorkSchedule workSchedule) async {
    schedule = workSchedule;
  }

  @override
  bool isWorkingDay(DateTime dateTime) {
    final mask = schedule?.workingDaysMask ?? kDefaultWorkingDaysMask;
    final weekday = dateTime.weekday;
    return (mask & (1 << (weekday - 1))) != 0;
  }
}

// Note: AppCubit._initialize() begins running synchronously inside the
// constructor (Dart async functions run synchronously up to their first
// `await`). When `isOnboardingCompleted` is false, the emit happens with
// no prior `await`, so it can complete before test code has a chance to
// subscribe via `cubit.stream.first` -- that would then hang waiting for
// an emission that already happened. We flush pending microtasks with a
// zero-duration delay and read `cubit.state` directly instead, which is
// robust regardless of how many (if any) async gaps preceded the emit.
Future<void> flushMicrotasks() => Future<void>.delayed(Duration.zero);

void main() {
  group('AppCubit._initialize', () {
    test('onboarding incomplete -> AppStatus.onboarding', () async {
      final appRepo = FakeAppRepository(isOnboardingCompleted: false);
      final scheduleRepo = FakeWorkScheduleRepository();
      final cubit = AppCubit(appRepo, scheduleRepo);

      await flushMicrotasks();

      expect(cubit.state.status, AppStatus.onboarding);
      await cubit.close();
    });

    test('onboarding complete, no schedule -> AppStatus.setupSchedule', () async {
      final appRepo = FakeAppRepository(isOnboardingCompleted: true);
      final scheduleRepo = FakeWorkScheduleRepository();
      final cubit = AppCubit(appRepo, scheduleRepo);

      await flushMicrotasks();

      expect(cubit.state.status, AppStatus.setupSchedule);
      await cubit.close();
    });

    test('onboarding complete, schedule exists -> AppStatus.ready', () async {
      final appRepo = FakeAppRepository(isOnboardingCompleted: true);
      final scheduleRepo = FakeWorkScheduleRepository(
        schedule: const WorkSchedule(
          startMinuteOfDay: 540,
          endMinuteOfDay: 1080,
          lunchMinutes: 60,
          reminderMinutes: 0,
        ),
      );
      final cubit = AppCubit(appRepo, scheduleRepo);

      await flushMicrotasks();

      expect(cubit.state.status, AppStatus.ready);
      await cubit.close();
    });
  });

  group('AppCubit.completeOnboarding', () {
    test('marks onboarding complete then routes based on schedule presence', () async {
      final appRepo = FakeAppRepository(isOnboardingCompleted: false);
      final scheduleRepo = FakeWorkScheduleRepository();
      final cubit = AppCubit(appRepo, scheduleRepo);

      await flushMicrotasks();
      expect(cubit.state.status, AppStatus.onboarding);

      await cubit.completeOnboarding();

      expect(appRepo.completeOnboardingCallCount, 1);
      expect(cubit.state.status, AppStatus.setupSchedule);

      await cubit.close();
    });
  });

  group('AppCubit.onScheduleSaved', () {
    test('transitions status to ready', () async {
      final appRepo = FakeAppRepository(isOnboardingCompleted: true);
      final scheduleRepo = FakeWorkScheduleRepository();
      final cubit = AppCubit(appRepo, scheduleRepo);

      await flushMicrotasks();
      expect(cubit.state.status, AppStatus.setupSchedule);

      cubit.onScheduleSaved();

      expect(cubit.state.status, AppStatus.ready);
      await cubit.close();
    });
  });

  group('AppCubit.skipScheduleSetup', () {
    test('transitions status to ready even though no schedule was saved', () async {
      final appRepo = FakeAppRepository(isOnboardingCompleted: true);
      final scheduleRepo = FakeWorkScheduleRepository();
      final cubit = AppCubit(appRepo, scheduleRepo);

      await flushMicrotasks();
      expect(cubit.state.status, AppStatus.setupSchedule);

      cubit.skipScheduleSetup();

      expect(cubit.state.status, AppStatus.ready);
      // Documents current behavior: status becomes "ready" unconditionally,
      // with no schedule ever persisted (scheduleRepo.schedule is still null).
      expect(await scheduleRepo.getCurrentActiveSchedule(), isNull);

      await cubit.close();
    });
  });
}
