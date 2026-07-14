import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/card/shadow_card.dart';
import 'package:work_tracker/components/icon/app_icon.dart';
import 'package:work_tracker/components/inputs/app_time_picker.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/features/home/presentation/cubit/home_page_cubit.dart';
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
                () => _handleEditCheckIn(context),
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
                () => _handleEditCheckOut(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleEditCheckIn(BuildContext context) async {
    final cubit = context.read<HomePageCubit>();

    final result = await showAppTimePicker(
      context: context,
      initialTime: _parseTime(actualCheckInTime) ?? TimeOfDay.now(),
    );
    if (result == null || !context.mounted) return;

    final now = DateTime.now();
    cubit.checkIn(
      DateTime(now.year, now.month, now.day, result.hour, result.minute),
    );
  }

  Future<void> _handleEditCheckOut(BuildContext context) async {
    final cubit = context.read<HomePageCubit>();

    final result = await showAppTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (result == null || !context.mounted) return;

    final now = DateTime.now();
    cubit.checkOut(
      DateTime(now.year, now.month, now.day, result.hour, result.minute),
    );
  }

  TimeOfDay? _parseTime(String hhMm) {
    final parts = hhMm.split(':');
    if (parts.length != 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    return TimeOfDay(hour: hour, minute: minute);
  }

  Widget component(
    BuildContext context,
    Widget icon,
    String title,
    String actualTime,
    String plannedTime,
    String extraTimeLabel,
    Color extraTimeColor,
    void Function()? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
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
      ),
    );
  }
}
