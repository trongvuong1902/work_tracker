import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/location_log/presentation/cubit/location_activity_day_cubit.dart';
import 'package:work_tracker/features/location_log/presentation/widgets/location_log_badge.dart';
import 'package:work_tracker/features/location_log/presentation/widgets/location_log_event_row.dart';

/// Screen B (`/attendance/:date`) — a single day's location activity,
/// read-only. Reached from a notification tap or Calendar's day detail.
class LocationActivityDayPage extends StatelessWidget {
  const LocationActivityDayPage({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LocationActivityDayCubit>()..init(date),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.space16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                    const SizedBox(width: AppSpacing.space8),
                    Expanded(
                      child: Text(
                        _dayLabel(date),
                        style: AppTypography.title(
                          context,
                        )?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space16),
                Expanded(
                  child:
                      BlocBuilder<
                        LocationActivityDayCubit,
                        LocationActivityDayState
                      >(
                        builder: (context, state) {
                          if (state.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state.events.isEmpty) {
                            return Center(
                              child: Text(
                                'No location activity recorded for this day.',
                                style: AppTypography.body(context)?.copyWith(
                                  color: context.colors.textSecondary,
                                ),
                              ),
                            );
                          }

                          return SingleChildScrollView(
                            child: ShadowCard(
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  AppSpacing.space16,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (final log in state.events) ...[
                                      LocationLogEventRow(
                                        log: log,
                                        badgeTier:
                                            state.badges[log] ??
                                            LocationLogBadgeTier.none,
                                      ),
                                      if (log != state.events.last)
                                        Divider(
                                          height: AppSpacing.space24,
                                          color: context.colors.outline,
                                        ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                ),
                const SizedBox(height: AppSpacing.space16),
                Center(
                  child: GestureDetector(
                    onTap: () => AppNavigator.pushAttendance(context),
                    child: Text(
                      'View full history →',
                      style: AppTypography.caption(
                        context,
                      )?.copyWith(color: context.colors.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _dayLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    final base =
        '${weekdayInitials[date.weekday - 1]}, ${date.day} '
        '${monthNames[date.month - 1]} ${date.year}';

    if (dateOnly == today) return '$base · Today';
    if (dateOnly == yesterday) return '$base · Yesterday';
    return base;
  }
}
