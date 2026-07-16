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

class TodaySummaryView extends StatelessWidget {
  const TodaySummaryView({
    super.key,
    required this.workedTime,
    required this.plannedWorkedTime,
    required this.overtime,
    required this.actualCheckInTime,
    required this.plannedCheckInTime,
    required this.checkInStatus,
    required this.checkInExtra,
    required this.actualCheckOutTime,
    required this.plannedCheckOutTime,
    required this.checkOutStatus,
    required this.checkOutExtra,
    this.onViewDetails,
  });

  final String workedTime;
  final String plannedWorkedTime;
  final String overtime;
  final String actualCheckInTime;
  final String plannedCheckInTime;
  final CheckInStatus checkInStatus;
  final String checkInExtra;
  final String actualCheckOutTime;
  final String plannedCheckOutTime;
  final CheckOutStatus checkOutStatus;
  final String checkOutExtra;
  final VoidCallback? onViewDetails;

  @override
  Widget build(BuildContext context) {
    final arrivedLate = checkInStatus == CheckInStatus.late;
    // checkOutStatus/checkOutExtra compare the actual check-out time against
    // the raw work-schedule end time (not the check-in-adjusted one used by
    // the "Overtime" tile above) — label it "late" to avoid implying it's
    // the same figure as overtime.
    final leftLate = checkOutStatus == CheckOutStatus.overtime;

    return ShadowCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TODAY'S SUMMARY",
                  style: AppTypography.caption(context)?.copyWith(
                    color: context.colors.textSecondary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                if (onViewDetails != null)
                  InkWell(
                    onTap: onViewDetails,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View details',
                          style: AppTypography.label(context)?.copyWith(
                            color: context.colors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 16,
                          color: context.colors.primary,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.space16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _SummaryTile(
                    icon: Icons.access_time,
                    color: context.colors.secondary,
                    label: 'Total worked',
                    value: workedTime,
                    subtitle: 'of $plannedWorkedTime',
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: _SummaryTile(
                    icon: Icons.timelapse,
                    color: context.colors.tertiary,
                    label: 'Overtime',
                    value: overtime,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _SummaryTile(
                    icon: Icons.login,
                    color: context.colors.warning,
                    label: 'Arrived',
                    value: '$checkInExtra ${arrivedLate ? 'late' : 'soon'}',
                    subtitle: '$actualCheckInTime vs $plannedCheckInTime',
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: _SummaryTile(
                    icon: Icons.logout,
                    color: context.colors.success,
                    label: 'Left',
                    value: '$checkOutExtra ${leftLate ? 'late' : 'on time'}',
                    subtitle: '$actualCheckOutTime vs $plannedCheckOutTime',
                    onTap: () => _handleEditCheckOut(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleEditCheckOut(BuildContext context) async {
    final cubit = context.read<HomePageCubit>();

    final result = await showAppTimePicker(
      context: context,
      initialTime: _parseTime(actualCheckOutTime) ?? TimeOfDay.now(),
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
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String value;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.space4,
      children: [
        AppIcon(
          backgroundColor: color.withValues(alpha: 0.15),
          icon: Icon(icon, color: color, size: 18),
        ),
        Text(
          label,
          style: AppTypography.caption(context)?.copyWith(
            color: context.colors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: AppTypography.title(context)?.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        if (subtitle != null)
          Text(
            subtitle!,
            style: AppTypography.caption(
              context,
            )?.copyWith(color: context.colors.textSecondary),
          ),
      ],
    );

    return onTap == null
        ? content
        : GestureDetector(onTap: onTap, child: content);
  }
}
