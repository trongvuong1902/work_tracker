import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/calendar/domain/models/calendar_day.dart';
import 'package:work_tracker/features/calendar/domain/models/day_status.dart';
import 'package:work_tracker/features/calendar/presentation/cubit/calendar_cubit.dart';
import 'package:work_tracker/features/calendar/presentation/cubit/calendar_state.dart';
import 'package:work_tracker/features/calendar/presentation/widgets/day_summary_view.dart';
import 'package:work_tracker/features/calendar/presentation/widgets/month_grid.dart';
import 'package:work_tracker/features/calendar/presentation/widgets/month_header.dart';
import 'package:work_tracker/features/calendar/presentation/widgets/month_summary_row.dart';
import 'package:work_tracker/features/calendar/presentation/widgets/weekday_row.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CalendarCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.space16),
            child: BlocBuilder<CalendarCubit, CalendarState>(
              builder: (context, state) {
                if (state.isLoading && state.days.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.errorMessage != null && state.days.isEmpty) {
                  return Center(
                    child: Text(
                      state.errorMessage!,
                      style: AppTypography.body(
                        context,
                      )?.copyWith(color: context.colors.error),
                    ),
                  );
                }

                final selectedDay = state.days.firstWhere(
                  (day) => day.isSelected,
                  orElse: () => CalendarDayModel(
                    date: state.selectedDate,
                    isCurrentMonth: true,
                    isToday: false,
                    isSelected: true,
                    status: DayStatus.none,
                  ),
                );

                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MonthSummaryRow(summary: state.summary),
                      const SizedBox(height: AppSpacing.space16),
                      MonthHeader(month: DateTime(state.year, state.month)),
                      const SizedBox(height: AppSpacing.space8),
                      const WeekdayRow(),
                      const SizedBox(height: AppSpacing.space8),
                      ShadowCard(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.space8),
                          child: MonthGrid(days: state.days),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.space16),
                      DaySummaryView(day: selectedDay),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
