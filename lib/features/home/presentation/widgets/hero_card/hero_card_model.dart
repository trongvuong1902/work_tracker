import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/leave_reminder_settings.dart';
import 'package:work_tracker/features/schedule/domain/models/work_schedule.dart';

part 'hero_card_model.freezed.dart';

/// How long before the computed leave-home time ([HeroCardModel.working]'s
/// `leaveAt`) the hero card switches from the working countdown to the
/// "approaching check-out" wrap-up state.
const int kApproachingCheckOutThresholdMinutes = 30;

/// Which message/CTA the pre-check-in [LeaveReminderCta] should show when no
/// leave-home time is available yet — resolved once by
/// [resolveLeaveReminderCtaKind] so the widget itself never branches on raw
/// settings/schedule data.
enum LeaveReminderCtaKind {
  /// No active work schedule — nothing to compute a leave time from.
  noActiveSchedule,

  /// Leave reminders are off, or home/work locations aren't both set.
  remindersDisabled,

  /// Reminders are on and home/work are set, but fewer than two commute
  /// samples have been recorded yet, so there's no average to leave from.
  learningCommute,

  /// Reminders are fully set up, but today isn't a scheduled working day.
  dayOff,
}

/// Picks the [LeaveReminderCtaKind] to show on the pre-check-in hero card when
/// [HeroCardModel.beforeCheckIn]'s `leaveHomeAt` is null, from the same inputs
/// [LeaveReminderRepository.getLeaveTime] itself checks. Returns null if none
/// of the known "why is there no leave time" conditions apply.
LeaveReminderCtaKind? resolveLeaveReminderCtaKind({
  required WorkSchedule? schedule,
  required bool isWorkingDay,
  required LeaveReminderSettings settings,
  required int? averageCommuteMinutes,
}) {
  if (schedule == null) return LeaveReminderCtaKind.noActiveSchedule;
  if (!settings.enabled || settings.home == null || settings.work == null) {
    return LeaveReminderCtaKind.remindersDisabled;
  }
  if (averageCommuteMinutes == null) {
    return LeaveReminderCtaKind.learningCommute;
  }
  if (!isWorkingDay) return LeaveReminderCtaKind.dayOff;
  return null;
}

@freezed
class HeroCardModel with _$HeroCardModel {
  const factory HeroCardModel.beforeCheckIn({
    DateTime? leaveHomeAt,
    DateTime? arriveAtWorkAt,
    LeaveReminderCtaKind? ctaKind,
  }) = _BeforeCheckIn;
  const factory HeroCardModel.working({
    required DateTime checkIn,
    required DateTime leaveAt,
    required DateTime breakStart,
    required DateTime breakEnd,
  }) = _Working;

  /// Within [kApproachingCheckOutThresholdMinutes] of the computed leave time
  /// (or past it), check-out not yet recorded — the hero shifts its focus
  /// from the working countdown to wrapping up the day.
  const factory HeroCardModel.approachingCheckOut({
    required DateTime checkIn,
    required DateTime scheduledEnd,
  }) = _ApproachingCheckOut;
  const factory HeroCardModel.afterCheckOut({required DateTime checkOutAt}) =
      _AfterCheckOut;

  static HeroCardModel? fromAttendance(Attendance attendance) {
    if (attendance.checkIn == null) {
      return const HeroCardModel.beforeCheckIn();
    } else if (attendance.checkOut == null) {
      final checkIn = attendance.checkIn!;
      final totalMinutes =
          attendance.expectedEndMinute - attendance.expectedStartMinute;
      final leaveAt = checkIn.add(Duration(minutes: totalMinutes));

      final approachingThreshold = leaveAt.subtract(
        const Duration(minutes: kApproachingCheckOutThresholdMinutes),
      );
      if (!DateTime.now().isBefore(approachingThreshold)) {
        return HeroCardModel.approachingCheckOut(
          checkIn: checkIn,
          scheduledEnd: leaveAt,
        );
      }

      final breakStart = DateTime(
        checkIn.year,
        checkIn.month,
        checkIn.day,
        attendance.expectedLunchStartMinute ~/ 60,
        attendance.expectedLunchStartMinute % 60,
      );
      final breakEnd = breakStart.add(
        Duration(minutes: attendance.lunchMinutes),
      );

      return HeroCardModel.working(
        checkIn: checkIn,
        leaveAt: leaveAt,
        breakStart: breakStart,
        breakEnd: breakEnd,
      );
    } else {
      return HeroCardModel.afterCheckOut(checkOutAt: attendance.checkOut!);
    }
  }
}
