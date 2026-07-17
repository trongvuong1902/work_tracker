import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/components/card/shadow_card.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/location_log/presentation/widgets/location_log_event_row.dart';

import 'cubit/today_activity_timeline_cubit.dart';

class TodayActivityTimelineView extends StatelessWidget {
  const TodayActivityTimelineView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => getIt<TodayActivityTimelineCubit>()..init(),
      child: BlocBuilder<TodayActivityTimelineCubit, TodayActivityTimelineState>(
        builder: (context, state) {
          return state.map(
            notEnabled: (_) => const SizedBox.shrink(),
            noEventsToday: (_) => _Card(
              child: Text(
                'No activity yet today',
                style: AppTypography.body(
                  context,
                )?.copyWith(color: context.colors.textSecondary),
              ),
            ),
            populated: (populated) => _Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final log in populated.events) ...[
                    LocationLogEventRow(
                      log: log,
                      badgeTier: populated.badges[log]!,
                    ),
                    if (log != populated.events.last)
                      const SizedBox(height: AppSpacing.space16),
                  ],
                  const SizedBox(height: AppSpacing.space16),
                  GestureDetector(
                    onTap: () => AppNavigator.pushAttendance(context),
                    child: Text(
                      'View full history →',
                      style: AppTypography.caption(
                        context,
                      )?.copyWith(color: context.colors.primary),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
            Text(
              "TODAY'S ACTIVITY",
              style: AppTypography.caption(context)?.copyWith(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: AppSpacing.space16),
            child,
          ],
        ),
      ),
    );
  }
}
