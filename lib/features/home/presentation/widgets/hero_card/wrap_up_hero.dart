import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/buttons/primary_button.dart';
import 'package:work_tracker/components/buttons/secondary_button.dart';
import 'package:work_tracker/components/card/shadow_card.dart';
import 'package:work_tracker/components/inputs/app_time_picker.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/time/time_format.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';
import 'package:work_tracker/features/home/presentation/cubit/home_page_cubit.dart';
import 'package:work_tracker/features/work_item/domain/daily_report.dart';
import 'package:work_tracker/features/work_item/presentation/cubit/daily_report_cubit.dart';

/// State C hero — shown once check-out is close (or already due), so the
/// focus shifts from the working countdown to wrapping up: a condensed
/// report preview plus Check Out / Copy report actions.
class WrapUpHero extends StatelessWidget {
  const WrapUpHero({super.key, required this.scheduledEnd});

  final DateTime scheduledEnd;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DailyReportCubit>()..load(),
      child: _WrapUpHeroContent(scheduledEnd: scheduledEnd),
    );
  }
}

class _WrapUpHeroContent extends StatelessWidget {
  const _WrapUpHeroContent({required this.scheduledEnd});

  final DateTime scheduledEnd;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final overtime = now.isAfter(scheduledEnd);
    final diffMinutes = (overtime
            ? now.difference(scheduledEnd)
            : scheduledEnd.difference(now))
        .inMinutes;
    // Mirrors AttendanceWorkingView's "Should Leave" tile: overtime uses the
    // less urgent warning color, still-time-left uses error to draw the eye.
    final badgeColor = overtime ? context.colors.warning : context.colors.error;
    final badgeLabel =
        '${TimeFormat.hMm(diffMinutes > 0 ? diffMinutes : 0)}'
        ' ${overtime ? 'overtime' : 'to go'}';

    return BlocBuilder<DailyReportCubit, DailyReportState>(
      builder: (context, state) {
        final report = state.report;

        return ShadowCard(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'WRAPPING UP',
                  style: AppTypography.caption(context)?.copyWith(
                    color: context.colors.textSecondary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: AppSpacing.space8),
                Row(
                  children: [
                    Text(
                      'Scheduled end ${TimeFormat.hhMmFromDateTime(scheduledEnd)}',
                      style: AppTypography.body(context)?.copyWith(
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space8),
                    DecoratedBox(
                      decoration: ShapeDecoration(
                        shape: const StadiumBorder(),
                        color: badgeColor.withValues(alpha: 0.2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.space8,
                          vertical: AppSpacing.space4,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time,
                              color: badgeColor,
                              size: 12,
                            ),
                            const SizedBox(width: AppSpacing.space4),
                            Text(
                              badgeLabel,
                              style: AppTypography.label(context)?.copyWith(
                                color: badgeColor,
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
                const SizedBox(height: AppSpacing.space16),
                _ReportPreview(isLoading: state.isLoading, report: report),
                const SizedBox(height: AppSpacing.space16),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        label: 'Check Out',
                        onPressed: () => _handleCheckOut(context),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space12),
                    SecondaryButton(
                      label: 'Copy report',
                      icon: Icons.copy,
                      expanded: false,
                      onPressed: (report == null || report.isEmpty)
                          ? null
                          : () => _copy(context, report, state.attendance),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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

  void _copy(BuildContext context, DailyReport report, Attendance? attendance) {
    Clipboard.setData(
      ClipboardData(
        text: renderDailyReportText(report, attendance: attendance),
      ),
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Report copied')));
  }
}

/// Condensed, read-only preview of today's report — one line per task plus
/// the total, nested like [showDailyReportSheet]'s entry list but without the
/// per-session breakdown.
class _ReportPreview extends StatelessWidget {
  const _ReportPreview({required this.isLoading, required this.report});

  final bool isLoading;
  final DailyReport? report;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 32,
        child: Center(
          child: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (report == null || report!.isEmpty) {
      return ShadowCard(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space12),
          child: Text(
            'No time tracked today',
            style: AppTypography.body(
              context,
            )?.copyWith(color: context.colors.textSecondary),
          ),
        ),
      );
    }

    final entries = report!.entries;
    return ShadowCard(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final entry in entries) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      entry.externalId != null
                          ? '#${entry.externalId} ${entry.title}'
                          : entry.title,
                      style: AppTypography.caption(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space8),
                  Text(
                    TimeFormat.hMm(entry.totalSeconds ~/ 60),
                    style: AppTypography.caption(
                      context,
                    )?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              if (entry != entries.last)
                const SizedBox(height: AppSpacing.space4),
            ],
            const Divider(height: AppSpacing.space16),
            Text(
              'Total: ${TimeFormat.hMm(report!.totalSeconds ~/ 60)}',
              style: AppTypography.label(
                context,
              )?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
