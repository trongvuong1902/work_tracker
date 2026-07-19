import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/home/presentation/cubit/home_page_cubit.dart';
import 'package:work_tracker/features/home/presentation/widgets/attendance_card/attendance_card.dart';
import 'package:work_tracker/features/home/presentation/widgets/hero_card/hero_card_view.dart';
import 'package:work_tracker/features/home/presentation/widgets/today_activity_timeline/today_activity_timeline_view.dart';
import 'package:work_tracker/features/home/presentation/widgets/today_work_items/today_work_items_view.dart';
import 'package:work_tracker/features/home/presentation/widgets/tomorrow_preview/tomorrow_preview_view.dart';
import 'package:work_tracker/features/leave_reminder/presentation/widgets/leave_reminder_setup_sheet.dart';

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
                      const HeroCardView(),
                      const TodayTasksView(),
                      const AttendanceCardView(),
                      const TodayActivityTimelineView(),
                      const TomorrowPreviewView(),
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
