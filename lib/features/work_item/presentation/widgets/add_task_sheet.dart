import 'package:flutter/material.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/core.dart';

/// The two ways to add a task, chosen from [showAddTaskSheet].
enum AddTaskChoice { manual, importPlatform }

/// Modal bottom sheet with the two "+" options from the Task List: "Create
/// manually" or "Import from platform". Pops with the chosen [AddTaskChoice]
/// (or `null` if dismissed without choosing).
Future<AddTaskChoice?> showAddTaskSheet(BuildContext context) {
  return showModalBottomSheet<AddTaskChoice>(
    context: context,
    showDragHandle: true,
    builder: (_) => const _AddTaskSheet(),
  );
}

class _AddTaskSheet extends StatelessWidget {
  const _AddTaskSheet();

  @override
  Widget build(BuildContext context) {
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
            Text(
              'Add task',
              style: AppTypography.title(
                context,
              )?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.space16),
            _ChoiceRow(
              icon: Icons.edit_note,
              title: 'Create manually',
              subtitle: 'Title and description you type in yourself.',
              onTap: () =>
                  Navigator.pop(context, AddTaskChoice.manual),
            ),
            const SizedBox(height: AppSpacing.space8),
            _ChoiceRow(
              icon: Icons.cloud_download_outlined,
              title: 'Import from platform',
              subtitle: 'Pull in a task assigned to you on Zentao.',
              onTap: () =>
                  Navigator.pop(context, AddTaskChoice.importPlatform),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChoiceRow extends StatelessWidget {
  const _ChoiceRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: Row(
            children: [
              Icon(icon, color: context.colors.primary),
              const SizedBox(width: AppSpacing.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.label(
                        context,
                      )?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: AppSpacing.space4),
                    Text(
                      subtitle,
                      style: AppTypography.caption(
                        context,
                      )?.copyWith(color: context.colors.textSecondary),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: context.colors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
