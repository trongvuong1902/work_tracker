import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/time/time_format.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/ai_assist/domain/ai_repository.dart';
import 'package:work_tracker/features/ai_assist/presentation/widgets/bug_ai_resolution_sheet.dart';
import 'package:work_tracker/features/task/domain/bug_prompt.dart';
import 'package:work_tracker/features/task/domain/models/task.dart';
import 'package:work_tracker/features/task/presentation/cubit/task_detail_cubit.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_bug_attachment.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_connection.dart';
import 'package:work_tracker/features/zentao/domain/zentao_repository.dart';

/// Task Detail: title, description, attachments and notes as stacked tiles,
/// a bottom Start/Stop timer button, and everything else (status, priority,
/// product, Done, Refresh, Open in Zentao) tucked into a three-dot popup.
class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({super.key, required this.taskId});

  final int taskId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TaskDetailCubit>()..load(taskId),
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

  @override
  void initState() {
    super.initState();
    _loadZentaoConnection();
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
          appBar: AppBar(
            title: const Text('Task'),
            actions: [
              if (task != null)
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  tooltip: 'More',
                  onPressed: () => _showInfoSheet(context, state, task),
                ),
            ],
          ),
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
          bottomNavigationBar: task == null
              ? null
              : _TimerBar(
                  task: task,
                  isLoading: state.isTogglingTimer,
                  onToggle: context.read<TaskDetailCubit>().toggleTimer,
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
    final isBug = task.isLinkedToZentaoBug;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      children: [
        Text(
          task.title,
          style: AppTypography.title(
            context,
          )?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSpacing.space16),
        _SectionTile(
          title: 'Description',
          isLoading: state.isEnriching && (task.description ?? '').isEmpty,
          child: _bodyText(context, task.description, 'No description.'),
        ),
        if (isBug) ...[
          const SizedBox(height: AppSpacing.space16),
          _SectionTile(
            title: 'Attachments',
            isLoading: state.isEnriching && task.attachments.isEmpty,
            child: task.attachments.isEmpty
                ? _placeholder(context, 'No attachments.')
                : _AttachmentsGrid(attachments: task.attachments),
          ),
        ],
        const SizedBox(height: AppSpacing.space16),
        _SectionTile(
          title: 'Notes',
          isLoading: state.isEnriching && (task.notes ?? '').isEmpty,
          child: _bodyText(context, task.notes, 'No notes.'),
        ),
        if (isBug) ...[
          const SizedBox(height: AppSpacing.space16),
          SecondaryButton(
            label: 'Generate Claude prompt',
            icon: Icons.auto_awesome,
            onPressed: () => _showClaudePromptSheet(context, task),
          ),
          const SizedBox(height: AppSpacing.space16),
          PrimaryButton(
            label: 'Generate AI fix prompt',
            icon: Icons.auto_awesome,
            onPressed: () => _resolveWithAi(context, task),
          ),
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

  Widget _bodyText(BuildContext context, String? text, String emptyLabel) {
    if (text == null || text.isEmpty) return _placeholder(context, emptyLabel);
    return Text(text, style: AppTypography.body(context));
  }

  Widget _placeholder(BuildContext context, String label) => Text(
    label,
    style: AppTypography.caption(
      context,
    )?.copyWith(color: context.colors.textSecondary),
  );

  void _showInfoSheet(
    BuildContext context,
    TaskDetailState state,
    Task task,
  ) {
    final cubit = context.read<TaskDetailCubit>();
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: _TaskInfoSheet(connection: _zentaoConnection),
      ),
    );
  }

  void _showClaudePromptSheet(BuildContext context, Task task) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _ClaudePromptSheet(task: task),
    );
  }

  void _resolveWithAi(BuildContext context, Task task) {
    if (!getIt<AiRepository>().isConfigured) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("AI isn't configured in this build.")),
      );
      return;
    }
    showBugAiResolutionSheet(context, task);
  }
}

/// A titled `ShadowCard` tile — the shared container for description/
/// attachments/notes, with an inline spinner while [isLoading].
class _SectionTile extends StatelessWidget {
  const _SectionTile({
    required this.title,
    required this.child,
    this.isLoading = false,
  });

  final String title;
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTypography.label(context)),
            const SizedBox(height: AppSpacing.space8),
            if (isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.space8),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              )
            else
              child,
          ],
        ),
      ),
    );
  }
}

class _AttachmentsGrid extends StatelessWidget {
  const _AttachmentsGrid({required this.attachments});

  final List<ZentaoBugAttachment> attachments;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.space8,
      runSpacing: AppSpacing.space8,
      children: [
        for (final attachment in attachments)
          _AttachmentChip(attachment: attachment),
      ],
    );
  }
}

class _AttachmentChip extends StatelessWidget {
  const _AttachmentChip({required this.attachment});

  final ZentaoBugAttachment attachment;

  IconData get _icon {
    if (attachment.isImage) return Icons.image_outlined;
    if (attachment.isVideo) return Icons.videocam_outlined;
    return Icons.insert_drive_file_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(_icon, size: 18, color: context.colors.primary),
      label: Text(attachment.title, style: AppTypography.caption(context)),
      onPressed: () => AppNavigator.pushAttachmentViewer(context, attachment),
    );
  }
}

/// Bottom bar with the live elapsed time and the single global Start/Stop
/// timer button.
class _TimerBar extends StatelessWidget {
  const _TimerBar({
    required this.task,
    required this.isLoading,
    required this.onToggle,
  });

  final Task task;
  final bool isLoading;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final running = task.isTimerRunning;
    final elapsed = task.currentElapsedSeconds();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Tracked',
                  style: AppTypography.caption(
                    context,
                  )?.copyWith(color: context.colors.textSecondary),
                ),
                Text(
                  TimeFormat.clock(elapsed),
                  style: AppTypography.headline(
                    context,
                  )?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.space16),
            Expanded(
              child: PrimaryButton(
                label: running ? 'Stop timer' : 'Start timer',
                icon: running ? Icons.stop : Icons.play_arrow,
                isLoading: isLoading,
                onPressed: onToggle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The three-dot popup with status, priority, product, Done, Refresh and
/// Open-in-Zentao.
class _TaskInfoSheet extends StatelessWidget {
  const _TaskInfoSheet({required this.connection});

  final ZentaoConnection? connection;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskDetailCubit, TaskDetailState>(
      listenWhen: (prev, curr) =>
          prev.task?.done == false &&
          curr.task?.done == true &&
          (curr.task?.isLinkedToZentaoBug ?? false),
      listener: (context, state) {
        // A bug task just transitioned to Done — that means the Zentao resolve
        // succeeded. Confirm it and close the sheet.
        final messenger = ScaffoldMessenger.of(context);
        Navigator.of(context).pop();
        messenger.showSnackBar(
          const SnackBar(content: Text('Bug resolved in Zentao')),
        );
      },
      builder: (context, state) {
        final task = state.task;
        if (task == null) return const SizedBox.shrink();
        final cubit = context.read<TaskDetailCubit>();

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
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    task.done ? 'Done' : 'Open',
                    style: AppTypography.label(context),
                  ),
                  value: task.done,
                  activeThumbColor: context.colors.primary,
                  onChanged: state.isTogglingDone
                      ? null
                      : (_) => cubit.toggleDone(),
                ),
                if (task.priority != null)
                  _infoRow(context, 'Priority', 'P${task.priority}'),
                if (task.zentaoStatus != null)
                  _infoRow(context, 'Status', task.zentaoStatus!),
                if (task.zentaoSeverity != null)
                  _infoRow(context, 'Severity', '${task.zentaoSeverity}'),
                if (task.zentaoPriority != null)
                  _infoRow(context, 'Zentao priority', '${task.zentaoPriority}'),
                if (task.zentaoProductName != null)
                  _infoRow(
                    context,
                    'Product',
                    task.zentaoProductName! +
                        (task.zentaoProductPriority != null
                            ? ' (priority ${task.zentaoProductPriority})'
                            : ''),
                  ),
                if (task.zentaoLastSyncedAt != null)
                  _infoRow(
                    context,
                    'Last synced',
                    TimeFormat.hhMmFromDateTime(task.zentaoLastSyncedAt!),
                  ),
                if (task.isLinkedToAnyZentao) ...[
                  const SizedBox(height: AppSpacing.space12),
                  Row(
                    children: [
                      Expanded(
                        child: SecondaryButton(
                          label: 'Refresh',
                          icon: Icons.refresh,
                          onPressed: state.isRefreshing || state.isEnriching
                              ? null
                              : cubit.refreshFromZentao,
                        ),
                      ),
                      if (connection != null) ...[
                        const SizedBox(width: AppSpacing.space8),
                        Expanded(
                          child: SecondaryButton(
                            label: 'Open',
                            icon: Icons.open_in_new,
                            onPressed: () => _openInZentao(task, connection!),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (state.isRefreshing) ...[
                    const SizedBox(height: AppSpacing.space8),
                    const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ],
                ],
                if (state.isTogglingDone) ...[
                  const SizedBox(height: AppSpacing.space8),
                  const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ],
                if (state.errorMessage != null) ...[
                  const SizedBox(height: AppSpacing.space8),
                  Text(
                    state.errorMessage!,
                    style: AppTypography.body(
                      context,
                    )?.copyWith(color: context.colors.error),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.space4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.caption(
              context,
            )?.copyWith(color: context.colors.textSecondary),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppTypography.body(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openInZentao(Task task, ZentaoConnection connection) async {
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

/// Bottom sheet previewing the generated Claude prompt for [task]'s linked
/// bug, with a single primary action to copy it to the clipboard.
class _ClaudePromptSheet extends StatelessWidget {
  const _ClaudePromptSheet({required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final prompt = buildBugResolutionPrompt(task);

    return SafeArea(
      top: false,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
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
              Text('Prompt for Claude', style: AppTypography.title(context)),
              const SizedBox(height: AppSpacing.space12),
              Flexible(
                child: ShadowCard(
                  margin: EdgeInsets.zero,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSpacing.space16),
                    child: SelectableText(
                      prompt,
                      style: AppTypography.body(context),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.space16),
              PrimaryButton(
                label: 'Copy',
                icon: Icons.copy,
                onPressed: () => _copyPrompt(context, prompt),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _copyPrompt(BuildContext context, String prompt) {
    Clipboard.setData(ClipboardData(text: prompt));
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    messenger.showSnackBar(const SnackBar(content: Text('Prompt copied')));
  }
}
