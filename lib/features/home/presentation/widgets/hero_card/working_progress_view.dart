import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/buttons/primary_button.dart';
import 'package:work_tracker/components/card/shadow_card.dart';
import 'package:work_tracker/components/inputs/app_time_picker.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/time/time_format.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/features/home/presentation/cubit/home_page_cubit.dart';

class WorkingProgressView extends StatelessWidget {
  const WorkingProgressView({
    super.key,
    required this.checkIn,
    required this.leaveAt,
    required this.breakStart,
    required this.breakEnd,
  });

  final DateTime checkIn;
  final DateTime leaveAt;
  final DateTime breakStart;
  final DateTime breakEnd;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    // Before the break starts, count down to the break; from the break
    // onward (including during it), count down to leaveAt instead. leaveAt
    // already spans the full schedule (start to end), so no separate lunch
    // deduction is needed once the break has been reached.
    final beforeBreak = now.isBefore(breakStart);
    final remaining = beforeBreak
        ? breakStart.difference(now)
        : leaveAt.difference(now);
    final sectionLabel = beforeBreak ? 'Until break' : 'Remaining';

    // Overall day progress (checkIn -> leaveAt), independent of which phase
    // the countdown above is in.
    final totalMinutes = leaveAt.difference(checkIn).inMinutes;
    final elapsedMinutes = now.difference(checkIn).inMinutes;
    final progress = totalMinutes > 0
        ? (elapsedMinutes / totalMinutes).clamp(0.0, 1.0)
        : 1.0;

    final remainMinutes = remaining.inMinutes;
    final remainingLabel = remaining.inHours >= 1
        ? TimeFormat.hMm(remainMinutes > 0 ? remainMinutes : 0)
        : TimeFormat.mSs(remaining.inSeconds > 0 ? remaining.inSeconds : 0);

    return ShadowCard(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sectionLabel,
              style: AppTypography.label(context)?.copyWith(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(
              remainingLabel,
              style: AppTypography.title(context)?.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: AppSpacing.space24),
            _ProgressTrack(progress: progress, now: now),
            const SizedBox(height: AppSpacing.space4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  TimeFormat.hhMmFromDateTime(checkIn),
                  style: AppTypography.caption(
                    context,
                  )?.copyWith(color: context.colors.textSecondary),
                ),
                Text(
                  TimeFormat.hhMmFromDateTime(leaveAt),
                  style: AppTypography.caption(
                    context,
                  )?.copyWith(color: context.colors.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space16),
            PrimaryButton(
              label: 'Check Out',
              onPressed: () => _handleCheckOut(context),
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

class _ProgressTrack extends StatelessWidget {
  const _ProgressTrack({required this.progress, required this.now});

  final double progress;
  final DateTime now;

  static const double _trackHeight = 8;
  static const double _thumbSize = 16;
  static const double _trackTop = 20;
  static const double _labelWidth = 44;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final trackWidth = constraints.maxWidth;
          final thumbCenterX = progress * trackWidth;
          final thumbLeft = (thumbCenterX - _thumbSize / 2).clamp(
            0.0,
            trackWidth - _thumbSize,
          );
          final labelLeft = (thumbCenterX - _labelWidth / 2).clamp(
            0.0,
            trackWidth - _labelWidth,
          );

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: labelLeft,
                top: 0,
                width: _labelWidth,
                child: Text(
                  TimeFormat.hhMmFromDateTime(now),
                  textAlign: TextAlign.center,
                  style: AppTypography.caption(context)?.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: _trackTop,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_trackHeight / 2),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: _trackHeight,
                    backgroundColor: context.colors.surfaceSecondary,
                    color: context.colors.primary,
                  ),
                ),
              ),
              Positioned(
                left: thumbLeft,
                top: _trackTop - (_thumbSize - _trackHeight) / 2,
                child: Container(
                  width: _thumbSize,
                  height: _thumbSize,
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(color: context.colors.primary, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
