import 'package:flutter/material.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/zentao/domain/zentao_repository.dart';

/// "Import from platform" step — a row per integration; only Zentao is
/// enabled for v1, other platforms show as disabled/"Coming soon" rows.
class PlatformPickerPage extends StatelessWidget {
  const PlatformPickerPage({super.key});

  Future<void> _openZentao(BuildContext context) async {
    final connection = await getIt<ZentaoRepository>().getConnection();
    if (!context.mounted) return;
    if (connection == null) {
      await AppNavigator.pushZentaoConnect(context);
    } else {
      await AppNavigator.pushBugSyncProducts(context);
    }
    // Both paths lead to the unified connect → pick products → sync → Tasks
    // flow (the products page navigates to Tasks itself on sync), so there's
    // nothing to do here if this page is still on-screen.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Import from platform')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.space16),
          children: [
            _PlatformRow(
              icon: Icons.bug_report_outlined,
              title: 'Zentao',
              enabled: true,
              onTap: () => _openZentao(context),
            ),
            const SizedBox(height: AppSpacing.space8),
            const _PlatformRow(
              icon: Icons.view_kanban_outlined,
              title: 'Jira',
              enabled: false,
            ),
            const SizedBox(height: AppSpacing.space8),
            const _PlatformRow(
              icon: Icons.dashboard_outlined,
              title: 'Trello',
              enabled: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _PlatformRow extends StatelessWidget {
  const _PlatformRow({
    required this.icon,
    required this.title,
    required this.enabled,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: enabled ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: Row(
            children: [
              Icon(
                icon,
                color: enabled
                    ? context.colors.primary
                    : context.colors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.space12),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.label(context)?.copyWith(
                    color: enabled ? null : context.colors.textSecondary,
                  ),
                ),
              ),
              if (enabled)
                const Icon(Icons.chevron_right)
              else
                Text(
                  'Coming soon',
                  style: AppTypography.caption(
                    context,
                  )?.copyWith(color: context.colors.textSecondary),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
