import 'package:flutter/material.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';

/// A single row inside a [SettingsSection]: a leading [label], an optional
/// [trailing] status widget, and (by default) a trailing chevron indicating
/// the row navigates or opens a sheet. Set [showChevron] to false for rows
/// that don't navigate.
class SettingsTile extends StatelessWidget {
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showChevron;

  const SettingsTile({
    super.key,
    required this.label,
    this.trailing,
    this.onTap,
    this.showChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTypography.label(context)),
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (trailing != null) ...[
                    Flexible(child: trailing!),
                    if (showChevron)
                      const SizedBox(width: AppSpacing.space8),
                  ],
                  if (showChevron) const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Colored/bold status text shown on the trailing side of a [SettingsTile].
/// [active] switches to the primary color + semibold weight (e.g. "Active",
/// "On", "Connected"); otherwise it reads as muted secondary text.
class SettingsTileStatus extends StatelessWidget {
  final String text;
  final bool active;

  const SettingsTileStatus({
    super.key,
    required this.text,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.body(context)?.copyWith(
        color: active ? context.colors.primary : context.colors.textSecondary,
        fontWeight: active ? FontWeight.w600 : FontWeight.normal,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
