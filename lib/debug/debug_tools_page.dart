import 'package:flutter/material.dart';

import '../app/router/app_navigator.dart';
import '../components/components.dart';
import '../core/core.dart';

class DebugToolsPage extends StatelessWidget {
  const DebugToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug tools')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.space16),
        children: [
          _DebugToolTile(
            label: 'Components showcase',
            onTap: () => AppNavigator.pushDebugComponents(context),
          ),
          const SizedBox(height: AppSpacing.space16),
          _DebugToolTile(
            label: 'Preview onboarding',
            onTap: () => AppNavigator.pushDebugOnboardingPreview(context),
          ),
          const SizedBox(height: AppSpacing.space16),
          _DebugToolTile(
            label: 'Test notifications flow',
            onTap: () => AppNavigator.pushDebugNotificationsFlow(context),
          ),
        ],
      ),
    );
  }
}

class _DebugToolTile extends StatelessWidget {
  const _DebugToolTile({required this.label, required this.onTap});

  final String label;
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTypography.label(context)),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
