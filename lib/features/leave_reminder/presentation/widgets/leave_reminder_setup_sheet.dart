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
import 'package:work_tracker/features/leave_reminder/domain/leave_reminder_repository.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/commute_waypoint.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/leave_reminder_prompt_trigger.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/notification_log_entry.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/tomorrow_preview.dart';
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
                        (state.work != null ? 1 : 0) +
                        state.waypoints.length,
                    total: 2 + state.waypoints.length,
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
                  for (var i = 0; i < state.waypoints.length; i++) ...[
                    _StopRow(
                      position: i + 1,
                      waypoint: state.waypoints[i],
                      isToggling: state.togglingWaypointIndex == i,
                      isRemoving: state.removingWaypointIndex == i,
                      isRepicking: state.repickingWaypointIndex == i,
                      onToggle: (enabled) =>
                          cubit.setWaypointEnabledAt(i, enabled),
                      onRemove: () => cubit.removeWaypointAt(i),
                      onTap: () async {
                        final picked = await AppNavigator.pushLocationPicker(
                          context,
                          title: 'Edit stop',
                          initial: state.waypoints[i].location,
                        );
                        if (picked != null) {
                          cubit.setWaypointLocationAt(i, picked);
                        }
                      },
                    ),
                    const SizedBox(height: AppSpacing.space8),
                  ],
                  _AddStopSection(
                    stopCount: state.waypoints.length,
                    isAdding: state.isAddingWaypoint,
                    onAdd: () async {
                      final picked = await AppNavigator.pushLocationPicker(
                        context,
                        title: 'Add a stop',
                      );
                      if (picked != null) cubit.addWaypoint(picked);
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
                  if (state.work != null) ...[
                    const SizedBox(height: AppSpacing.space8),
                    MinutePickerRow(
                      label: 'Detection radius',
                      minutes: state.workRadiusMeters,
                      options: kWorkRadiusOptions,
                      unitLabel: 'm',
                      onChanged: cubit.updateWorkRadiusMeters,
                    ),
                  ],
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
                    const SizedBox(height: AppSpacing.space16),
                    _DebugTomorrowPreviewCard(
                      headsUpLeadMinutes: state.headsUpLeadMinutes,
                    ),
                    const SizedBox(height: AppSpacing.space16),
                    const _DebugNotificationLogCard(),
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
  const _LocationsHeader({required this.setCount, required this.total});

  final int setCount;
  final int total;

  @override
  Widget build(BuildContext context) {
    final isComplete = setCount >= total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Locations', style: AppTypography.label(context)),
            Text(
              '$setCount of $total set',
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

/// A single "stop" (commute waypoint) row, sitting between the Home and
/// Work rows. Displays its position among stops (1-based, renumbered
/// whenever an earlier stop is removed), its resolved address (dimmed when
/// disabled), and trailing enable/disable + delete controls.
class _StopRow extends StatelessWidget {
  const _StopRow({
    required this.position,
    required this.waypoint,
    required this.isToggling,
    required this.isRemoving,
    required this.isRepicking,
    required this.onToggle,
    required this.onRemove,
    required this.onTap,
  });

  final int position;
  final CommuteWaypoint waypoint;
  final bool isToggling;
  final bool isRemoving;
  final bool isRepicking;
  final ValueChanged<bool> onToggle;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = waypoint.enabled;
    final busy = isToggling || isRemoving || isRepicking;
    final location = waypoint.location;
    final addressText =
        location.address ??
        '${location.latitude.toStringAsFixed(5)}, '
            '${location.longitude.toStringAsFixed(5)}';

    return ShadowCard(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: enabled ? context.colors.primary : null,
                border: enabled
                    ? null
                    : Border.all(color: context.colors.outline),
              ),
              child: Text(
                '$position',
                style: AppTypography.label(context)?.copyWith(
                  color: enabled ? Colors.white : context.colors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.space12),
            Expanded(
              child: InkWell(
                onTap: busy ? null : onTap,
                child: Text(
                  addressText,
                  style: AppTypography.label(context)?.copyWith(
                    color: enabled
                        ? context.colors.textPrimary
                        : context.colors.textSecondary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.space8),
            if (isRepicking)
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else ...[
              isToggling
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Checkbox(
                      value: enabled,
                      activeColor: context.colors.primary,
                      onChanged: isRemoving
                          ? null
                          : (value) => onToggle(value ?? false),
                    ),
              isRemoving
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : IconButton(
                      icon: const Icon(Icons.delete_outline),
                      tooltip: 'Remove stop',
                      onPressed: isToggling ? null : onRemove,
                    ),
            ],
          ],
        ),
      ),
    );
  }
}

/// "Add a stop" button, sitting directly after the last stop row (or the
/// Home row if there are none yet) and before the Work row. Replaced
/// entirely by a "cap reached" caption once 3 stops exist.
class _AddStopSection extends StatelessWidget {
  const _AddStopSection({
    required this.stopCount,
    required this.isAdding,
    required this.onAdd,
  });

  final int stopCount;
  final bool isAdding;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    if (stopCount >= kMaxCommuteWaypoints) {
      return Text(
        'Maximum of 3 stops reached.',
        style: AppTypography.caption(
          context,
        )?.copyWith(color: context.colors.textSecondary),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SecondaryButton(
          label: 'Add a stop',
          icon: Icons.add,
          isLoading: isAdding,
          onPressed: onAdd,
        ),
        if (stopCount == 0) ...[
          const SizedBox(height: AppSpacing.space8),
          Text(
            'Optional — add up to 3 stops along your commute.',
            style: AppTypography.caption(
              context,
            )?.copyWith(color: context.colors.textSecondary),
          ),
        ],
      ],
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

/// Debug-only preview of what tomorrow's heads-up and leave-now
/// notifications would look like, computed live from
/// [LeaveReminderRepository.getTomorrowPreview] rather than the OS's
/// pending-notifications list (nothing is scheduled for tomorrow yet — only
/// today's reminders are ever scheduled). The heads-up fire time is derived
/// here the same way [LeaveReminderRepositoryImpl.scheduleTodayReminders]
/// derives it for today: `leaveTime` minus [headsUpLeadMinutes].
class _DebugTomorrowPreviewCard extends StatefulWidget {
  const _DebugTomorrowPreviewCard({required this.headsUpLeadMinutes});

  final int headsUpLeadMinutes;

  @override
  State<_DebugTomorrowPreviewCard> createState() =>
      _DebugTomorrowPreviewCardState();
}

class _DebugTomorrowPreviewCardState
    extends State<_DebugTomorrowPreviewCard> {
  late Future<TomorrowPreview?> _preview;

  @override
  void initState() {
    super.initState();
    _preview = getIt<LeaveReminderRepository>().getTomorrowPreview();
  }

  void _refresh() {
    setState(() {
      _preview = getIt<LeaveReminderRepository>().getTomorrowPreview();
    });
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
                  "🌙 Tomorrow's reminders (debug)",
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
            FutureBuilder<TomorrowPreview?>(
              future: _preview,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    'Failed to load: ${snapshot.error}',
                    style: AppTypography.body(
                      context,
                    )?.copyWith(color: context.colors.error),
                  );
                }

                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSpacing.space8,
                      ),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                final preview = snapshot.data;
                if (preview == null) {
                  return Text(
                    'No preview available — reminders off, home/work not '
                    'set, fewer than 2 commute samples, or tomorrow isn\'t a '
                    'working day.',
                    style: AppTypography.body(
                      context,
                    )?.copyWith(color: context.colors.textSecondary),
                  );
                }

                final headsUpTime = preview.leaveTime.subtract(
                  Duration(minutes: widget.headsUpLeadMinutes),
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🌅 Time to plan your commute',
                      style: AppTypography.body(
                        context,
                      )?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Fires at ${TimeFormat.hhMmFromDateTime(headsUpTime)}',
                      style: AppTypography.body(
                        context,
                      )?.copyWith(color: context.colors.textSecondary),
                    ),
                    Text(preview.bodyText, style: AppTypography.body(context)),
                    const SizedBox(height: AppSpacing.space8),
                    Text(
                      '🚗 Time to leave',
                      style: AppTypography.body(
                        context,
                      )?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Fires at '
                      '${TimeFormat.hhMmFromDateTime(preview.leaveTime)}',
                      style: AppTypography.body(
                        context,
                      )?.copyWith(color: context.colors.textSecondary),
                    ),
                    Text(
                      'Your commute is about '
                      '${preview.averageCommuteMinutes} min — leave now.',
                      style: AppTypography.body(context),
                    ),
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

/// Debug-only persisted log of scheduled heads-up/leave-now notifications —
/// both already-fired history and still-upcoming entries — read from
/// [LeaveReminderRepository.getNotificationLog]. Unlike
/// [_DebugPendingNotificationsCard] (OS ground truth, upcoming only) this
/// survives past fire time, so it's useful for confirming a notification
/// was actually scheduled even after it already went off.
class _DebugNotificationLogCard extends StatefulWidget {
  const _DebugNotificationLogCard();

  @override
  State<_DebugNotificationLogCard> createState() =>
      _DebugNotificationLogCardState();
}

class _DebugNotificationLogCardState extends State<_DebugNotificationLogCard> {
  late Future<List<NotificationLogEntry>> _log;

  @override
  void initState() {
    super.initState();
    _log = getIt<LeaveReminderRepository>().getNotificationLog();
  }

  void _refresh() {
    setState(() {
      _log = getIt<LeaveReminderRepository>().getNotificationLog();
    });
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
                  '📜 Notification log (debug)',
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
            FutureBuilder<List<NotificationLogEntry>>(
              future: _log,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    'Failed to load: ${snapshot.error}',
                    style: AppTypography.body(
                      context,
                    )?.copyWith(color: context.colors.error),
                  );
                }

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

                final entries = snapshot.data!;
                final now = DateTime.now();
                final upcoming =
                    entries.where((e) => e.scheduledAt.isAfter(now)).toList()
                      ..sort(
                        (a, b) => a.scheduledAt.compareTo(b.scheduledAt),
                      );
                final history = entries
                    .where((e) => !e.scheduledAt.isAfter(now))
                    .toList(); // already most-recent-first from the repo

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upcoming',
                      style: AppTypography.body(
                        context,
                      )?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: AppSpacing.space8),
                    if (upcoming.isEmpty)
                      Text(
                        'Nothing scheduled right now',
                        style: AppTypography.body(
                          context,
                        )?.copyWith(color: context.colors.textSecondary),
                      )
                    else
                      _NotificationLogEntryList(entries: upcoming),
                    const SizedBox(height: AppSpacing.space16),
                    Text(
                      'History',
                      style: AppTypography.body(
                        context,
                      )?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: AppSpacing.space8),
                    if (history.isEmpty)
                      Text(
                        'No history yet',
                        style: AppTypography.body(
                          context,
                        )?.copyWith(color: context.colors.textSecondary),
                      )
                    else
                      _NotificationLogEntryList(entries: history),
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

class _NotificationLogEntryList extends StatelessWidget {
  const _NotificationLogEntryList({required this.entries});

  final List<NotificationLogEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final entry in entries) ...[
          Text(
            entry.title,
            style: AppTypography.body(
              context,
            )?.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            'Fires at ${TimeFormat.hhMmFromDateTime(entry.scheduledAt)}',
            style: AppTypography.body(
              context,
            )?.copyWith(color: context.colors.textSecondary),
          ),
          Text(entry.body, style: AppTypography.body(context)),
          if (entry != entries.last)
            const SizedBox(height: AppSpacing.space8),
        ],
      ],
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
