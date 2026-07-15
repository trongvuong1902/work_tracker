import 'package:flutter_test/flutter_test.dart';
import 'package:work_tracker/features/schedule/domain/models/work_schedule.dart';
import 'package:work_tracker/features/schedule/domain/work_schedule_constants.dart';
import 'package:work_tracker/features/schedule/domain/work_schedule_repository.dart';
import 'package:work_tracker/features/schedule/presentation/cubit/setting_schedule_cubit.dart';

/// Minimal hand-written fake. No mocktail/bloc_test dependency is present in
/// pubspec.yaml yet, and this repository interface is small enough that a
/// fake is straightforward and does not require adding a new dependency.
class FakeWorkScheduleRepository implements WorkScheduleRepository {
  FakeWorkScheduleRepository({this.schedule});

  WorkSchedule? schedule;
  WorkSchedule? lastSaved;
  int saveCallCount = 0;

  @override
  Future<WorkSchedule?> getCurrentActiveSchedule() async => schedule;

  @override
  Future<void> saveWorkSchedule(WorkSchedule workSchedule) async {
    saveCallCount++;
    lastSaved = workSchedule;
    schedule = workSchedule;
  }

  @override
  bool isWorkingDay(DateTime dateTime) {
    final mask = schedule?.workingDaysMask ?? kDefaultWorkingDaysMask;
    final weekday = dateTime.weekday;
    return (mask & (1 << (weekday - 1))) != 0;
  }
}

void main() {
  group('SettingScheduleCubit._loadExisting', () {
    test('with no saved schedule, keeps defaults and isEditing=false', () async {
      final repo = FakeWorkScheduleRepository();
      final cubit = SettingScheduleCubit(repo);

      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.isEditing, isFalse);
      expect(cubit.state.startMinuteOfDay, 540);
      expect(cubit.state.endMinuteOfDay, 1080);
      expect(cubit.state.workingDaysMask, kDefaultWorkingDaysMask);

      await cubit.close();
    });

    test('with a saved schedule, hydrates state and sets isEditing=true', () async {
      final existing = const WorkSchedule(
        startMinuteOfDay: 480,
        endMinuteOfDay: 1020,
        lunchMinutes: 45,
        lunchStartMinuteOfDay: 720,
        reminderMinutes: 10,
        workingDaysMask: 0x7F,
      );
      final repo = FakeWorkScheduleRepository(schedule: existing);
      final cubit = SettingScheduleCubit(repo);

      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.isEditing, isTrue);
      expect(cubit.state.startMinuteOfDay, 480);
      expect(cubit.state.endMinuteOfDay, 1020);
      expect(cubit.state.lunchMinutes, 45);
      expect(cubit.state.reminderMinutes, 10);
      expect(cubit.state.workingDaysMask, 0x7F);

      await cubit.close();
    });

    test('with a saved schedule whose workingDaysMask is null, falls back to default mask', () async {
      final existing = const WorkSchedule(
        startMinuteOfDay: 480,
        endMinuteOfDay: 1020,
        lunchMinutes: 45,
        lunchStartMinuteOfDay: 720,
        reminderMinutes: 10,
      );
      final repo = FakeWorkScheduleRepository(schedule: existing);
      final cubit = SettingScheduleCubit(repo);

      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.workingDaysMask, kDefaultWorkingDaysMask);

      await cubit.close();
    });
  });

  group('SettingScheduleCubit.updateLunchMinutes', () {
    test('clamps below 0 to 0', () async {
      final repo = FakeWorkScheduleRepository();
      final cubit = SettingScheduleCubit(repo);
      await Future<void>.delayed(Duration.zero);

      cubit.updateLunchMinutes(-15);

      expect(cubit.state.lunchMinutes, 0);
      await cubit.close();
    });

    test('clamps above 180 to 180', () async {
      final repo = FakeWorkScheduleRepository();
      final cubit = SettingScheduleCubit(repo);
      await Future<void>.delayed(Duration.zero);

      cubit.updateLunchMinutes(195);

      expect(cubit.state.lunchMinutes, 180);
      await cubit.close();
    });
  });

  group('SettingScheduleCubit.toggleWorkingDay', () {
    test('flips the bit for the given weekday', () async {
      final repo = FakeWorkScheduleRepository();
      final cubit = SettingScheduleCubit(repo);
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.workingDaysMask, kDefaultWorkingDaysMask); // Mon-Fri

      cubit.toggleWorkingDay(1); // Monday off
      expect(cubit.state.workingDaysMask & 1, 0);

      cubit.toggleWorkingDay(1); // Monday back on
      expect(cubit.state.workingDaysMask, kDefaultWorkingDaysMask);

      await cubit.close();
    });

    test('allows deselecting all 7 days, producing a mask of 0', () async {
      final repo = FakeWorkScheduleRepository();
      final cubit = SettingScheduleCubit(repo);
      await Future<void>.delayed(Duration.zero);

      // toggleWorkingDay flips whichever bit is currently set for that
      // weekday; tapping every one of the 7 day-chips (as a user naively
      // "deselecting all" would) only turns OFF the currently-selected
      // days and turns ON the currently-unselected ones (i.e. it inverts
      // the selection, ending up with a weekend-only mask here) rather
      // than zeroing it out. To reach an all-off mask, only the
      // currently-selected days need to be tapped.
      for (var weekday = 1; weekday <= 7; weekday++) {
        final bit = 1 << (weekday - 1);
        if (cubit.state.workingDaysMask & bit != 0) {
          cubit.toggleWorkingDay(weekday);
        }
      }

      // Documents current (unvalidated) behavior: an all-days-off mask is
      // reachable through the UI and is not rejected anywhere in this cubit.
      expect(cubit.state.workingDaysMask, 0);

      await cubit.close();
    });
  });

  group('SettingScheduleCubit.save', () {
    test('rejects endMinuteOfDay == startMinuteOfDay with an error and does not persist', () async {
      final repo = FakeWorkScheduleRepository();
      final cubit = SettingScheduleCubit(repo);
      await Future<void>.delayed(Duration.zero);

      cubit.updateStartMinute(540);
      cubit.updateEndMinute(540);

      final result = await cubit.save();

      expect(result, isFalse);
      expect(cubit.state.errorMessage, 'End time must be after start time');
      expect(cubit.state.isSaving, isFalse);
      expect(repo.saveCallCount, 0);

      await cubit.close();
    });

    test('rejects endMinuteOfDay < startMinuteOfDay with an error and does not persist', () async {
      final repo = FakeWorkScheduleRepository();
      final cubit = SettingScheduleCubit(repo);
      await Future<void>.delayed(Duration.zero);

      cubit.updateStartMinute(600);
      cubit.updateEndMinute(300);

      final result = await cubit.save();

      expect(result, isFalse);
      expect(cubit.state.errorMessage, isNotNull);
      expect(repo.saveCallCount, 0);

      await cubit.close();
    });

    test('persists and returns true when endMinuteOfDay > startMinuteOfDay', () async {
      final repo = FakeWorkScheduleRepository();
      final cubit = SettingScheduleCubit(repo);
      await Future<void>.delayed(Duration.zero);

      cubit.updateStartMinute(540);
      cubit.updateEndMinute(1080);
      cubit.updateLunchMinutes(30);

      final result = await cubit.save();

      expect(result, isTrue);
      expect(cubit.state.isSaving, isFalse);
      expect(cubit.state.errorMessage, isNull);
      expect(repo.saveCallCount, 1);
      expect(repo.lastSaved?.startMinuteOfDay, 540);
      expect(repo.lastSaved?.endMinuteOfDay, 1080);
      expect(repo.lastSaved?.lunchMinutes, 30);

      await cubit.close();
    });

    test('an all-zero workingDaysMask is currently accepted by save() with no validation', () async {
      final repo = FakeWorkScheduleRepository();
      final cubit = SettingScheduleCubit(repo);
      await Future<void>.delayed(Duration.zero);

      for (var weekday = 1; weekday <= 7; weekday++) {
        final bit = 1 << (weekday - 1);
        if (cubit.state.workingDaysMask & bit != 0) {
          cubit.toggleWorkingDay(weekday);
        }
      }
      expect(cubit.state.workingDaysMask, 0);

      final result = await cubit.save();

      // This documents a real gap: save() has no check preventing a
      // schedule where the user is never a "working day".
      expect(result, isTrue);
      expect(repo.lastSaved?.workingDaysMask, 0);

      await cubit.close();
    });
  });
}
