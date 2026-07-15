import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
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
