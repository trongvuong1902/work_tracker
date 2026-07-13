import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/cubit/app_cubit.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/radius/app_radius.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/schedule/presentation/cubit/setting_schedule_cubit.dart';

class SettingSchedulePage extends StatefulWidget {
  const SettingSchedulePage({super.key});

  @override
  State<SettingSchedulePage> createState() => _SettingSchedulePageState();
}

class _SettingSchedulePageState extends State<SettingSchedulePage> {
  static const _weekdayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SettingScheduleCubit>(),
      child: BlocBuilder<SettingScheduleCubit, SettingScheduleState>(
        builder: (context, state) {
          final cubit = context.read<SettingScheduleCubit>();
          final appStatus = context.watch<AppCubit>().state.status;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Setting Schedule'),
              actions: [
                TextButton(
                  onPressed: () {
                    context.read<AppCubit>().skipScheduleSetup();
                    AppNavigator.goHome(context);
                  },
                  child: Text(state.isEditing ? 'Cancel' : 'Skip'),
                ),
              ],
            ),
            body: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.space16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                _PurposeBanner(appStatus: appStatus),
                                const SizedBox(height: AppSpacing.space16),
                                _TimeRow(
                                  label: 'Start time',
                                  minuteOfDay: state.startMinuteOfDay,
                                  onChanged: cubit.updateStartMinute,
                                ),
                                const SizedBox(height: AppSpacing.space16),
                                _TimeRow(
                                  label: 'End time',
                                  minuteOfDay: state.endMinuteOfDay,
                                  onChanged: cubit.updateEndMinute,
                                ),
                                const SizedBox(height: AppSpacing.space16),
                                ShadowCard(
                                  margin: EdgeInsets.zero,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      AppSpacing.space16,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Lunch break',
                                          style: AppTypography.label(context),
                                        ),
                                        const SizedBox(
                                          height: AppSpacing.space8,
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.remove,
                                              ),
                                              onPressed: () => cubit
                                                  .updateLunchMinutes(
                                                    state.lunchMinutes - 15,
                                                  ),
                                            ),
                                            Text(
                                              '${state.lunchMinutes} min',
                                              style: AppTypography.body(
                                                context,
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              onPressed: () => cubit
                                                  .updateLunchMinutes(
                                                    state.lunchMinutes + 15,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.space16),
                                ShadowCard(
                                  margin: EdgeInsets.zero,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      AppSpacing.space16,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Working days',
                                          style: AppTypography.label(context),
                                        ),
                                        const SizedBox(
                                          height: AppSpacing.space8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: List.generate(7, (index) {
                                            final weekday = index + 1;
                                            final isSelected =
                                                (state.workingDaysMask &
                                                    (1 << index)) !=
                                                0;
                                            return GestureDetector(
                                              onTap: () =>
                                                  cubit.toggleWorkingDay(
                                                    weekday,
                                                  ),
                                              child: Container(
                                                width: 36,
                                                height: 36,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? AppColors.primary
                                                      : AppColors
                                                            .surfaceSecondary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        AppRadius.radius24,
                                                      ),
                                                  border: isSelected
                                                      ? null
                                                      : Border.all(
                                                          color:
                                                              AppColors.outline,
                                                        ),
                                                ),
                                                child: Text(
                                                  _weekdayLabels[index],
                                                  style: AppTypography.label(
                                                    context,
                                                  )?.copyWith(
                                                    color: isSelected
                                                        ? Colors.white
                                                        : AppColors
                                                              .textSecondary,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (state.errorMessage != null) ...[
                                  const SizedBox(height: AppSpacing.space16),
                                  Text(
                                    state.errorMessage!,
                                    style: AppTypography.body(
                                      context,
                                    )?.copyWith(color: AppColors.error),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.space16),
                          PrimaryButton(
                            label: 'Save',
                            isLoading: state.isSaving,
                            onPressed: () async {
                              final success = await cubit.save();
                              if (success && context.mounted) {
                                context.read<AppCubit>().onScheduleSaved();
                                AppNavigator.goHome(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class _PurposeBanner extends StatelessWidget {
  const _PurposeBanner({required this.appStatus});

  final AppStatus appStatus;

  @override
  Widget build(BuildContext context) {
    final (title, body) = appStatus == AppStatus.setupSchedule
        ? (
            'One last step',
            'Set your work hours so we can track your check-ins and '
                'automatically calculate hours, lateness, and overtime.',
          )
        : (
            'Schedule required to check in',
            'You need a work schedule before you can check in. Set it up '
                'below — it only takes a minute.',
          );

    return ShadowCard(
      color: AppColors.primaryLight,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTypography.subtitle(
                context,
              )?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(
              body,
              style: AppTypography.body(
                context,
              )?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeRow extends StatelessWidget {
  const _TimeRow({
    required this.label,
    required this.minuteOfDay,
    required this.onChanged,
  });

  final String label;
  final int minuteOfDay;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final time = TimeOfDay(
      hour: minuteOfDay ~/ 60,
      minute: minuteOfDay % 60,
    );

    return ShadowCard(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.radius8),
        onTap: () async {
          final result = await showAppTimePicker(
            context: context,
            initialTime: time,
          );
          if (result != null) {
            onChanged(result.hour * 60 + result.minute);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTypography.label(context)),
              Text(time.format(context), style: AppTypography.body(context)),
            ],
          ),
        ),
      ),
    );
  }
}
