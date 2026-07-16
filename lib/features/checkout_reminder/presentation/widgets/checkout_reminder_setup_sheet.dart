import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/notifications/notification_service.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/time/time_format.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/checkout_reminder/checkout_reminder_constants.dart';
import 'package:work_tracker/features/checkout_reminder/presentation/cubit/checkout_reminder_setup_cubit.dart';

/// Shows the checkout-reminder setup sheet — accessible from Settings.
Future<void> showCheckoutReminderSetupSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => BlocProvider(
      create: (_) => getIt<CheckoutReminderSetupCubit>(),
      child: const _CheckoutReminderSetupSheet(),
    ),
  );
}

class _CheckoutReminderSetupSheet extends StatelessWidget {
  const _CheckoutReminderSetupSheet();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutReminderSetupCubit, CheckoutReminderSetupState>(
      builder: (context, state) {
        final cubit = context.read<CheckoutReminderSetupCubit>();

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
                Text(
                  'Checkout reminder',
                  style: AppTypography.title(
                    context,
                  )?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSpacing.space16),
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
                              'Enable checkout reminder',
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
                    MinutePickerRow(
                      label: 'Notify before checkout',
                      minutes: state.leadMinutes,
                      options: kCheckoutReminderLeadOptions,
                      valueBuilder: (minutes) => '$minutes min',
                      onChanged: cubit.updateLeadMinutes,
                    ),
                  ],
                  if (kDebugMode) ...[
                    const SizedBox(height: AppSpacing.space16),
                    _DebugPendingNotificationsCard(
                      scheduledFireTime: state.scheduledFireTime,
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

/// Debug-only readout of what's actually scheduled with the OS right now —
/// ground truth from the notifications plugin (id + content), joined with
/// the fire time computed from today's attendance + settings via
/// `CheckoutReminderRepository.getScheduledFireTime()` (passed down as
/// [scheduledFireTime]), since the plugin itself doesn't report scheduled
/// times and the checkout reminder's fire time can't be derived statically
/// (it depends on today's check-in time). An empty list here at a time you
/// expected a notification means it was silently skipped (e.g. the fire
/// time had already passed when `_evaluate` last ran).
class _DebugPendingNotificationsCard extends StatefulWidget {
  const _DebugPendingNotificationsCard({required this.scheduledFireTime});

  final DateTime? scheduledFireTime;

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

                final fireTimeText = widget.scheduledFireTime != null
                    ? TimeFormat.hhMmFromDateTime(widget.scheduledFireTime!)
                    : null;

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
                        'Fires at ${fireTimeText ?? 'unknown'}',
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
