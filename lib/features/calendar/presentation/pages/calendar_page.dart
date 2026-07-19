import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/calendar/domain/models/calendar_day.dart';
import 'package:work_tracker/features/work_item/domain/models/work_item.dart';
import 'package:work_tracker/features/work_item/presentation/widgets/priority_badge.dart';
import 'package:work_tracker/features/calendar/domain/models/day_status.dart';
import 'package:work_tracker/features/calendar/presentation/cubit/calendar_cubit.dart';
import 'package:work_tracker/features/calendar/presentation/cubit/calendar_state.dart';
import 'package:work_tracker/features/calendar/presentation/widgets/day_summary_view.dart';
import 'package:work_tracker/features/calendar/presentation/widgets/month_grid.dart';
import 'package:work_tracker/features/calendar/presentation/widgets/month_header.dart';
import 'package:work_tracker/features/calendar/presentation/widgets/month_summary_row.dart';
import 'package:work_tracker/features/calendar/presentation/widgets/weekday_row.dart';
import 'package:work_tracker/features/work_item/presentation/widgets/add_planned_tasks_sheet.dart';

/// A task's inline info: line 1 = priority badge (or a done check) alongside
/// `#id`; line 2 = title (strikethrough when done); optional product line.
/// Read-only — never changes the task's status.
class _WorkItemInfoBody extends StatelessWidget {
  const _WorkItemInfoBody({required this.task, this.showProduct = false});

  final WorkItem task;
  final bool showProduct;

  @override
  Widget build(BuildContext context) {
    final done = task.done;
    final priority = task.priority;
    final product = task.zentaoProductName;
    final hasLeading = done || priority != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (done)
              Icon(Icons.check_circle, size: 18, color: context.colors.primary)
            else if (priority != null)
              PriorityBadge(priority: priority, size: 20),
            if (hasLeading) const SizedBox(width: AppSpacing.space8),
            if (task.externalId != null)
              Text(
                '#${task.externalId}',
                style: AppTypography.caption(context)?.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
          ],
        ),
        Text(
          task.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.body(context)?.copyWith(
            decoration: done ? TextDecoration.lineThrough : null,
            color: done ? context.colors.textSecondary : null,
          ),
        ),
        if (showProduct && product != null && product.isNotEmpty)
          Text(
            product,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.caption(context)?.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
      ],
    );
  }
}

/// The tasks the user planned for the selected day — informational rows
/// (priority · #id · title · product). Tapping opens the detail; swiping
/// removes the task from the day. It never changes the task's status.
class _PlannedTasksSection extends StatelessWidget {
  const _PlannedTasksSection({required this.tasks});

  final List<WorkItem> tasks;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CalendarCubit>();
    return ShadowCard(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space16,
          vertical: AppSpacing.space12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PLANNED TASKS · ${tasks.length}',
              style: AppTypography.caption(context)?.copyWith(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: AppSpacing.space4),
            for (final task in tasks)
              _PlannedTaskRow(
                key: ValueKey(task.id),
                task: task,
                onRemove: () => cubit.unplanTask(task.id),
              ),
          ],
        ),
      ),
    );
  }
}

class _PlannedTaskRow extends StatelessWidget {
  const _PlannedTaskRow({
    super.key,
    required this.task,
    required this.onRemove,
  });

  final WorkItem task;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey('planned-${task.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
        color: context.colors.error,
        child: const Icon(Icons.event_busy, color: Colors.white),
      ),
      confirmDismiss: (_) => _confirmRemove(context),
      onDismissed: (_) => onRemove(),
      child: InkWell(
        onTap: () => AppNavigator.pushTaskDetail(context, task.id),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.space8),
          child: Row(
            children: [
              Expanded(child: _WorkItemInfoBody(task: task, showProduct: true)),
              const SizedBox(width: AppSpacing.space8),
              const Icon(Icons.chevron_right, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmRemove(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Remove from this day'),
        content: Text('Un-plan "${task.title}" from this day?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

/// Read-only log of the tasks worked on the selected day (tracked time).
class _WorkedTasksSection extends StatelessWidget {
  const _WorkedTasksSection({required this.worked});

  final List<DayWorkedTask> worked;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space16,
          vertical: AppSpacing.space12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'WORKED · ${worked.length}',
              style: AppTypography.caption(context)?.copyWith(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: AppSpacing.space4),
            for (final item in worked)
              InkWell(
                onTap: () =>
                    AppNavigator.pushTaskDetail(context, item.task.id),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.space8,
                  ),
                  child: Row(
                    children: [
                      Expanded(child: _WorkItemInfoBody(task: item.task)),
                      const SizedBox(width: AppSpacing.space8),
                      Text(
                        TimeFormat.hMm(item.seconds ~/ 60),
                        style: AppTypography.label(
                          context,
                        )?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

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
                      DaySummaryView(
                        day: selectedDay,
                        schedule: state.schedule,
                        isWorkingDay: state.isSelectedDateWorkingDay,
                        displayState: state.displayState,
                        errorMessage: state.editErrorMessage,
                      ),
                      if (state.workedTasksForSelectedDay.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.space16),
                        _WorkedTasksSection(
                          worked: state.workedTasksForSelectedDay,
                        ),
                      ],
                      const SizedBox(height: AppSpacing.space16),
                      SecondaryButton(
                        label: 'Add tasks',
                        icon: Icons.add,
                        onPressed: () => showAddPlannedTasksSheet(
                          context,
                          day: state.selectedDate,
                        ),
                      ),
                      if (state.plannedTasksForSelectedDay.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.space16),
                        _PlannedTasksSection(
                          tasks: state.plannedTasksForSelectedDay,
                        ),
                      ],
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
