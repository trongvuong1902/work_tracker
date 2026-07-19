import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/work_item/domain/models/work_item.dart';
import 'package:work_tracker/features/work_item/domain/models/work_item_source.dart';
import 'package:work_tracker/features/work_item/presentation/cubit/work_item_list_cubit.dart';
import 'package:work_tracker/features/work_item/presentation/widgets/priority_badge.dart';
import 'package:work_tracker/features/work_item/presentation/widgets/add_task_sheet.dart';
import 'package:work_tracker/features/work_item/presentation/widgets/bug_sync_runner.dart';
import 'package:work_tracker/features/zentao/data/zentao_sync_prefs.dart';
import 'package:work_tracker/features/zentao/domain/zentao_repository.dart';

/// The 3rd bottom-nav tab (replaces the old placeholder Insight/Statistics
/// tab) — the app's WorkItem List: manual + Zentao-imported tasks, tracked with
/// an Open/Done status and a start/stop timer (see `WorkItemDetailPage`).
class WorkItemListPage extends StatelessWidget {
  const WorkItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WorkItemListCubit>(),
      child: const _WorkItemListView(),
    );
  }
}

class _WorkItemListView extends StatefulWidget {
  const _WorkItemListView();

  @override
  State<_WorkItemListView> createState() => _WorkItemListViewState();
}

class _WorkItemListViewState extends State<_WorkItemListView> {
  Future<void> _openAddTaskSheet() async {
    final cubit = context.read<WorkItemListCubit>();
    final choice = await showAddTaskSheet(context);
    if (!mounted || choice == null) return;

    switch (choice) {
      case AddTaskChoice.manual:
        await AppNavigator.pushManualTaskForm(context);
      case AddTaskChoice.importPlatform:
        await AppNavigator.pushTaskImportPlatformPicker(context);
    }
    if (mounted) cubit.load();
  }

  Future<void> _openTaskDetail(int taskId) async {
    final cubit = context.read<WorkItemListCubit>();
    await AppNavigator.pushTaskDetail(context, taskId);
    if (mounted) cubit.load();
  }

  /// Sync button: re-sync the already-selected products directly. First time
  /// (not connected, or no product selection yet) routes into the connect /
  /// product-select flow instead. The list reloads reactively after the sync.
  Future<void> _syncBugs() async {
    final connection = await getIt<ZentaoRepository>().getConnection();
    if (!mounted) return;
    if (connection == null) {
      await AppNavigator.pushZentaoConnect(context);
      return;
    }
    if (getIt<ZentaoSyncPrefs>().hasSelection) {
      await runBugSyncWithProgress(context);
    } else {
      await AppNavigator.pushBugSyncProducts(context);
    }
  }

  /// "Choose products to sync" menu: always open the product picker to change
  /// the selection (which then runs the sync).
  Future<void> _chooseSyncProducts() async {
    final connection = await getIt<ZentaoRepository>().getConnection();
    if (!mounted) return;
    if (connection == null) {
      await AppNavigator.pushZentaoConnect(context);
    } else {
      await AppNavigator.pushBugSyncProducts(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkItemListCubit, WorkItemListState>(
      builder: (context, state) {
        final cubit = context.read<WorkItemListCubit>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tasks'),
            actions: [
              PopupMenuButton<WorkItemSort>(
                icon: const Icon(Icons.sort),
                tooltip: 'Sort',
                initialValue: state.sort,
                onSelected: cubit.setSort,
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: WorkItemSort.createdDesc,
                    child: Text('Newest first'),
                  ),
                  PopupMenuItem(
                    value: WorkItemSort.priority,
                    child: Text('Priority'),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.sync),
                tooltip: 'Sync bugs assigned to me',
                onPressed: _syncBugs,
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'chooseProducts') _chooseSyncProducts();
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: 'chooseProducts',
                    child: Text('Choose products to sync'),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.add),
                tooltip: 'Add task',
                onPressed: _openAddTaskSheet,
              ),
            ],
          ),
          body: SafeArea(child: _buildBody(context, state)),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, WorkItemListState state) {
    final cubit = context.read<WorkItemListCubit>();

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return _MessageView(
        icon: Icons.error_outline,
        title: 'Something went wrong',
        message: state.errorMessage!,
        primaryLabel: 'Retry',
        onPrimary: cubit.load,
      );
    }

    if (state.tasks.isEmpty) {
      return _MessageView(
        icon: Icons.checklist_rounded,
        title: 'No tasks yet',
        message:
            'Create a task manually, import one from Zentao, or sync the '
            'bugs assigned to you.',
        primaryLabel: 'Create task',
        onPrimary: () async {
          await AppNavigator.pushManualTaskForm(context);
          if (mounted) cubit.load();
        },
        secondaryLabel: 'Sync bugs assigned to me',
        onSecondary: _syncBugs,
      );
    }

    return RefreshIndicator(
      onRefresh: cubit.refreshFromServer,
      child: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.space16),
        itemCount: state.tasks.length,
        itemBuilder: (context, index) {
          final task = state.tasks[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space8),
            child: _WorkItemRow(
              task: task,
              onTap: () => _openTaskDetail(task.id),
            ),
          );
        },
      ),
    );
  }
}

class _WorkItemRow extends StatelessWidget {
  const _WorkItemRow({required this.task, required this.onTap});

  final WorkItem task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final priority = task.priority;
    final product = task.zentaoProductName;
    final typeIcon = _typeIconData();

    return ShadowCard(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Leading: colored priority badge, or a done/open circle for
              // tasks with no computed priority (e.g. manual tasks).
              if (priority != null)
                PriorityBadge(priority: priority, size: 34)
              else
                SizedBox(
                  width: 34,
                  child: Icon(
                    task.done
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: task.done
                        ? context.colors.primary
                        : context.colors.textSecondary,
                  ),
                ),
              const SizedBox(width: AppSpacing.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (typeIcon != null) ...[
                          Icon(
                            typeIcon,
                            size: 16,
                            color: _typeIconColor(context),
                          ),
                          const SizedBox(width: AppSpacing.space4),
                        ],
                        if (task.externalId != null)
                          Text(
                            '#${task.externalId}',
                            style: AppTypography.caption(context)?.copyWith(
                              color: context.colors.textSecondary,
                            ),
                          ),
                        const Spacer(),
                        _WorkItemStatusChip(task: task),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.space4),
                    Text(
                      task.title,
                      style: AppTypography.label(context)?.copyWith(
                        decoration:
                            task.done ? TextDecoration.lineThrough : null,
                        color:
                            task.done ? context.colors.textSecondary : null,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (product != null && product.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.space4),
                      Text(
                        product,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.caption(context)?.copyWith(
                          color: context.colors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.space8),
              Icon(Icons.chevron_right, color: context.colors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }

  IconData? _typeIconData() {
    switch (task.externalType) {
      case ExternalItemType.bug:
        return Icons.bug_report_outlined;
      case ExternalItemType.task:
        return Icons.assignment_outlined;
      case null:
        return null;
    }
  }

  Color _typeIconColor(BuildContext context) =>
      task.externalType == ExternalItemType.bug
      ? context.colors.warning
      : context.colors.secondary;
}

/// A small Active / Done / Closed pill derived from the task's state.
class _WorkItemStatusChip extends StatelessWidget {
  const _WorkItemStatusChip({required this.task});

  final WorkItem task;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isClosed = (task.externalStatus ?? '').trim().toLowerCase() == 'closed';
    final (label, color) = isClosed
        ? ('Closed', colors.textSecondary)
        : task.done
        ? ('Done', colors.primary)
        : ('Active', colors.secondary);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: AppTypography.caption(
          context,
        )?.copyWith(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _MessageView extends StatelessWidget {
  const _MessageView({
    required this.icon,
    required this.title,
    required this.message,
    required this.primaryLabel,
    required this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
  });

  final IconData icon;
  final String title;
  final String message;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: context.colors.textSecondary),
            const SizedBox(height: AppSpacing.space16),
            Text(
              title,
              style: AppTypography.title(
                context,
              )?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.space8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.body(
                context,
              )?.copyWith(color: context.colors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.space24),
            PrimaryButton(label: primaryLabel, onPressed: onPrimary),
            if (secondaryLabel != null) ...[
              const SizedBox(height: AppSpacing.space8),
              SecondaryButton(label: secondaryLabel!, onPressed: onSecondary),
            ],
          ],
        ),
      ),
    );
  }
}
