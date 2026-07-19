import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/buttons/secondary_button.dart';
import 'package:work_tracker/components/card/shadow_card.dart';
import 'package:work_tracker/components/inputs/app_time_picker.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/time/time_format.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/features/home/presentation/cubit/home_page_cubit.dart';
import 'package:work_tracker/features/home/presentation/widgets/hero_card/progress_track.dart';

/// State B hero — a slim status strip (rather than the old full-height
/// countdown card) so the section below it (today's tasks) can take the
/// visual lead while checked in and still comfortably ahead of check-out.
class WorkingStatusStrip extends StatelessWidget {
  const WorkingStatusStrip({
    super.key,
    required this.checkIn,
    required this.leaveAt,
  });

  final DateTime checkIn;
  final DateTime leaveAt;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final remainingMinutes = leaveAt.difference(now).inMinutes;
    final totalMinutes = leaveAt.difference(checkIn).inMinutes;
    final elapsedMinutes = now.difference(checkIn).inMinutes;
    final progress = totalMinutes > 0
        ? (elapsedMinutes / totalMinutes).clamp(0.0, 1.0)
        : 1.0;

    return ShadowCard(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Working · ${TimeFormat.hMm(remainingMinutes > 0 ? remainingMinutes : 0)} left'
              ' · leave ${TimeFormat.hhMmFromDateTime(leaveAt)}',
              style: AppTypography.body(context)?.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.space12),
            ProgressTrack(
              progress: progress,
              now: now,
              trackHeight: 6,
              thumbSize: 12,
              showNowLabel: false,
            ),
            const SizedBox(height: AppSpacing.space8),
            Align(
              alignment: Alignment.centerRight,
              child: SecondaryButton(
                label: 'Check Out',
                expanded: false,
                onPressed: () => _handleCheckOut(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleCheckOut(BuildContext context) async {
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
}
