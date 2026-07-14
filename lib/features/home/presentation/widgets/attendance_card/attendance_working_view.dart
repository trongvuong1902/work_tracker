import 'package:flutter/material.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/card/shadow_card.dart';
import 'package:work_tracker/components/icon/app_icon.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/features/home/presentation/widgets/attendance_card/attendance_card_model.dart';

class AttendanceWorkingView extends StatelessWidget {
  const AttendanceWorkingView({
    super.key,
    required this.actualCheckInTime,
    required this.plannedCheckInTime,
    required this.estimateCheckOutTime,
    required this.plannedLeave,
    this.extraTimeCheckIn,
    this.checkInStatus,
    this.extraTimeCheckOut,
    this.checkOutStatus,
  });

  final String actualCheckInTime;
  final String plannedCheckInTime;
  final String estimateCheckOutTime;
  final String plannedLeave;
  final String? extraTimeCheckIn;
  final CheckInStatus? checkInStatus;
  final String? extraTimeCheckOut;
  final CheckOutStatus? checkOutStatus;

  @override
  Widget build(BuildContext context) {
    final checkInLate = checkInStatus == CheckInStatus.late;
    final checkOutOvertime = checkOutStatus == CheckOutStatus.overtime;

    return ShadowCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              component(
                context,
                AppIcon(
                  icon: Icon(
                    Icons.check_circle_outline,
                    color: context.colors.primary,
                  ),
                  backgroundColor: context.colors.surfaceSecondary,
                ),
                'Check In',
                actualCheckInTime,
                'Planned $plannedCheckInTime',
                '${extraTimeCheckIn ?? '0h 00m'} ${checkInLate ? 'late' : 'soon'}',
                checkInLate ? context.colors.error : context.colors.tertiary,
              ),
              VerticalDivider(
                color: context.colors.divider,
                thickness: 1,
                width: 1,
              ),
              component(
                context,
                AppIcon(
                  icon: Icon(Icons.access_time, color: context.colors.primary),
                  backgroundColor: context.colors.surfaceSecondary,
                ),
                'Should Leave',
                plannedLeave,
                'Planned $estimateCheckOutTime',
                '${extraTimeCheckOut ?? '0h 00m'} ${checkOutOvertime ? 'overtime' : 'soon'}',
                checkOutOvertime
                    ? context.colors.warning
                    : context.colors.error,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget component(
    BuildContext context,
    Widget icon,
    String title,
    String actualTime,
    String plannedTime,
    String extraTimeLabel,
    Color extraTimeColor,
  ) {
    return Row(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.space4,
          children: [
            Text(
              title,
              style: AppTypography.label(context)?.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              actualTime,
              style: AppTypography.title(context)?.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 28,
              ),
            ),
            Text(
              plannedTime,
              style: AppTypography.body(context)?.copyWith(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            DecoratedBox(
              decoration: ShapeDecoration(
                shape: StadiumBorder(),
                color: extraTimeColor.withValues(alpha: 0.2),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Row(
                  spacing: 4,
                  children: [
                    Icon(Icons.access_time, color: extraTimeColor, size: 12),
                    Text(
                      extraTimeLabel,
                      style: AppTypography.label(context)?.copyWith(
                        color: extraTimeColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
