import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/home/presentation/cubit/home_page_cubit.dart';

const _weekdayNames = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

const _monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    // Keeps the "worked so far" card live while checked in.
    _ticker = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomePageCubit>(),
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          final cubit = context.read<HomePageCubit>();

          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.space16),
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.space16),
                    const Text(
                      'Work Tracker',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space16),
                    _DateHeader(date: DateTime.now()),
                    const SizedBox(height: AppSpacing.space16),
                    _StatusBadge(state: state),
                    const SizedBox(height: AppSpacing.space24),
                    ..._buildAttendanceContent(context, cubit, state),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildAttendanceContent(
    BuildContext context,
    HomePageCubit cubit,
    HomePageState state,
  ) {
    if (state.checkInTime == null) {
      return [
        PrimaryButton(
          onPressed: () => _handleCheckIn(context, cubit),
          label: 'Check in',
        ),
      ];
    }

    final rows = <Widget>[
      TimePickerRow(
        label: 'Checked in at',
        value: state.checkInTime,
        onChanged: (time) => _submit(context, () => cubit.checkIn(time)),
      ),
      const SizedBox(height: AppSpacing.space16),
    ];

    if (state.checkOutTime == null) {
      rows.add(_WorkedTimeCard(since: state.checkInTime!));
      rows.add(const SizedBox(height: AppSpacing.space16));
      rows.add(
        PrimaryButton(
          label: 'Check out',
          onPressed: () => _handleCheckOut(context, cubit),
        ),
      );
    } else {
      rows.add(
        TimePickerRow(
          label: 'Checked out at',
          value: state.checkOutTime,
          onChanged: (time) => _submit(context, () => cubit.checkOut(time)),
        ),
      );
    }

    return rows;
  }

  Future<void> _handleCheckIn(BuildContext context, HomePageCubit cubit) async {
    await cubit.initialize();
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
    await _submit(
      context,
      () => cubit.checkIn(
        DateTime(now.year, now.month, now.day, result.hour, result.minute),
      ),
    );
  }

  Future<void> _handleCheckOut(
    BuildContext context,
    HomePageCubit cubit,
  ) async {
    final result = await showAppTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (result == null || !context.mounted) return;

    final now = DateTime.now();
    await _submit(
      context,
      () => cubit.checkOut(
        DateTime(now.year, now.month, now.day, result.hour, result.minute),
      ),
    );
  }

  Future<void> _submit(
    BuildContext context,
    Future<void> Function() action,
  ) async {
    try {
      await action();
    } on StateError catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }
}

class _DateHeader extends StatelessWidget {
  const _DateHeader({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final weekday = _weekdayNames[date.weekday - 1];
    final formattedDate =
        '${date.day} ${_monthNames[date.month - 1]} ${date.year}';

    return Column(
      children: [
        Text(
          weekday,
          style: AppTypography.title(
            context,
          )?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSpacing.space4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              formattedDate,
              style: AppTypography.title(
                context,
              )?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.state});

  final HomePageState state;

  @override
  Widget build(BuildContext context) {
    final String label;
    final Color color;
    if (state.checkOutTime != null) {
      label = 'Checked Out';
      color = AppColors.textPrimary;
    } else if (state.checkInTime != null) {
      label = 'Checked In';
      color = AppColors.primary;
    } else {
      label = 'Not Checked In';
      color = AppColors.textSecondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space16,
        vertical: AppSpacing.space8,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, size: 16, color: Colors.white),
          const SizedBox(width: AppSpacing.space8),
          Text(
            label,
            style: AppTypography.label(
              context,
            )?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _WorkedTimeCard extends StatelessWidget {
  const _WorkedTimeCard({required this.since});

  final DateTime since;

  @override
  Widget build(BuildContext context) {
    final elapsed = DateTime.now().difference(since);
    final duration = elapsed.isNegative ? Duration.zero : elapsed;
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    return ShadowCard(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Worked so far', style: AppTypography.label(context)),
            const SizedBox(height: AppSpacing.space4),
            Text(
              '${hours}h ${minutes}m',
              style: AppTypography.title(
                context,
              )?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
