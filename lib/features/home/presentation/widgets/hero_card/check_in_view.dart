import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/components/buttons/primary_button.dart';
import 'package:work_tracker/components/card/shadow_card.dart';
import 'package:work_tracker/components/inputs/app_time_picker.dart';
import 'package:work_tracker/features/home/presentation/cubit/home_page_cubit.dart';

class CheckInView extends StatelessWidget {
  const CheckInView({super.key});
  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Text(
            'Ready to start your day?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'You have not checked in yet.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PrimaryButton(
              onPressed: () =>
                  _handleCheckIn(context, context.read<HomePageCubit>()),
              label: 'Check In',
            ),
          ),
        ],
      ),
    );
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
