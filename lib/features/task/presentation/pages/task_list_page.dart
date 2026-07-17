import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/task/domain/models/task.dart';
import 'package:work_tracker/features/task/presentation/cubit/bug_sync_cubit.dart';
import 'package:work_tracker/features/task/presentation/cubit/task_list_cubit.dart';
import 'package:work_tracker/features/task/presentation/widgets/add_task_sheet.dart';
import 'package:work_tracker/features/task/presentation/widgets/bug_sync_progress_dialog.dart';
import 'package:work_tracker/features/zentao/data/zentao_sync_prefs.dart';
import 'package:work_tracker/features/zentao/domain/zentao_repository.dart';

/// The 3rd bottom-nav tab (replaces the old placeholder Insight/Statistics
/// tab) — the app's Task List: manual + Zentao-imported tasks, tracked with
/// an Open/Done status and a start/stop timer (see `TaskDetailPage`).
class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TaskListCubit>(),
      child: const _TaskListView(),
    );
  }
}

class _TaskListView extends StatefulWidget {
  const _TaskListView();

  @override
  State<_TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<_TaskListView> {
  Future<void> _openAddTaskSheet() async {
    final cubit = context.read<TaskListCubit>();
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
    final cubit = context.read<TaskListCubit>();
    await AppNavigator.pushTaskDetail(context, taskId);
    if (mounted) cubit.load();
  }

  /// Bulk "Bugs assigned to me" sync: ensure a Zentao connection and a product
  /// selection, then run the sync with a progress dialog and report a summary.
  Future<void> _syncBugs() async {
    final messenger = ScaffoldMessenger.of(context);
    final listCubit = context.read<TaskListCubit>();

    final connection = await getIt<ZentaoRepository>().getConnection();
    if (!mounted) return;
    if (connection == null) {
      await AppNavigator.pushZentaoConnect(context);
      return;
    }

    if (!getIt<ZentaoSyncPrefs>().hasSelection) {
      final saved = await AppNavigator.pushBugSyncProducts(context);
      if (!mounted || saved != true) return;
    }

    await _runSync(messenger, listCubit);
  }

  Future<void> _chooseSyncProducts() async {
    final listCubit = context.read<TaskListCubit>();
    final connection = await getIt<ZentaoRepository>().getConnection();
    if (!mounted) return;
    if (connection == null) {
      await AppNavigator.pushZentaoConnect(context);
      return;
    }
    final saved = await AppNavigator.pushBugSyncProducts(context);
    if (!mounted || saved != true) return;
    await _runSync(ScaffoldMessenger.of(context), listCubit);
  }

  Future<void> _runSync(
    ScaffoldMessengerState messenger,
    TaskListCubit listCubit,
  ) async {
    final cubit = getIt<BugSyncCubit>();
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const BugSyncProgressDialog(),
      ),
    );
    final result = cubit.state;
    await cubit.close();
    if (!mounted) return;

    if (result.errorMessage != null) {
      messenger.showSnackBar(SnackBar(content: Text(result.errorMessage!)));
    } else {
      final failed = result.failedProducts > 0
          ? ' · ${result.failedProducts} product(s) failed'
          : '';
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Added ${result.added} · Updated ${result.updated}$failed',
          ),
        ),
      );
    }
    listCubit.load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListCubit, TaskListState>(
      builder: (context, state) {
        final cubit = context.read<TaskListCubit>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tasks'),
            actions: [
              PopupMenuButton<TaskSort>(
                icon: const Icon(Icons.sort),
                tooltip: 'Sort',
                initialValue: state.sort,
                onSelected: cubit.setSort,
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: TaskSort.createdDesc,
                    child: Text('Newest first'),
                  ),
                  PopupMenuItem(
                    value: TaskSort.priority,
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

  Widget _buildBody(BuildContext context, TaskListState state) {
    final cubit = context.read<TaskListCubit>();

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
      onRefresh: cubit.load,
      child: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.space16),
        itemCount: state.tasks.length,
        itemBuilder: (context, index) {
          final task = state.tasks[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space8),
            child: _TaskRow(
              task: task,
              onTap: () => _openTaskDetail(task.id),
            ),
          );
        },
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  const _TaskRow({required this.task, required this.onTap});

  final Task task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final syncedAt = task.zentaoLastSyncedAt;
    final meta = _bugMetaLabel(task);

    return ShadowCard(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: Row(
            children: [
              Icon(
                task.done ? Icons.check_circle : Icons.radio_button_unchecked,
                color: task.done
                    ? context.colors.primary
                    : context.colors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            task.title,
                            style: AppTypography.label(context)?.copyWith(
                              decoration: task.done
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: task.done
                                  ? context.colors.textSecondary
                                  : null,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (task.isLinkedToZentao) ...[
                          const SizedBox(width: AppSpacing.space8),
                          _ZentaoChip(),
                        ] else if (task.isLinkedToZentaoBug) ...[
                          const SizedBox(width: AppSpacing.space8),
                          _ZentaoBugChip(),
                        ],
                      ],
                    ),
                    if (meta != null) ...[
                      const SizedBox(height: AppSpacing.space4),
                      Text(
                        meta,
                        style: AppTypography.caption(
                          context,
                        )?.copyWith(color: context.colors.textSecondary),
                      ),
                    ],
                    if (task.isLinkedToAnyZentao && syncedAt != null) ...[
                      const SizedBox(height: AppSpacing.space4),
                      Text(
                        _syncedAgoLabel(syncedAt),
                        style: AppTypography.caption(
                          context,
                        )?.copyWith(color: context.colors.textSecondary),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  /// A one-line "P{priority} · Product" summary for bug tasks (only the parts
  /// that are present). Null for non-bug tasks.
  String? _bugMetaLabel(Task task) {
    if (!task.isLinkedToZentaoBug) return null;
    final parts = <String>[
      if (task.priority != null) 'P${task.priority}',
      if (task.zentaoProductName != null) task.zentaoProductName!,
    ];
    return parts.isEmpty ? null : parts.join(' · ');
  }

  String _syncedAgoLabel(DateTime syncedAt) {
    final diff = DateTime.now().difference(syncedAt);
    if (diff.inMinutes < 1) return 'synced just now';
    if (diff.inMinutes < 60) return 'synced ${diff.inMinutes}m ago';
    if (diff.inHours < 24) return 'synced ${diff.inHours}h ago';
    return 'synced ${diff.inDays}d ago';
  }
}

class _ZentaoChip extends StatelessWidget {
  const _ZentaoChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: context.colors.primaryLight,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'Zentao',
        style: AppTypography.caption(
          context,
        )?.copyWith(color: context.colors.primary, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _ZentaoBugChip extends StatelessWidget {
  const _ZentaoBugChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: context.colors.warning.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'Bug',
        style: AppTypography.caption(
          context,
        )?.copyWith(color: context.colors.warning, fontWeight: FontWeight.w600),
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
