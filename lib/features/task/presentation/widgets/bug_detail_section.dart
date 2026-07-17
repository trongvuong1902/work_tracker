import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/time/time_format.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/features/task/presentation/cubit/bug_detail_cubit.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_bug_attachment.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_bug_comment.dart';

/// The live "from Zentao" section on a bug-linked task's detail screen: the
/// full description, comment/action history, and attachments, streamed in by
/// [BugDetailCubit] after the local task loads.
class BugDetailSection extends StatelessWidget {
  const BugDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BugDetailCubit, BugDetailState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const ShadowCard(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.space16),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (state.errorMessage != null || state.detail == null) {
          return ShadowCard(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.space16),
              child: Text(
                state.errorMessage ?? "Couldn't load bug details.",
                style: AppTypography.body(
                  context,
                )?.copyWith(color: context.colors.textSecondary),
              ),
            ),
          );
        }

        final detail = state.detail!;
        final description = detail.bug.description;

        return ShadowCard(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.space16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bug details', style: AppTypography.label(context)),
                if (description != null && description.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.space8),
                  Text(description, style: AppTypography.body(context)),
                ],
                if (detail.attachments.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.space16),
                  Text('Attachments', style: AppTypography.label(context)),
                  const SizedBox(height: AppSpacing.space8),
                  _AttachmentsGrid(attachments: detail.attachments),
                ],
                const SizedBox(height: AppSpacing.space16),
                Text('History', style: AppTypography.label(context)),
                const SizedBox(height: AppSpacing.space8),
                if (detail.comments.isEmpty)
                  Text(
                    'No comments yet.',
                    style: AppTypography.caption(
                      context,
                    )?.copyWith(color: context.colors.textSecondary),
                  )
                else
                  for (final comment in detail.comments)
                    _CommentTile(comment: comment),
              ],
            ),
          ),
        );
      },
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
      label: Text(
        attachment.title,
        style: AppTypography.caption(context),
      ),
      onPressed: () => AppNavigator.pushAttachmentViewer(context, attachment),
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.comment});

  final ZentaoBugComment comment;

  @override
  Widget build(BuildContext context) {
    final date = comment.date;
    final header = [
      if (comment.actor != null) comment.actor!,
      if (date != null) TimeFormat.hhMmFromDateTime(date),
    ].join(' · ');

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header.isNotEmpty)
            Text(
              header,
              style: AppTypography.caption(
                context,
              )?.copyWith(color: context.colors.textSecondary),
            ),
          const SizedBox(height: AppSpacing.space4),
          Text(comment.comment, style: AppTypography.body(context)),
        ],
      ),
    );
  }
}
