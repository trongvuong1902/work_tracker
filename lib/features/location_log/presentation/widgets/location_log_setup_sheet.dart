import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/leave_reminder/presentation/widgets/leave_reminder_setup_sheet.dart';
import 'package:work_tracker/features/location_log/presentation/cubit/location_log_setup_cubit.dart';

/// Shows the location-activity setup sheet — accessible from Settings'
/// "Location activity" row.
Future<void> showLocationLogSetupSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => BlocProvider(
      create: (_) => getIt<LocationLogSetupCubit>(),
      child: const _LocationLogSetupSheet(),
    ),
  );
}

class _LocationLogSetupSheet extends StatelessWidget {
  const _LocationLogSetupSheet();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationLogSetupCubit, LocationLogSetupState>(
      builder: (context, state) {
        final cubit = context.read<LocationLogSetupCubit>();

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
                  'Location activity',
                  style: AppTypography.title(
                    context,
                  )?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSpacing.space8),
                Text(
                  'Automatically logs when you arrive at and leave work, '
                  'and fills in your check-in/check-out if not set yet.\n\n'
                  'To do this, WorkTracker collects your location in the '
                  'background — even when the app is closed or not in use — '
                  'during a short window around your scheduled work hours. '
                  'Location is only used to detect arrival at and departure '
                  'from your saved work location. It is stored on your device '
                  'and never sold or shared.',
                  style: AppTypography.body(
                    context,
                  )?.copyWith(color: context.colors.textSecondary),
                ),
                const SizedBox(height: AppSpacing.space16),
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
                              'Enable location activity',
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
                  ShadowCard(
                    margin: EdgeInsets.zero,
                    child: InkWell(
                      onTap: () async {
                        await showLeaveReminderSetupSheet(context);
                        if (context.mounted) cubit.refreshWorkLocationStatus();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.space16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Work location', style: AppTypography.label(context)),
                            Text(
                              state.hasWorkLocation ? '✓ set' : 'Not set',
                              style: AppTypography.body(context)?.copyWith(
                                color: state.hasWorkLocation
                                    ? context.colors.primary
                                    : context.colors.textSecondary,
                                fontWeight: state.hasWorkLocation
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (!state.hasWorkLocation) ...[
                    const SizedBox(height: AppSpacing.space8),
                    Text(
                      'A work location (and radius) is required — set it '
                      'from Leave reminders, shared between both features.',
                      style: AppTypography.caption(
                        context,
                      )?.copyWith(color: context.colors.textSecondary),
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
