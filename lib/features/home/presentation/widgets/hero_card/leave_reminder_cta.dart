import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/buttons/primary_button.dart';
import 'package:work_tracker/components/card/shadow_card.dart';
import 'package:work_tracker/components/inputs/app_time_picker.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/features/home/presentation/cubit/home_page_cubit.dart';
import 'package:work_tracker/features/home/presentation/widgets/hero_card/hero_card_model.dart';
import 'package:work_tracker/features/leave_reminder/presentation/widgets/leave_reminder_setup_sheet.dart';

/// State A hero shown before check-in when there's no leave-home time to
/// display yet — explains why (via [ctaKind]) and, where there's something
/// actionable to do about it, offers the relevant setup shortcut. Check In
/// stays available regardless of [ctaKind].
class LeaveReminderCta extends StatelessWidget {
  const LeaveReminderCta({super.key, this.ctaKind});

  final LeaveReminderCtaKind? ctaKind;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ready to start your day?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.space8),
            Text(
              _message,
              textAlign: TextAlign.center,
              style: AppTypography.body(
                context,
              )?.copyWith(color: context.colors.textSecondary),
            ),
            if (_actionLabel != null) ...[
              const SizedBox(height: AppSpacing.space12),
              GestureDetector(
                onTap: () => _handleAction(context),
                child: Text(
                  _actionLabel!,
                  style: AppTypography.label(
                    context,
                  )?.copyWith(color: context.colors.primary),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.space16),
            PrimaryButton(
              onPressed: () =>
                  _handleCheckIn(context, context.read<HomePageCubit>()),
              label: 'Check In',
            ),
          ],
        ),
      ),
    );
  }

  String get _message {
    switch (ctaKind) {
      case LeaveReminderCtaKind.noActiveSchedule:
        return 'Set your work schedule to see when to leave.';
      case LeaveReminderCtaKind.remindersDisabled:
        return 'Turn on leave reminders to get your leave-home time.';
      case LeaveReminderCtaKind.learningCommute:
        return "We'll learn your commute after a couple of trips.";
      case LeaveReminderCtaKind.dayOff:
        return 'No work scheduled today — enjoy your day off.';
      case null:
        return 'You have not checked in yet.';
    }
  }

  String? get _actionLabel {
    switch (ctaKind) {
      case LeaveReminderCtaKind.noActiveSchedule:
        return 'Set up schedule →';
      case LeaveReminderCtaKind.remindersDisabled:
        return 'Turn on reminders →';
      case LeaveReminderCtaKind.learningCommute:
      case LeaveReminderCtaKind.dayOff:
      case null:
        return null;
    }
  }

  Future<void> _handleAction(BuildContext context) async {
    switch (ctaKind) {
      case LeaveReminderCtaKind.noActiveSchedule:
        await AppNavigator.pushWorkScheduleSettings(context);
      case LeaveReminderCtaKind.remindersDisabled:
        await showLeaveReminderSetupSheet(context);
      case LeaveReminderCtaKind.learningCommute:
      case LeaveReminderCtaKind.dayOff:
      case null:
        break;
    }
  }

  Future<void> _handleCheckIn(BuildContext context, HomePageCubit cubit) async {
    final schedule = cubit.state.workSchedule;

    if (!context.mounted) return;

    if (schedule == null) {
      AppNavigator.pushWorkScheduleSettings(context);
      return;
    }

    final result = await showAppTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (result == null || !context.mounted) return;

    final now = DateTime.now();
    cubit.checkIn(
      DateTime(now.year, now.month, now.day, result.hour, result.minute),
    );
  }
}
