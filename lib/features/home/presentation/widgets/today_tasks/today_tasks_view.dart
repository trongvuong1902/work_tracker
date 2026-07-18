import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/components/card/shadow_card.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/task/domain/models/task.dart';

import 'cubit/today_tasks_cubit.dart';

/// Home section listing the tasks worked on today (time logged today plus the
/// currently-running task's live portion), with a "See more" into the Manage
/// task times timesheet.
class TodayTasksView extends StatelessWidget {
  const TodayTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => getIt<TodayTasksCubit>()..init(),
      child: BlocBuilder<TodayTasksCubit, TodayTasksState>(
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
                        _TaskTimeRow(
                          title: item.task.title,
                          seconds: item.seconds,
                          running: item.task.isTimerRunning,
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

class _TaskTimeRow extends StatelessWidget {
  const _TaskTimeRow({
    required this.title,
    required this.seconds,
    required this.running,
    required this.onTap,
  });

  final String title;
  final int seconds;
  final bool running;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            running ? Icons.play_circle : Icons.timelapse,
            size: 18,
            color: running ? context.colors.primary : context.colors.textSecondary,
          ),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Text(
              title,
              style: AppTypography.body(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: AppSpacing.space8),
          Text(
            TimeFormat.clock(seconds),
            style: AppTypography.label(context)?.copyWith(
              fontWeight: FontWeight.w600,
              color: running ? context.colors.primary : null,
            ),
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
            const SizedBox(height: AppSpacing.space16),
            child,
          ],
        ),
      ),
    );
  }
}
