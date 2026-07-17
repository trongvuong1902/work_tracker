import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/time/time_format.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/task/domain/models/task.dart';
import 'package:work_tracker/features/task/presentation/cubit/bug_detail_cubit.dart';
import 'package:work_tracker/features/task/presentation/cubit/task_detail_cubit.dart';
import 'package:work_tracker/features/task/presentation/widgets/bug_detail_section.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_connection.dart';
import 'package:work_tracker/features/zentao/domain/zentao_repository.dart';

/// Task Detail: title/description, Open/Done toggle, start/stop timer, and
/// — for tasks imported from Zentao — a linked-ticket section with a
/// manual "Refresh" action and an "Open in Zentao" external link.
class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({super.key, required this.taskId});

  final int taskId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<TaskDetailCubit>()..load(taskId)),
        BlocProvider(create: (_) => getIt<BugDetailCubit>()),
      ],
      child: const _TaskDetailView(),
    );
  }
}

class _TaskDetailView extends StatefulWidget {
  const _TaskDetailView();

  @override
  State<_TaskDetailView> createState() => _TaskDetailViewState();
}

class _TaskDetailViewState extends State<_TaskDetailView> {
  ZentaoConnection? _zentaoConnection;
  bool _bugDetailRequested = false;

  @override
  void initState() {
    super.initState();
    _loadZentaoConnection();
  }

  /// Kicks off the live bug-detail fetch once, the first time we know the task
  /// is bug-linked (its zentaoBugId is only known after the task loads).
  void _maybeLoadBugDetail(Task task) {
    if (_bugDetailRequested) return;
    final bugId = task.zentaoBugId;
    if (bugId == null) return;
    _bugDetailRequested = true;
    context.read<BugDetailCubit>().load(bugId);
  }

  Future<void> _loadZentaoConnection() async {
    final connection = await getIt<ZentaoRepository>().getConnection();
    if (mounted) setState(() => _zentaoConnection = connection);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailCubit, TaskDetailState>(
      builder: (context, state) {
        final task = state.task;
        return Scaffold(
          appBar: AppBar(title: const Text('Task')),
          body: SafeArea(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : task == null
                ? Center(
                    child: Text(
                      'Task not found.',
                      style: AppTypography.body(context),
                    ),
                  )
                : _buildContent(context, state, task),
          ),
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    TaskDetailState state,
    Task task,
  ) {
    final cubit = context.read<TaskDetailCubit>();
    _maybeLoadBugDetail(task);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      children: [
        Text(
          task.title,
          style: AppTypography.title(
            context,
          )?.copyWith(fontWeight: FontWeight.w600),
        ),
        if (task.description != null && task.description!.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.space8),
          Text(task.description!, style: AppTypography.body(context)),
        ],
        const SizedBox(height: AppSpacing.space16),
        _StatusRow(
          done: task.done,
          isLoading: state.isTogglingDone,
          onToggle: cubit.toggleDone,
        ),
        const SizedBox(height: AppSpacing.space16),
        _TimerCard(
          task: task,
          isLoading: state.isTogglingTimer,
          onToggle: cubit.toggleTimer,
        ),
        if (task.isLinkedToAnyZentao) ...[
          const SizedBox(height: AppSpacing.space16),
          _ZentaoLinkedCard(
            task: task,
            isRefreshing: state.isRefreshing,
            onRefresh: cubit.refreshFromZentao,
            connection: _zentaoConnection,
          ),
        ],
        if (task.isLinkedToZentaoBug) ...[
          const SizedBox(height: AppSpacing.space16),
          const BugDetailSection(),
        ],
        if (state.errorMessage != null) ...[
          const SizedBox(height: AppSpacing.space16),
          Text(
            state.errorMessage!,
            style: AppTypography.body(
              context,
            )?.copyWith(color: context.colors.error),
          ),
        ],
      ],
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({
    required this.done,
    required this.isLoading,
    required this.onToggle,
  });

  final bool done;
  final bool isLoading;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              done ? 'Done' : 'Open',
              style: AppTypography.label(context)?.copyWith(
                color: done ? context.colors.primary : null,
                fontWeight: FontWeight.w600,
              ),
            ),
            isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Switch(
                    value: done,
                    activeThumbColor: context.colors.primary,
                    onChanged: (_) => onToggle(),
                  ),
          ],
        ),
      ),
    );
  }
}

class _TimerCard extends StatefulWidget {
  const _TimerCard({
    required this.task,
    required this.isLoading,
    required this.onToggle,
  });

  final Task task;
  final bool isLoading;
  final VoidCallback onToggle;

  @override
  State<_TimerCard> createState() => _TimerCardState();
}

class _TimerCardState extends State<_TimerCard> {
  @override
  Widget build(BuildContext context) {
    final running = widget.task.isTimerRunning;
    final elapsed = widget.task.currentElapsedSeconds();

    return ShadowCard(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Timer', style: AppTypography.label(context)),
            const SizedBox(height: AppSpacing.space8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  TimeFormat.clock(elapsed),
                  style: AppTypography.headline(
                    context,
                  )?.copyWith(fontWeight: FontWeight.w600),
                ),
                widget.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : PrimaryButton(
                        label: running ? 'Stop' : 'Start',
                        icon: running ? Icons.stop : Icons.play_arrow,
                        expanded: false,
                        onPressed: widget.onToggle,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ZentaoLinkedCard extends StatelessWidget {
  const _ZentaoLinkedCard({
    required this.task,
    required this.isRefreshing,
    required this.onRefresh,
    required this.connection,
  });

  final Task task;
  final bool isRefreshing;
  final VoidCallback onRefresh;
  final ZentaoConnection? connection;

  @override
  Widget build(BuildContext context) {
    final syncedAt = task.zentaoLastSyncedAt;

    return ShadowCard(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.isLinkedToZentaoBug
                      ? 'Imported from Zentao — Bug #${task.zentaoBugId}'
                      : 'Imported from Zentao — Ticket #${task.zentaoTaskId}',
                  style: AppTypography.label(context),
                ),
                isRefreshing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : IconButton(
                        icon: const Icon(Icons.refresh),
                        tooltip: 'Refresh',
                        onPressed: onRefresh,
                      ),
              ],
            ),
            if (task.zentaoStatus != null) ...[
              const SizedBox(height: AppSpacing.space4),
              Text(
                'Status: ${task.zentaoStatus}',
                style: AppTypography.body(context),
              ),
            ],
            if (task.isLinkedToZentaoBug) ..._bugFieldRows(context, task),
            const SizedBox(height: AppSpacing.space4),
            Text(
              syncedAt != null
                  ? 'Last synced ${TimeFormat.hhMmFromDateTime(syncedAt)}'
                  : 'Not synced yet',
              style: AppTypography.caption(
                context,
              )?.copyWith(color: context.colors.textSecondary),
            ),
            if (connection != null) ...[
              const SizedBox(height: AppSpacing.space8),
              SecondaryButton(
                label: 'Open in Zentao',
                icon: Icons.open_in_new,
                onPressed: () => _openInZentao(connection!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Bug-only fields persisted from the sync (priority, severity, product),
  /// shown only when present.
  List<Widget> _bugFieldRows(BuildContext context, Task task) {
    final rows = <Widget>[];
    void add(String label) {
      rows
        ..add(const SizedBox(height: AppSpacing.space4))
        ..add(Text(label, style: AppTypography.body(context)));
    }

    if (task.zentaoPriority != null) add('Priority: ${task.zentaoPriority}');
    if (task.zentaoSeverity != null) add('Severity: ${task.zentaoSeverity}');
    if (task.zentaoProductName != null) {
      final productPriority = task.zentaoProductPriority;
      add(
        'Product: ${task.zentaoProductName}'
        '${productPriority != null ? ' (priority $productPriority)' : ''}',
      );
    }
    return rows;
  }

  Future<void> _openInZentao(ZentaoConnection connection) async {
    final zentaoTaskId = task.zentaoTaskId;
    final zentaoBugId = task.zentaoBugId;
    final url = zentaoTaskId != null
        ? connection.taskUrl(zentaoTaskId)
        : zentaoBugId != null
        ? connection.bugUrl(zentaoBugId)
        : null;
    if (url == null) return;
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}
