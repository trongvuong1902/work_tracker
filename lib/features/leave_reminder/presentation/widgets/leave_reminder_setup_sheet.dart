import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/time/time_format.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/geo_point.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/leave_reminder_prompt_trigger.dart';
import 'package:work_tracker/features/leave_reminder/presentation/cubit/leave_reminder_setup_cubit.dart';

extension _GeoPointToLatLng on GeoPoint {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

/// Shows the leave-reminder setup sheet — the single reused UI surface for
/// both the post-check-in discovery prompt ([trigger] non-null) and manual
/// access from Settings ([trigger] null, no banner).
Future<void> showLeaveReminderSetupSheet(
  BuildContext context, {
  LeaveReminderPromptTrigger? trigger,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => BlocProvider(
      create: (_) => getIt<LeaveReminderSetupCubit>(),
      child: _LeaveReminderSetupSheet(trigger: trigger),
    ),
  );
}

class _LeaveReminderSetupSheet extends StatelessWidget {
  const _LeaveReminderSetupSheet({this.trigger});

  final LeaveReminderPromptTrigger? trigger;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LeaveReminderSetupCubit, LeaveReminderSetupState>(
      listenWhen: (previous, current) =>
          !previous.didCloseSuccessfully && current.didCloseSuccessfully,
      listener: (context, state) => Navigator.pop(context),
      child: BlocBuilder<LeaveReminderSetupCubit, LeaveReminderSetupState>(
        builder: (context, state) {
          final cubit = context.read<LeaveReminderSetupCubit>();

          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.space16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (trigger != null) ...[
                    _TriggerBanner(trigger: trigger!),
                    const SizedBox(height: AppSpacing.space16),
                  ] else ...[
                    Text(
                      'Leave reminders',
                      style: AppTypography.title(
                        context,
                      )?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: AppSpacing.space16),
                  ],
                  if (state.isLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSpacing.space32,
                      ),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else ...[
                    _LocationRow(
                      label: 'Set Home',
                      isSet: state.home != null,
                      isLoading: state.isSettingHome,
                      onTap: () async {
                        final picked = await AppNavigator.pushLocationPicker(
                          context,
                          title: 'Set Home',
                          initial: state.home?.toLatLng(),
                        );
                        if (picked != null) {
                          cubit.setHome(
                            GeoPoint(
                              latitude: picked.latitude,
                              longitude: picked.longitude,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: AppSpacing.space8),
                    _LocationRow(
                      label: 'Set Work',
                      isSet: state.work != null,
                      isLoading: state.isSettingWork,
                      onTap: () async {
                        final picked = await AppNavigator.pushLocationPicker(
                          context,
                          title: 'Set Work',
                          initial: state.work?.toLatLng(),
                        );
                        if (picked != null) {
                          cubit.setWork(
                            GeoPoint(
                              latitude: picked.latitude,
                              longitude: picked.longitude,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: AppSpacing.space16),
                    ShadowCard(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.space16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Enable leave reminders',
                                style: AppTypography.label(context),
                              ),
                            ),
                            state.isTogglingEnabled
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Switch(
                                    value: state.enabled,
                                    activeThumbColor: context.colors.primary,
                                    onChanged: (value) =>
                                        cubit.toggleEnabled(value),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    if (state.hasBothLocations) ...[
                      const SizedBox(height: AppSpacing.space16),
                      _CommuteReadoutCard(
                        minutes: state.lastCommuteMinutes,
                        updatedAt: state.lastCommuteUpdatedAt,
                        isRefreshing: state.isRefreshingCommute,
                        onRefresh: cubit.refreshCommute,
                      ),
                    ],
                    if (state.errorMessage != null) ...[
                      const SizedBox(height: AppSpacing.space16),
                      Text(
                        state.errorMessage!,
                        style: AppTypography.body(
                          context,
                        )?.copyWith(color: context.colors.error),
                      ),
                    ],
                  ],
                  const SizedBox(height: AppSpacing.space16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TriggerBanner extends StatelessWidget {
  const _TriggerBanner({required this.trigger});

  final LeaveReminderPromptTrigger trigger;

  @override
  Widget build(BuildContext context) {
    final message = switch (trigger) {
      LeaveReminderPromptTrigger.onTimeStreak =>
        '🎉 3 on-time check-ins in a row! Want a heads-up before you need '
            'to leave?',
      LeaveReminderPromptTrigger.firstLateCheckIn =>
        "⏰ Running a bit late today? Set a reminder so it doesn't happen "
            'again.',
    };

    return ShadowCard(
      color: context.colors.primaryLight,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Text(message, style: AppTypography.body(context)),
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  const _LocationRow({
    required this.label,
    required this.isSet,
    required this.isLoading,
    required this.onTap,
  });

  final String label;
  final bool isSet;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTypography.label(context)),
              if (isLoading)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                Text(
                  isSet ? '✓ set' : 'Not set',
                  style: AppTypography.body(context)?.copyWith(
                    color: isSet
                        ? context.colors.primary
                        : context.colors.textSecondary,
                    fontWeight: isSet ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommuteReadoutCard extends StatelessWidget {
  const _CommuteReadoutCard({
    required this.minutes,
    required this.updatedAt,
    required this.isRefreshing,
    required this.onRefresh,
  });

  final int? minutes;
  final DateTime? updatedAt;
  final bool isRefreshing;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final text = minutes == null
        ? 'No commute estimate yet'
        : '$minutes min drive'
              '${updatedAt != null ? ' · updated ${TimeFormat.hhMmFromDateTime(updatedAt!)}' : ''}';

    return ShadowCard(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(text, style: AppTypography.body(context)),
            ),
            isRefreshing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : IconButton(
                    icon: const Icon(Icons.refresh),
                    tooltip: 'Refresh commute estimate',
                    onPressed: onRefresh,
                  ),
          ],
        ),
      ),
    );
  }
}
