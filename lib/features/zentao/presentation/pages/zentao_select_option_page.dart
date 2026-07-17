import 'package:flutter/material.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_import_kind.dart';

/// Shown right after a successful Zentao connect (replacing the connect
/// form) or when the Platform Picker finds an existing connection — lets
/// the user pick which resource type to fetch from Zentao before reaching
/// the (generalized) Product Picker.
class ZentaoSelectOptionPage extends StatelessWidget {
  const ZentaoSelectOptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Import from Zentao')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.space16),
          children: [
            _OptionRow(
              icon: Icons.checklist_rounded,
              title: 'Tasks assigned to me',
              onTap: () => AppNavigator.pushZentaoProductPicker(
                context,
                kind: ZentaoImportKind.task,
              ),
            ),
            const SizedBox(height: AppSpacing.space8),
            _OptionRow(
              icon: Icons.bug_report_outlined,
              title: 'Bugs assigned to me',
              onTap: () => AppNavigator.pushZentaoProductPicker(
                context,
                kind: ZentaoImportKind.bug,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionRow extends StatelessWidget {
  const _OptionRow({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
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
                child: Text(title, style: AppTypography.label(context)),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
