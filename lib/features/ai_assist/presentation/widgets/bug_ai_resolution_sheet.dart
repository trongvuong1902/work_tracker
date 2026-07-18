import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/ai_assist/domain/ai_target.dart';
import 'package:work_tracker/features/ai_assist/presentation/cubit/bug_ai_cubit.dart';
import 'package:work_tracker/features/task/domain/models/task.dart';

/// Opens the "AI fix prompt" bottom sheet for [task]'s linked bug. The model
/// generates a fix prompt tailored to the selected target platform, kicked off
/// once when the sheet appears.
void showBugAiResolutionSheet(BuildContext context, Task task) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    // The cubit is created once inside the StatefulWidget (not in this builder,
    // which reruns on rebuilds) so generation fires exactly once.
    builder: (_) => _BugAiResolutionSheet(task: task),
  );
}

class _BugAiResolutionSheet extends StatefulWidget {
  const _BugAiResolutionSheet({required this.task});

  final Task task;

  @override
  State<_BugAiResolutionSheet> createState() => _BugAiResolutionSheetState();
}

class _BugAiResolutionSheetState extends State<_BugAiResolutionSheet> {
  late final BugAiCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<BugAiCubit>()..generate(widget.task);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: const _BugAiResolutionView(),
    );
  }
}

class _BugAiResolutionView extends StatelessWidget {
  const _BugAiResolutionView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BugAiCubit, BugAiState>(
      builder: (context, state) {
        final cubit = context.read<BugAiCubit>();
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
                  Text('AI fix prompt', style: AppTypography.title(context)),
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    'Generate a fix prompt tailored to your AI tool.',
                    style: AppTypography.caption(
                      context,
                    )?.copyWith(color: context.colors.textSecondary),
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  _TargetSelector(
                    selected: state.target,
                    enabled: !state.isStreaming,
                    onChanged: cubit.changeTarget,
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  _FrameworkRow(
                    framework: state.framework,
                    enabled: !state.isStreaming,
                    onReDetect: cubit.reDetectFramework,
                    onEdit: (value) => cubit.setFramework(value),
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Flexible(
                    child: ShadowCard(
                      margin: EdgeInsets.zero,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(AppSpacing.space16),
                        child: state.displayText.isEmpty && state.isStreaming
                            ? Text(
                                'Generating…',
                                style: AppTypography.body(context)?.copyWith(
                                  color: context.colors.textSecondary,
                                ),
                              )
                            : SelectableText(
                                state.displayText,
                                style: AppTypography.body(context),
                              ),
                      ),
                    ),
                  ),
                  if (state.isStreaming) ...[
                    const SizedBox(height: AppSpacing.space12),
                    Row(
                      children: [
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        const SizedBox(width: AppSpacing.space8),
                        Text(
                          'Writing prompt…',
                          style: AppTypography.caption(
                            context,
                          )?.copyWith(color: context.colors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                  if (state.errorMessage != null) ...[
                    const SizedBox(height: AppSpacing.space12),
                    Text(
                      state.errorMessage!,
                      style: AppTypography.body(
                        context,
                      )?.copyWith(color: context.colors.error),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.space16),
                  PrimaryButton(
                    label: 'Copy prompt',
                    icon: Icons.copy,
                    onPressed: state.displayText.isEmpty
                        ? null
                        : () => _copyText(context, state.displayText),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _copyText(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(const SnackBar(content: Text('Prompt copied')));
  }
}

/// Segmented picker for the target AI platform.
class _TargetSelector extends StatelessWidget {
  const _TargetSelector({
    required this.selected,
    required this.enabled,
    required this.onChanged,
  });

  final AiTarget selected;
  final bool enabled;
  final ValueChanged<AiTarget> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.space8,
      runSpacing: AppSpacing.space8,
      children: [
        for (final target in AiTarget.values)
          ChoiceChip(
            label: Text(target.label),
            selected: target == selected,
            onSelected: enabled && target != selected
                ? (_) => onChanged(target)
                : null,
          ),
      ],
    );
  }
}

/// Shows the detected/cached stack with a "change" affordance (edit or
/// re-detect).
class _FrameworkRow extends StatelessWidget {
  const _FrameworkRow({
    required this.framework,
    required this.enabled,
    required this.onReDetect,
    required this.onEdit,
  });

  final String? framework;
  final bool enabled;
  final VoidCallback onReDetect;
  final ValueChanged<String> onEdit;

  @override
  Widget build(BuildContext context) {
    final label = framework == null ? 'Stack: detecting…' : 'Stack: $framework';
    return Row(
      children: [
        Icon(
          Icons.layers_outlined,
          size: 16,
          color: context.colors.textSecondary,
        ),
        const SizedBox(width: AppSpacing.space4),
        Flexible(
          child: Text(
            label,
            style: AppTypography.caption(
              context,
            )?.copyWith(color: context.colors.textSecondary),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (enabled) ...[
          const SizedBox(width: AppSpacing.space8),
          InkWell(
            onTap: () => _showChangeMenu(context),
            child: Text(
              'change',
              style: AppTypography.caption(context)?.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _showChangeMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Set stack manually'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _promptForStack(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Re-detect from bug'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                onReDetect();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _promptForStack(BuildContext context) async {
    final controller = TextEditingController(text: framework ?? '');
    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Set stack'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'e.g. Flutter / Dart'),
          onSubmitted: (value) => Navigator.of(dialogContext).pop(value),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null && result.trim().isNotEmpty) onEdit(result);
  }
}
