import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/buttons/primary_button.dart';
import 'package:work_tracker/components/card/shadow_card.dart';
import 'package:work_tracker/components/inputs/app_time_picker.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/time/time_format.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/features/home/presentation/cubit/home_page_cubit.dart';

/// State A hero shown once a leave-home time is known — the day's single
/// most important number, plus when to check in.
class LeaveHomeHero extends StatelessWidget {
  const LeaveHomeHero({
    super.key,
    required this.leaveHomeAt,
    this.arriveAtWorkAt,
  });

  final DateTime leaveHomeAt;
  final DateTime? arriveAtWorkAt;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final relativeLabel = _relativeLeaveLabel(leaveHomeAt.difference(now));

    return ShadowCard(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'LEAVE HOME',
              style: AppTypography.caption(context)?.copyWith(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(
              TimeFormat.hhMmFromDateTime(leaveHomeAt),
              style: AppTypography.title(context)?.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(
              relativeLabel,
              style: AppTypography.body(context)?.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (arriveAtWorkAt != null) ...[
              const SizedBox(height: AppSpacing.space16),
              _ArriveAtWorkLine(time: arriveAtWorkAt!),
            ],
            const SizedBox(height: AppSpacing.space16),
            PrimaryButton(
              onPressed: () =>
                  _handleCheckIn(context, context.read<HomePageCubit>()),
              label: 'Check In',
            ),
          ],
        ),
      ),
    );
  }

  String _relativeLeaveLabel(Duration diff) {
    if (diff <= Duration.zero) return 'Leave now';
    final minutes = diff.inMinutes;
    if (minutes < 1) return 'Leave now';
    if (minutes < 60) return 'in ${minutes}m';
    return 'in ${TimeFormat.hMm(minutes)}';
  }

  Future<void> _handleCheckIn(BuildContext context, HomePageCubit cubit) async {
    final schedule = cubit.state.workSchedule;

    if (!context.mounted) return;

    if (schedule == null) {
      AppNavigator.pushWorkScheduleSettings(context);
      return;
    }

    final result = await showAppTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (result == null || !context.mounted) return;

    final now = DateTime.now();
    cubit.checkIn(
      DateTime(now.year, now.month, now.day, result.hour, result.minute),
    );
  }
}

class _ArriveAtWorkLine extends StatelessWidget {
  const _ArriveAtWorkLine({required this.time});

  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Arrive at work · ',
          style: AppTypography.caption(
            context,
          )?.copyWith(color: context.colors.textSecondary),
        ),
        Text(
          TimeFormat.hhMmFromDateTime(time),
          style: AppTypography.body(context)?.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
