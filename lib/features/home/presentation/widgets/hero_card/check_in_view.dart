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

class CheckInView extends StatelessWidget {
  const CheckInView({super.key, this.leaveHomeAt, this.arriveAtWorkAt});

  final DateTime? leaveHomeAt;
  final DateTime? arriveAtWorkAt;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Text(
            'Ready to start your day?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'You have not checked in yet.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (leaveHomeAt != null || arriveAtWorkAt != null) ...[
            const SizedBox(height: AppSpacing.space16),
            _CommuteReminderRow(
              leaveHomeAt: leaveHomeAt,
              arriveAtWorkAt: arriveAtWorkAt,
            ),
          ],
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PrimaryButton(
              onPressed: () =>
                  _handleCheckIn(context, context.read<HomePageCubit>()),
              label: 'Check In',
            ),
          ),
        ],
      ),
    );
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

class _CommuteReminderRow extends StatelessWidget {
  const _CommuteReminderRow({this.leaveHomeAt, this.arriveAtWorkAt});

  final DateTime? leaveHomeAt;
  final DateTime? arriveAtWorkAt;

  @override
  Widget build(BuildContext context) {
    final items = [
      if (leaveHomeAt != null) ('Leave home', leaveHomeAt!),
      if (arriveAtWorkAt != null) ('Arrive at work', arriveAtWorkAt!),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(width: AppSpacing.space24),
          _CommuteTimeItem(label: items[i].$1, time: items[i].$2),
        ],
      ],
    );
  }
}

class _CommuteTimeItem extends StatelessWidget {
  const _CommuteTimeItem({required this.label, required this.time});

  final String label;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: AppTypography.caption(
            context,
          )?.copyWith(color: context.colors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.space4),
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
