import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/task/domain/models/task.dart';
import 'package:work_tracker/features/task/presentation/cubit/task_time_log_cubit.dart';

/// "Manage task times": all per-day time logs grouped by date (newest first),
/// with edit/add/delete. Opened from the home "Today's tasks" section.
class TaskTimeLogPage extends StatelessWidget {
  const TaskTimeLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TaskTimeLogCubit>()..load(),
      child: const _TaskTimeLogView(),
    );
  }
}

class _TaskTimeLogView extends StatelessWidget {
  const _TaskTimeLogView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage task times')),
      floatingActionButton: BlocBuilder<TaskTimeLogCubit, TaskTimeLogState>(
        buildWhen: (a, b) => a.tasks != b.tasks,
        builder: (context, state) => FloatingActionButton(
          onPressed: state.tasks.isEmpty
              ? null
              : () => _showAddSheet(context, state.tasks),
          child: const Icon(Icons.add),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<TaskTimeLogCubit, TaskTimeLogState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage != null) {
              return Center(
                child: Text(
                  state.errorMessage!,
                  style: AppTypography.body(
                    context,
                  )?.copyWith(color: context.colors.error),
                ),
              );
            }
            if (state.groups.isEmpty) {
              return Center(
                child: Text(
                  'No tracked time yet.',
                  style: AppTypography.body(
                    context,
                  )?.copyWith(color: context.colors.textSecondary),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.space16),
              itemCount: state.groups.length,
              itemBuilder: (context, index) =>
                  _DayGroup(group: state.groups[index]),
            );
          },
        ),
      ),
    );
  }
}

class _DayGroup extends StatelessWidget {
  const _DayGroup({required this.group});

  final TaskTimeDayGroup group;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _dayLabel(group.day),
                  style: AppTypography.caption(context)?.copyWith(
                    color: context.colors.textSecondary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Text(
                TimeFormat.hMm(group.totalSeconds ~/ 60),
                style: AppTypography.caption(context)?.copyWith(
                  color: context.colors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space8),
          ShadowCard(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
                vertical: AppSpacing.space8,
              ),
              child: Column(
                children: [
                  for (final entry in group.entries)
                    _EntryRow(entry: entry, day: group.day),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EntryRow extends StatelessWidget {
  const _EntryRow({required this.entry, required this.day});

  final TaskTimeEntry entry;
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TaskTimeLogCubit>();
    return Dismissible(
      key: ValueKey(entry.logId),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
        color: context.colors.error,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (_) => _confirmDelete(context),
      onDismissed: (_) => cubit.deleteEntry(entry.logId),
      child: InkWell(
        onTap: () => _showEditDialog(context, entry),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.space12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  entry.title,
                  style: AppTypography.body(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppSpacing.space8),
              Text(
                TimeFormat.hMm(entry.seconds ~/ 60),
                style: AppTypography.label(
                  context,
                )?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: AppSpacing.space4),
              Icon(
                Icons.edit,
                size: 16,
                color: context.colors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete entry'),
        content: Text('Remove "${entry.title}" time for this day?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<void> _showEditDialog(BuildContext context, TaskTimeEntry entry) async {
    final cubit = context.read<TaskTimeLogCubit>();
    final seconds = await _pickDuration(context, entry.seconds);
    if (seconds != null) await cubit.editEntry(entry.logId, seconds);
  }
}

/// The add-entry sheet: pick a task, a date, and a duration.
Future<void> _showAddSheet(BuildContext context, List<Task> tasks) async {
  final cubit = context.read<TaskTimeLogCubit>();
  var selectedTaskId = tasks.first.id;
  var selectedDay = DateTime.now();

  final saved = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (sheetContext) {
      return StatefulBuilder(
        builder: (sheetContext, setState) {
          return SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.space16,
                0,
                AppSpacing.space16,
                AppSpacing.space16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add time', style: AppTypography.title(sheetContext)),
                  const SizedBox(height: AppSpacing.space16),
                  DropdownButtonFormField<int>(
                    initialValue: selectedTaskId,
                    isExpanded: true,
                    decoration: const InputDecoration(labelText: 'Task'),
                    items: [
                      for (final task in tasks)
                        DropdownMenuItem(
                          value: task.id,
                          child: Text(
                            task.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                    onChanged: (value) {
                      if (value != null) setState(() => selectedTaskId = value);
                    },
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.calendar_today),
                    title: Text(_dayLabel(selectedDay)),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: sheetContext,
                        initialDate: selectedDay,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) setState(() => selectedDay = picked);
                    },
                  ),
                  const SizedBox(height: AppSpacing.space16),
                  PrimaryButton(
                    label: 'Set duration & save',
                    icon: Icons.timer,
                    onPressed: () async {
                      final seconds = await _pickDuration(sheetContext, 0);
                      if (seconds != null && seconds > 0) {
                        await cubit.addEntry(
                          selectedTaskId,
                          selectedDay,
                          seconds,
                        );
                        if (sheetContext.mounted) {
                          Navigator.of(sheetContext).pop(true);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
  if (saved == true && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Time added')),
    );
  }
}

/// Hours + minutes editor returning the total seconds, or null if cancelled.
Future<int?> _pickDuration(BuildContext context, int initialSeconds) async {
  final hoursController = TextEditingController(
    text: (initialSeconds ~/ 3600).toString(),
  );
  final minutesController = TextEditingController(
    text: ((initialSeconds % 3600) ~/ 60).toString(),
  );

  return showDialog<int>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Duration'),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextField(
              controller: hoursController,
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Hours'),
            ),
          ),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: TextField(
              controller: minutesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Minutes'),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final hours = int.tryParse(hoursController.text.trim()) ?? 0;
            final minutes = int.tryParse(minutesController.text.trim()) ?? 0;
            Navigator.of(dialogContext).pop((hours * 60 + minutes) * 60);
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}

/// Weekday + day + month + year with a "Today"/"Yesterday" suffix (mirrors
/// `locationLogDayLabel`).
String _dayLabel(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final dateOnly = DateTime(date.year, date.month, date.day);

  final base =
      '${weekdayInitials[date.weekday - 1]}, ${date.day} '
      '${monthNames[date.month - 1]} ${date.year}';

  if (dateOnly == today) return '$base · Today';
  if (dateOnly == yesterday) return '$base · Yesterday';
  return base;
}
