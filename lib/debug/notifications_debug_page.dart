import 'package:flutter/material.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/core/notifications/notification_service.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/attendance/domain/attendance_repository.dart';
import 'package:work_tracker/features/checkout_reminder/checkout_reminder_constants.dart';
import 'package:work_tracker/features/checkout_reminder/domain/checkout_reminder_repository.dart';
import 'package:work_tracker/features/checkout_reminder/domain/models/checkout_reminder_settings.dart';
import 'package:work_tracker/features/checkout_reminder/presentation/widgets/checkout_reminder_setup_sheet.dart';
import 'package:work_tracker/features/leave_reminder/leave_reminder_constants.dart';
import 'package:work_tracker/features/leave_reminder/presentation/widgets/leave_reminder_setup_sheet.dart';
import 'package:work_tracker/features/schedule/domain/models/work_schedule.dart';
import 'package:work_tracker/features/schedule/domain/work_schedule_repository.dart';

/// Debug-only page for exercising notification flows end-to-end, without
/// waiting for real clock time to elapse — covers both Checkout Reminder
/// (checkout reminder + end-of-work) and Leave Reminder (heads-up +
/// leave-now). Reachable only via the [ComponentsShowcasePage] "Flows"
/// section, which is itself only reachable via the `kDebugMode`-gated
/// "Debug tools" tile on the Settings page — this page intentionally isn't
/// self-gated, same as the rest of the debug tooling.
///
/// Note for testers: Android notification channels (e.g.
/// `leave_reminder_channel`) are immutable once created on a device — if a
/// channel was already created with different settings during an earlier
/// test, changes to channel importance won't take effect until the app is
/// uninstalled/reinstalled, or the channel is reset in system notification
/// settings.
class NotificationsDebugPage extends StatelessWidget {
  const NotificationsDebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications (debug)')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.space16),
        children: const [
          _WarningBanner(),
          SizedBox(height: AppSpacing.space24),
          _SectionTitle('Fire test notification now'),
          SizedBox(height: AppSpacing.space12),
          _FireNowSection(),
          SizedBox(height: AppSpacing.space24),
          _SectionTitle('Simulate attendance'),
          SizedBox(height: AppSpacing.space12),
          _SimulateAttendanceSection(),
          SizedBox(height: AppSpacing.space24),
          _OpenSettingsSection(),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTypography.title(context));
  }
}

class _WarningBanner extends StatelessWidget {
  const _WarningBanner();

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: EdgeInsets.zero,
      color: context.colors.error.withValues(alpha: 0.08),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.warning_amber_rounded, color: context.colors.error),
            const SizedBox(width: AppSpacing.space12),
            Expanded(
              child: Text(
                'This simulates real attendance check-in/check-out, '
                "overwriting today's actual attendance record. Use the "
                '`dev` build flavor for testing, not `prod`, to avoid '
                'clobbering real data.',
                style: AppTypography.body(
                  context,
                )?.copyWith(color: context.colors.error),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FireNowSection extends StatelessWidget {
  const _FireNowSection();

  /// Ensures notification authorization is granted before firing a debug
  /// test notification — mirrors the real "enable Leave/Checkout Reminder"
  /// flows, which also gate on `requestPermission()` before ever scheduling.
  /// Without this, a fresh install that never went through either enable
  /// flow has no notification authorization at all, so `scheduleAt()`
  /// silently no-ops (no banner, no sound) regardless of foreground/
  /// background state. Shows a SnackBar and returns `false` if denied.
  Future<bool> _ensureNotificationPermission(BuildContext context) async {
    final granted = await getIt<NotificationService>().requestPermission();
    if (!granted) {
      if (!context.mounted) return false;
      _showSnackBar(
        context,
        'Notifications are disabled for WorkTracker. Enable them in system '
        'settings to test this notification.',
      );
    }
    return granted;
  }

  Future<void> _fireCheckoutReminder(BuildContext context) async {
    if (!await _ensureNotificationPermission(context)) return;
    if (!context.mounted) return;
    await getIt<NotificationService>().scheduleAt(
      id: kCheckoutReminderNotificationId,
      title: '⏰ Time to check out',
      body: "Don't forget to check out at the machine.",
      scheduledDate: DateTime.now().add(const Duration(seconds: 10)),
    );
    if (!context.mounted) return;
    _showSnackBar(context, 'Scheduled — check your notification tray in ~10s.');
  }

  Future<void> _fireEndOfWork(BuildContext context) async {
    if (!await _ensureNotificationPermission(context)) return;
    if (!context.mounted) return;
    await getIt<NotificationService>().scheduleAt(
      id: kEndOfWorkNotificationId,
      title: '🔔 End of work',
      body: "Your scheduled work day is over — don't forget to check out!",
      scheduledDate: DateTime.now().add(const Duration(seconds: 10)),
      bypassSilentMode: true,
    );
    if (!context.mounted) return;
    _showSnackBar(context, 'Scheduled — check your notification tray in ~10s.');
  }

  Future<void> _fireHeadsUp(BuildContext context) async {
    if (!await _ensureNotificationPermission(context)) return;
    if (!context.mounted) return;
    await getIt<NotificationService>().scheduleAt(
      id: kHeadsUpNotificationId,
      title: '🌅 Time to plan your commute',
      body: 'Test heads-up notification (debug)',
      scheduledDate: DateTime.now().add(const Duration(seconds: 10)),
    );
    if (!context.mounted) return;
    _showSnackBar(context, 'Scheduled — check your notification tray in ~10s.');
  }

  Future<void> _fireLeaveNow(BuildContext context) async {
    if (!await _ensureNotificationPermission(context)) return;
    if (!context.mounted) return;
    await getIt<NotificationService>().scheduleAt(
      id: kLeaveNowNotificationId,
      title: '🚗 Time to leave',
      body: 'Test leave-now notification (debug)',
      scheduledDate: DateTime.now().add(const Duration(seconds: 10)),
    );
    if (!context.mounted) return;
    _showSnackBar(context, 'Scheduled — check your notification tray in ~10s.');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Checkout Reminder',
          style: AppTypography.label(context)?.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.space8),
        SecondaryButton(
          label: 'Fire checkout reminder in 10s',
          onPressed: () => _fireCheckoutReminder(context),
        ),
        const SizedBox(height: AppSpacing.space12),
        SecondaryButton(
          label: 'Fire end-of-work in 10s',
          onPressed: () => _fireEndOfWork(context),
        ),
        const SizedBox(height: AppSpacing.space16),
        Text(
          'Leave Reminder',
          style: AppTypography.label(context)?.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.space8),
        SecondaryButton(
          label: 'Fire heads-up in 10s',
          onPressed: () => _fireHeadsUp(context),
        ),
        const SizedBox(height: AppSpacing.space12),
        SecondaryButton(
          label: 'Fire leave-now in 10s',
          onPressed: () => _fireLeaveNow(context),
        ),
      ],
    );
  }
}

class _SimulateAttendanceSection extends StatefulWidget {
  const _SimulateAttendanceSection();

  @override
  State<_SimulateAttendanceSection> createState() =>
      _SimulateAttendanceSectionState();
}

class _SimulateAttendanceSectionState
    extends State<_SimulateAttendanceSection> {
  late Future<WorkSchedule?> _activeSchedule;
  late Future<CheckoutReminderSettings> _reminderSettings;

  @override
  void initState() {
    super.initState();
    _activeSchedule = getIt<WorkScheduleRepository>().getCurrentActiveSchedule();
    _reminderSettings = getIt<CheckoutReminderRepository>().getSettings();
  }

  void _refreshReminderSettings() {
    setState(() {
      _reminderSettings = getIt<CheckoutReminderRepository>().getSettings();
    });
  }

  /// Ensures Checkout Reminder is enabled before simulating a check-in, so
  /// the debug card in the settings sheet always has something to show —
  /// otherwise `CheckoutReminderRepositoryImpl._evaluate()` silently no-ops
  /// on a disabled feature (correct production behavior, but confusing when
  /// testing). Returns `false` (and shows a SnackBar) if enabling fails,
  /// in which case the caller should not proceed with the check-in.
  Future<bool> _ensureReminderEnabled() async {
    final repo = getIt<CheckoutReminderRepository>();
    final settings = await repo.getSettings();
    if (settings.enabled) return true;

    final result = await repo.setEnabled(true);
    _refreshReminderSettings();
    if (result == EnableCheckoutReminderResult.notificationPermissionDenied) {
      if (!mounted) return false;
      _showSnackBar(
        context,
        'Notification permission denied — grant it in system settings to '
        'test the checkout reminder flow.',
      );
      return false;
    }
    return true;
  }

  Future<void> _checkInOnTime() async {
    if (!await _ensureReminderEnabled()) return;
    if (!mounted) return;
    final now = DateTime.now();
    await getIt<AttendanceRepository>().checkIn(now);
    if (!mounted) return;
    _showSnackBar(
      context,
      'Checked in at ${TimeFormat.hhMmFromDateTime(now)} — on time',
    );
  }

  Future<void> _checkInLate(int offsetMinutes) async {
    final schedule = await _activeSchedule;
    if (schedule == null) return;
    if (!await _ensureReminderEnabled()) return;
    if (!mounted) return;
    final now = DateTime.now();
    final checkInTime = DateTime(
      now.year,
      now.month,
      now.day,
    ).add(Duration(minutes: schedule.startMinuteOfDay + offsetMinutes));
    await getIt<AttendanceRepository>().checkIn(checkInTime);
    if (!mounted) return;
    _showSnackBar(
      context,
      'Checked in at ${TimeFormat.hhMmFromDateTime(checkInTime)} — '
      '$offsetMinutes min late',
    );
  }

  Future<void> _checkOutNow() async {
    final now = DateTime.now();
    await getIt<AttendanceRepository>().checkOut(now);
    if (!mounted) return;
    _showSnackBar(
      context,
      'Checked out at ${TimeFormat.hhMmFromDateTime(now)}',
    );
  }

  void _clearAttendance() {
    getIt<AttendanceRepository>().clearTodayAttendance();
    _showSnackBar(context, "Today's attendance cleared");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CheckoutReminderSettings>(
      future: _reminderSettings,
      builder: (context, reminderSnapshot) {
        final reminderEnabled = reminderSnapshot.data?.enabled ?? false;
        final reminderLoaded =
            reminderSnapshot.connectionState == ConnectionState.done;

        return FutureBuilder<WorkSchedule?>(
          future: _activeSchedule,
          builder: (context, snapshot) {
            final hasSchedule = snapshot.data != null;
            final scheduleLoaded =
                snapshot.connectionState == ConnectionState.done;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (reminderLoaded) ...[
                  Text(
                    reminderEnabled
                        ? 'Checkout reminder: Enabled'
                        : 'Checkout reminder: Disabled — will be enabled '
                              'automatically when you check in',
                    style: AppTypography.caption(context)?.copyWith(
                      color: reminderEnabled
                          ? context.colors.primary
                          : context.colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space12),
                ],
                SecondaryButton(
                  label: 'Check in now (on time)',
                  onPressed: _checkInOnTime,
                ),
                const SizedBox(height: AppSpacing.space12),
                SecondaryButton(
                  label: 'Check in — 15 min late',
                  onPressed: hasSchedule ? () => _checkInLate(15) : null,
                ),
                const SizedBox(height: AppSpacing.space12),
                SecondaryButton(
                  label: 'Check in — 30 min late',
                  onPressed: hasSchedule ? () => _checkInLate(30) : null,
                ),
                if (scheduleLoaded && !hasSchedule) ...[
                  const SizedBox(height: AppSpacing.space8),
                  Text(
                    'No active work schedule — set one up to test late '
                    'check-in.',
                    style: AppTypography.caption(
                      context,
                    )?.copyWith(color: context.colors.textSecondary),
                  ),
                ],
                const SizedBox(height: AppSpacing.space12),
                SecondaryButton(
                  label: 'Check out now',
                  onPressed: _checkOutNow,
                ),
                const SizedBox(height: AppSpacing.space12),
                TextButton(
                  onPressed: _clearAttendance,
                  style: TextButton.styleFrom(
                    foregroundColor: context.colors.error,
                  ),
                  child: const Text("Clear today's attendance"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _OpenSettingsSection extends StatelessWidget {
  const _OpenSettingsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryButton(
          label: 'Open Checkout Reminder settings',
          onPressed: () => showCheckoutReminderSetupSheet(context),
        ),
        const SizedBox(height: AppSpacing.space12),
        PrimaryButton(
          label: 'Open Leave Reminder settings',
          onPressed: () => showLeaveReminderSetupSheet(context),
        ),
      ],
    );
  }
}

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message)));
}
