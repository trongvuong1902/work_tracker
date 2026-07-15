import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/features/calendar/presentation/cubit/calendar_cubit.dart';

class MonthHeader extends StatelessWidget {
  final DateTime month;

  const MonthHeader({super.key, required this.month});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.read<CalendarCubit>().goToPreviousMonth(),
        ),
        Text(
          TimeFormat.monthYearLabel(month),
          style: AppTypography.title(context)?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () => context.read<CalendarCubit>().goToNextMonth(),
        ),
      ],
    );
  }
}
