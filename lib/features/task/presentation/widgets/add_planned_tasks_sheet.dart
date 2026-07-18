import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/task/domain/models/task.dart';
import 'package:work_tracker/features/task/presentation/cubit/plan_tasks_cubit.dart';
import 'package:work_tracker/features/task/presentation/widgets/priority_badge.dart';

/// Opens the "Add tasks to this day" picker for [day]: a multi-select list of
/// not-done, not-yet-planned tasks. Tapping a row shows its quick description;
/// confirming plans the selected tasks onto [day].
void showAddPlannedTasksSheet(BuildContext context, {required DateTime day}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => BlocProvider(
      create: (_) => getIt<PlanTasksCubit>()..init(),
      child: _AddPlannedTasksView(day: day),
    ),
  );
}

class _AddPlannedTasksView extends StatelessWidget {
  const _AddPlannedTasksView({required this.day});

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanTasksCubit, PlanTasksState>(
      builder: (context, state) {
        final cubit = context.read<PlanTasksCubit>();
        return SafeArea(
          top: false,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
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
                  Text('Add tasks', style: AppTypography.title(context)),
                  const SizedBox(height: AppSpacing.space12),
                  if (state.isLoading)
                    const Padding(
                      padding: EdgeInsets.all(AppSpacing.space24),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (state.candidates.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.space16,
                      ),
                      child: Text(
                        'No unplanned tasks. Every open task already has a '
                        'planned day.',
                        style: AppTypography.body(context)?.copyWith(
                          color: context.colors.textSecondary,
                        ),
                      ),
                    )
                  else
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.candidates.length,
                        itemBuilder: (context, index) {
                          final task = state.candidates[index];
                          return _CandidateRow(
                            task: task,
                            selected: state.selectedIds.contains(task.id),
                            onToggle: () => cubit.toggle(task.id),
                            onShowDescription: () =>
                                _showQuickDescription(context, task),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: AppSpacing.space16),
                  PrimaryButton(
                    label: state.selectedIds.isEmpty
                        ? 'Add tasks'
                        : 'Add ${state.selectedIds.length} task(s)',
                    icon: Icons.event_available,
                    isLoading: state.isSaving,
                    onPressed: state.selectedIds.isEmpty
                        ? null
                        : () => _confirm(context, cubit),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirm(BuildContext context, PlanTasksCubit cubit) async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final count = await cubit.confirm(day);
    navigator.pop();
    messenger.showSnackBar(
      SnackBar(content: Text('Planned $count task(s)')),
    );
  }

  void _showQuickDescription(BuildContext context, Task task) {
    final description = (task.description ?? '').trim();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(sheetContext).size.height * 0.7,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.space16,
              0,
              AppSpacing.space16,
              AppSpacing.space24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (task.externalId != null)
                  Text(
                    '#${task.externalId}',
                    style: AppTypography.caption(sheetContext)?.copyWith(
                      color: sheetContext.colors.textSecondary,
                    ),
                  ),
                const SizedBox(height: AppSpacing.space4),
                Text(task.title, style: AppTypography.title(sheetContext)),
                const SizedBox(height: AppSpacing.space12),
                Flexible(
                  child: SingleChildScrollView(
                    child: Text(
                      description.isEmpty ? 'No description.' : description,
                      style: AppTypography.body(sheetContext),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CandidateRow extends StatelessWidget {
  const _CandidateRow({
    required this.task,
    required this.selected,
    required this.onToggle,
    required this.onShowDescription,
  });

  final Task task;
  final bool selected;
  final VoidCallback onToggle;
  final VoidCallback onShowDescription;

  @override
  Widget build(BuildContext context) {
    final priority = task.priority;
    return Row(
      children: [
        Checkbox(
          value: selected,
          onChanged: (_) => onToggle(),
          activeColor: context.colors.primary,
        ),
        if (priority != null) ...[
          PriorityBadge(priority: priority),
          const SizedBox(width: AppSpacing.space8),
        ],
        Expanded(
          child: InkWell(
            onTap: onShowDescription,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.space8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (task.externalId != null)
                    Text(
                      '#${task.externalId}',
                      style: AppTypography.caption(context)?.copyWith(
                        color: context.colors.textSecondary,
                      ),
                    ),
                  Text(
                    task.title,
                    style: AppTypography.body(context),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.space4),
        Icon(
          Icons.info_outline,
          size: 18,
          color: context.colors.textSecondary,
        ),
      ],
    );
  }
}
