import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/notifications/notification_service.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/time/time_format.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/leave_reminder_prompt_trigger.dart';
import 'package:work_tracker/features/leave_reminder/leave_reminder_constants.dart';
import 'package:work_tracker/features/leave_reminder/presentation/cubit/leave_reminder_setup_cubit.dart';
import 'package:work_tracker/features/schedule/domain/work_schedule_constants.dart';

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
    showDragHandle: true,
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
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.space32),
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
                  const SizedBox(height: AppSpacing.space16),
                  _LocationsHeader(
                    setCount:
                        (state.home != null ? 1 : 0) +
                        (state.work != null ? 1 : 0),
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  _LocationRow(
                    label: 'Set Home',
                    isSet: state.home != null,
                    isLoading: state.isSettingHome,
                    onTap: () async {
                      final picked = await AppNavigator.pushLocationPicker(
                        context,
                        title: 'Set Home',
                        initial: state.home,
                      );
                      if (picked != null) cubit.setHome(picked);
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
                        initial: state.work,
                      );
                      if (picked != null) cubit.setWork(picked);
                    },
                  ),
                  if (state.hasBothLocations) ...[
                    const SizedBox(height: AppSpacing.space16),
                    _CommuteReadoutCard(
                      minutes: state.lastCommuteMinutes,
                      averageMinutes: state.averageCommuteMinutes,
                      updatedAt: state.lastCommuteUpdatedAt,
                      isRefreshing: state.isRefreshingCommute,
                      onRefresh: cubit.refreshCommute,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.space16),
                  MinutePickerRow(
                    label: 'Expected arrival',
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
                    label: 'Prepare duration',
                    minutes: state.headsUpLeadMinutes,
                    options: kHeadsUpLeadOptions,
                    onChanged: cubit.updateHeadsUpLeadMinutes,
                  ),
                  if (kDebugMode) ...[
                    const SizedBox(height: AppSpacing.space16),
                    _DebugPendingNotificationsCard(
                      alertMinuteOfDay: state.alertMinuteOfDay,
                      headsUpLeadMinutes: state.headsUpLeadMinutes,
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

/// "Locations" requirement header — sits above the "Set Home"/"Set Work"
/// rows, always visible regardless of `state.enabled`. Shows a running
/// count of how many of the two are set, plus a short explanatory caption
/// until both are set.
class _LocationsHeader extends StatelessWidget {
  const _LocationsHeader({required this.setCount});

  final int setCount;

  @override
  Widget build(BuildContext context) {
    final isComplete = setCount >= 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Locations', style: AppTypography.label(context)),
            Text(
              '$setCount of 2 set',
              style: AppTypography.body(context)?.copyWith(
                color: isComplete
                    ? context.colors.primary
                    : context.colors.textSecondary,
                fontWeight: isComplete ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
        if (!isComplete) ...[
          const SizedBox(height: AppSpacing.space8),
          Text(
            'Both are needed to estimate your commute time and know when to '
            'remind you to leave.',
            style: AppTypography.caption(
              context,
            )?.copyWith(color: context.colors.textSecondary),
          ),
        ],
      ],
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

/// Debug-only readout of what's actually scheduled with the OS right now —
/// ground truth from the notifications plugin (id + content), joined with
/// the fire time computed from [alertMinuteOfDay] (the "leave now" time)
/// and [headsUpLeadMinutes] (subtracted from it for the earlier heads-up),
/// keyed by the known [kLeaveNowNotificationId]/[kHeadsUpNotificationId]
/// constants since the plugin itself doesn't report scheduled times. An
/// empty list here at a time you expected a notification means it was
/// silently skipped (e.g. the heads-up/leave-now time had already passed
/// when `scheduleTodayReminders` last ran).
class _DebugPendingNotificationsCard extends StatefulWidget {
  const _DebugPendingNotificationsCard({
    required this.alertMinuteOfDay,
    required this.headsUpLeadMinutes,
  });

  final int? alertMinuteOfDay;
  final int headsUpLeadMinutes;

  @override
  State<_DebugPendingNotificationsCard> createState() =>
      _DebugPendingNotificationsCardState();
}

class _DebugPendingNotificationsCardState
    extends State<_DebugPendingNotificationsCard> {
  late Future<List<ScheduledNotificationInfo>> _pending;

  @override
  void initState() {
    super.initState();
    _pending = getIt<NotificationService>().pendingNotifications();
  }

  void _refresh() {
    setState(() {
      _pending = getIt<NotificationService>().pendingNotifications();
    });
  }

  String? _fireTimeFor(int id) {
    final alert = widget.alertMinuteOfDay;
    if (alert == null) return null;
    if (id == kLeaveNowNotificationId) return TimeFormat.hhMm(alert);
    if (id == kHeadsUpNotificationId) {
      return TimeFormat.hhMm(alert - widget.headsUpLeadMinutes);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '🐛 Scheduled notifications (debug)',
                  style: AppTypography.label(context),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Refresh',
                  onPressed: _refresh,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space8),
            FutureBuilder<List<ScheduledNotificationInfo>>(
              future: _pending,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSpacing.space8,
                      ),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                final pending = snapshot.data!;
                if (pending.isEmpty) {
                  return Text(
                    'None currently scheduled',
                    style: AppTypography.body(
                      context,
                    )?.copyWith(color: context.colors.textSecondary),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final notification in pending) ...[
                      Text(
                        '#${notification.id} — '
                        '${notification.title ?? '(no title)'}',
                        style: AppTypography.body(
                          context,
                        )?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Fires at '
                        '${_fireTimeFor(notification.id) ?? 'unknown'}',
                        style: AppTypography.body(
                          context,
                        )?.copyWith(color: context.colors.textSecondary),
                      ),
                      Text(
                        notification.body ?? '(no body)',
                        style: AppTypography.body(context),
                      ),
                      if (notification != pending.last)
                        const SizedBox(height: AppSpacing.space8),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CommuteReadoutCard extends StatelessWidget {
  const _CommuteReadoutCard({
    required this.minutes,
    required this.averageMinutes,
    required this.updatedAt,
    required this.isRefreshing,
    required this.onRefresh,
  });

  final int? minutes;
  final int? averageMinutes;
  final DateTime? updatedAt;
  final bool isRefreshing;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final updatedText = updatedAt != null
        ? 'updated ${TimeFormat.hhMmFromDateTime(updatedAt!)}'
        : null;

    String line1;
    String? line2;
    if (minutes == null) {
      line1 = 'No commute estimate yet';
    } else if (averageMinutes == null) {
      // Exactly one sample — an "average" identical to the latest reading
      // would read as a copy bug, so it's omitted until there's a real one.
      line1 = '$minutes min drive';
      line2 =
          'Average appears after a few more refreshes'
          '${updatedText != null ? ' · $updatedText' : ''}';
    } else {
      line1 = '$minutes min drive · avg $averageMinutes min';
      line2 = updatedText;
    }

    return ShadowCard(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(line1, style: AppTypography.body(context)),
                  if (line2 != null) ...[
                    const SizedBox(height: AppSpacing.space4),
                    Text(
                      line2,
                      style: AppTypography.caption(
                        context,
                      )?.copyWith(color: context.colors.textSecondary),
                    ),
                  ],
                ],
              ),
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
