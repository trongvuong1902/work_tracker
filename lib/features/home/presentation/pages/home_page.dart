import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/home/presentation/cubit/home_page_cubit.dart';
import 'package:work_tracker/features/home/presentation/widgets/attendance_card/attendance_card.dart';
import 'package:work_tracker/features/home/presentation/widgets/hero_card/hero_card_view.dart';
import 'package:work_tracker/features/leave_reminder/presentation/widgets/leave_reminder_setup_sheet.dart';

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

/// Formats a minute-of-day offset (e.g. 1080) as `HH:mm` (e.g. "18:00").
String _formatMinuteOfDay(int minuteOfDay) {
  final hours = (minuteOfDay ~/ 60) % 24;
  final minutes = minuteOfDay % 60;
  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
}

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
      child: BlocListener<HomePageCubit, HomePageState>(
        listenWhen: (previous, current) =>
            current.pendingLeaveReminderTrigger != null,
        listener: (context, state) {
          final cubit = context.read<HomePageCubit>();
          showLeaveReminderSetupSheet(
            context,
            trigger: state.pendingLeaveReminderTrigger,
          ).whenComplete(cubit.clearPendingLeaveReminderTrigger);
        },
        child: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            final cubit = context.read<HomePageCubit>();

            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      cubit.clearAll();
                    },
                  ),
                ],
              ),
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
                      HeroCardView(),
                      AttendanceCardView(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
