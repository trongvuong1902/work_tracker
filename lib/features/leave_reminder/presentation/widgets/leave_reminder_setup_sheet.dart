import 'package:flutter/foundation.dart' show kDebugMode;
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
import 'package:work_tracker/features/leave_reminder/leave_reminder_constants.dart';
import 'package:work_tracker/features/leave_reminder/presentation/cubit/leave_reminder_setup_cubit.dart';
import 'package:work_tracker/features/schedule/domain/work_schedule_constants.dart';

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
    return BlocBuilder<LeaveReminderSetupCubit, LeaveReminderSetupState>(
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
                  if (state.enabled) ...[
                    const SizedBox(height: AppSpacing.space16),
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
                  ],
                  if (state.hasBothLocations) ...[
                    const SizedBox(height: AppSpacing.space16),
                    _CommuteReadoutCard(
                      minutes: state.lastCommuteMinutes,
                      updatedAt: state.lastCommuteUpdatedAt,
                      isRefreshing: state.isRefreshingCommute,
                      onRefresh: cubit.refreshCommute,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.space16),
                  MinutePickerRow(
                    label: 'Arrive early by',
                    minutes: state.schedule?.reminderMinutes,
                    options: kReminderBufferOptions,
                    enabled: state.schedule != null,
                    placeholder: 'Set a work schedule first',
                    valueBuilder: (minutes) =>
                        state.expectedArriveMinuteOfDay != null
                        ? '$minutes min · '
                              '${TimeFormat.hhMm(state.expectedArriveMinuteOfDay!)}'
                        : '$minutes min',
                    onChanged: cubit.updateReminderMinutes,
                  ),
                  const SizedBox(height: AppSpacing.space16),
                  MinutePickerRow(
                    label: 'Notify before leaving',
                    minutes: state.headsUpLeadMinutes,
                    options: kHeadsUpLeadOptions,
                    valueBuilder: (minutes) => '$minutes min',
                    onChanged: cubit.updateHeadsUpLeadMinutes,
                  ),
                  const SizedBox(height: AppSpacing.space16),
                  _ScheduleReadoutCard(
                    expectedArriveMinuteOfDay: state.expectedArriveMinuteOfDay,
                    alertMinuteOfDay: state.alertMinuteOfDay,
                  ),
                  if (kDebugMode) ...[
                    const SizedBox(height: AppSpacing.space16),
                    _DebugNotificationTimesCard(
                      alertMinuteOfDay: state.alertMinuteOfDay,
                      headsUpLeadMinutes: state.headsUpLeadMinutes,
                      unavailableReason: state.schedule == null
                          ? 'No work schedule set'
                          : state.lastCommuteMinutes == null
                          ? 'No commute estimate yet — set Home & Work '
                                'locations above'
                          : null,
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

class _ScheduleReadoutCard extends StatelessWidget {
  const _ScheduleReadoutCard({
    required this.expectedArriveMinuteOfDay,
    required this.alertMinuteOfDay,
  });

  final int? expectedArriveMinuteOfDay;
  final int? alertMinuteOfDay;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ReadoutRow(
              label: 'Expected arrival',
              value: expectedArriveMinuteOfDay != null
                  ? TimeFormat.hhMm(expectedArriveMinuteOfDay!)
                  : 'Set a work schedule',
            ),
            const SizedBox(height: AppSpacing.space8),
            _ReadoutRow(
              label: 'Leave reminder alert',
              value: alertMinuteOfDay != null
                  ? TimeFormat.hhMm(alertMinuteOfDay!)
                  : 'Needs a commute estimate',
            ),
          ],
        ),
      ),
    );
  }
}

class _ReadoutRow extends StatelessWidget {
  const _ReadoutRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.label(context)),
        Text(value, style: AppTypography.body(context)),
      ],
    );
  }
}

/// Debug-only readout of when the two local notifications actually get
/// scheduled to fire — the same [alertMinuteOfDay] value passed to
/// `scheduleAt` for the "leave now" alert, and that minus
/// [headsUpLeadMinutes] for the earlier heads-up. Not shown in release
/// builds.
class _DebugNotificationTimesCard extends StatelessWidget {
  const _DebugNotificationTimesCard({
    required this.alertMinuteOfDay,
    required this.headsUpLeadMinutes,
    this.unavailableReason,
  });

  final int? alertMinuteOfDay;
  final int headsUpLeadMinutes;

  /// Why [alertMinuteOfDay] is null, shown instead of the readout rows so
  /// it's clear this isn't a rendering bug — the times just aren't
  /// computable yet.
  final String? unavailableReason;

  @override
  Widget build(BuildContext context) {
    final alert = alertMinuteOfDay;
    final headsUp = alert != null ? alert - headsUpLeadMinutes : null;

    return ShadowCard(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🐛 Notification schedule (debug)',
              style: AppTypography.label(context),
            ),
            const SizedBox(height: AppSpacing.space8),
            if (alert == null)
              Text(
                unavailableReason ?? 'Not scheduled yet',
                style: AppTypography.body(
                  context,
                )?.copyWith(color: context.colors.textSecondary),
              )
            else ...[
              _ReadoutRow(
                label: 'Heads-up fires at',
                value: TimeFormat.hhMm(headsUp!),
              ),
              const SizedBox(height: AppSpacing.space8),
              _ReadoutRow(
                label: 'Leave-now fires at',
                value: TimeFormat.hhMm(alert),
              ),
            ],
          ],
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
