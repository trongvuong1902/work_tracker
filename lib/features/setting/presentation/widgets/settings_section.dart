import 'package:flutter/material.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';

/// An iOS-style grouped settings section: an uppercase [title] header above a
/// single rounded card that stacks [children] (typically [SettingsTile]s),
/// separated by thin left-inset dividers. Owns the trailing gap so the page
/// body can simply stack sections.
class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.space4,
            bottom: AppSpacing.space8,
          ),
          child: Text(
            title.toUpperCase(),
            style: AppTypography.caption(context)?.copyWith(
              color: context.colors.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        ShadowCard(
          margin: EdgeInsets.zero,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _withDividers(context),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.space24),
      ],
    );
  }

  List<Widget> _withDividers(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      rows.add(children[i]);
      if (i < children.length - 1) {
        rows.add(
          Divider(
            height: 1,
            thickness: 1,
            indent: AppSpacing.space16,
            color: context.colors.divider,
          ),
        );
      }
    }
    return rows;
  }
}
