import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/location_log/presentation/cubit/location_activity_cubit.dart';
import 'package:work_tracker/features/location_log/presentation/widgets/location_log_day_section.dart';
import 'package:work_tracker/features/location_log/presentation/widgets/location_log_setup_sheet.dart';

/// Screen A (`/attendance`) — the full, day-grouped, paginated location
/// activity history, reached from Settings' "Location activity" row.
class LocationActivityPage extends StatelessWidget {
  const LocationActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LocationActivityCubit>(),
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
                    Text(
                      'Location activity',
                      style: AppTypography.title(
                        context,
                      )?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space16),
                Expanded(
                  child:
                      BlocBuilder<
                        LocationActivityCubit,
                        LocationActivityState
                      >(
                        builder: (context, state) {
                          return state.map(
                            loading: (_) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            notEnabled: (_) => SingleChildScrollView(
                              child: _NotEnabledCard(
                                onSetUp: () async {
                                  await showLocationLogSetupSheet(context);
                                  if (context.mounted) {
                                    context.read<LocationActivityCubit>().init();
                                  }
                                },
                              ),
                            ),
                            enabledNoEvents: (_) => Center(
                              child: Text(
                                'No location activity recorded yet.',
                                style: AppTypography.body(context)?.copyWith(
                                  color: context.colors.textSecondary,
                                ),
                              ),
                            ),
                            populated: (populated) => ListView(
                              children: [
                                for (final section in populated.sections) ...[
                                  LocationLogDaySection(
                                    date: section.date,
                                    events: section.events,
                                    badges: section.badges,
                                    onAssignedTap: () =>
                                        AppNavigator.goCalendar(context),
                                  ),
                                  const SizedBox(height: AppSpacing.space16),
                                ],
                                if (populated.canLoadMore)
                                  Center(
                                    child: populated.isLoadingMore
                                        ? const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: AppSpacing.space16,
                                            ),
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : TextButton(
                                            onPressed: () => context
                                                .read<LocationActivityCubit>()
                                                .loadEarlier(),
                                            child: const Text('Load earlier'),
                                          ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NotEnabledCard extends StatelessWidget {
  const _NotEnabledCard({required this.onSetUp});

  final VoidCallback onSetUp;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      color: context.colors.primaryLight,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location tracking is off',
              style: AppTypography.subtitle(
                context,
              )?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(
              'Turn it on to automatically log arrivals/departures at work '
              'and fill in your check-in/check-out.',
              style: AppTypography.body(
                context,
              )?.copyWith(color: context.colors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.space16),
            PrimaryButton(label: 'Set up location tracking', onPressed: onSetUp),
          ],
        ),
      ),
    );
  }
}
