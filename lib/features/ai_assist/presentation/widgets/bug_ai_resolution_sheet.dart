import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/ai_assist/presentation/cubit/bug_ai_cubit.dart';
import 'package:work_tracker/features/task/domain/models/task.dart';

/// Opens the "Resolve with AI" bottom sheet for [task]'s linked bug, kicking
/// off the streaming Claude request as soon as it's shown.
void showBugAiResolutionSheet(BuildContext context, Task task) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => BlocProvider(
      create: (_) => getIt<BugAiCubit>()..resolve(task),
      child: const _BugAiResolutionView(),
    ),
  );
}

class _BugAiResolutionView extends StatelessWidget {
  const _BugAiResolutionView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BugAiCubit, BugAiState>(
      builder: (context, state) {
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
                  Text('AI resolution', style: AppTypography.title(context)),
                  const SizedBox(height: AppSpacing.space12),
                  Flexible(
                    child: ShadowCard(
                      margin: EdgeInsets.zero,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(AppSpacing.space16),
                        child: state.text.isEmpty && state.isStreaming
                            ? Text(
                                'Thinking…',
                                style: AppTypography.body(context)?.copyWith(
                                  color: context.colors.textSecondary,
                                ),
                              )
                            : SelectableText(
                                state.text,
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
                          'Streaming response…',
                          style: AppTypography.caption(context)?.copyWith(
                            color: context.colors.textSecondary,
                          ),
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
                    label: 'Copy',
                    icon: Icons.copy,
                    onPressed: state.text.isEmpty
                        ? null
                        : () => _copyText(context, state.text),
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
    messenger.showSnackBar(const SnackBar(content: Text('Copied')));
  }
}
