import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/components/card/shadow_card.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/work_item/domain/models/work_item.dart';
import 'package:work_tracker/features/work_item/presentation/widgets/daily_report_sheet.dart';

import 'cubit/today_work_items_cubit.dart';

/// Home section listing the tasks worked on today (time logged today plus the
/// currently-running task's live portion), with a "See more" into the Manage
/// task times timesheet.
class TodayTasksView extends StatelessWidget {
  const TodayTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => getIt<TodayWorkItemsCubit>()..init(),
      child: BlocBuilder<TodayWorkItemsCubit, TodayWorkItemsState>(
        builder: (context, state) {
          if (state.isLoading) return const SizedBox.shrink();
          return _Card(
            child: state.items.isEmpty
                ? Text(
                    'No time tracked today',
                    style: AppTypography.body(
                      context,
                    )?.copyWith(color: context.colors.textSecondary),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final item in state.items) ...[
                        _WorkItemTimeRow(
                          idLabel: item.task.externalId,
                          title: item.task.title,
                          seconds: item.seconds,
                          running: item.task.isTimerRunning,
                          done: item.task.done,
                          onTap: () => AppNavigator.pushTaskDetail(
                            context,
                            item.task.id,
                          ),
                        ),
                        if (item != state.items.last)
                          const SizedBox(height: AppSpacing.space12),
                      ],
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class _WorkItemTimeRow extends StatelessWidget {
  const _WorkItemTimeRow({
    required this.idLabel,
    required this.title,
    required this.seconds,
    required this.running,
    required this.done,
    required this.onTap,
  });

  final String? idLabel;
  final String title;
  final int seconds;
  final bool running;
  final bool done;
  final VoidCallback onTap;

  IconData get _statusIcon {
    if (running) return Icons.play_circle;
    if (done) return Icons.check_circle;
    return Icons.timelapse;
  }

  @override
  Widget build(BuildContext context) {
    final accent = running || done;
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Line 1: status icon · #id · spacer · duration (Xh YYm).
          Row(
            children: [
              Icon(
                _statusIcon,
                size: 18,
                color: accent
                    ? context.colors.primary
                    : context.colors.textSecondary,
              ),
              if (idLabel != null) ...[
                const SizedBox(width: AppSpacing.space8),
                Text(
                  '#$idLabel',
                  style: AppTypography.caption(context)?.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
              const Spacer(),
              Text(
                TimeFormat.hMm(seconds ~/ 60),
                style: AppTypography.label(context)?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: running ? context.colors.primary : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space4),
          // Line 2: title.
          Text(
            title,
            style: AppTypography.body(context),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
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
                  "TODAY'S TASKS",
                  style: AppTypography.caption(context)?.copyWith(
                    color: context.colors.textSecondary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => showDailyReportSheet(context),
                      child: Row(
                        children: [
                          Icon(
                            Icons.summarize_outlined,
                            size: 14,
                            color: context.colors.primary,
                          ),
                          const SizedBox(width: AppSpacing.space4),
                          Text(
                            'Report',
                            style: AppTypography.caption(
                              context,
                            )?.copyWith(color: context.colors.primary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space16),
                    GestureDetector(
                      onTap: () => AppNavigator.pushTaskTimes(context),
                      child: Text(
                        'See more →',
                        style: AppTypography.caption(
                          context,
                        )?.copyWith(color: context.colors.primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space16),
            child,
          ],
        ),
      ),
    );
  }
}
