import 'package:flutter/material.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';

/// Shared placeholder for features that aren't built yet — an icon, a
/// title, and a short subtitle message, centered on the page.
class ComingSoonView extends StatelessWidget {
  const ComingSoonView({super.key, required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.hourglass_empty,
              size: 48,
              color: context.colors.textSecondary,
            ),
            const SizedBox(height: AppSpacing.space16),
            Text(
              title,
              style: AppTypography.title(
                context,
              )?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.space8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.body(
                context,
              )?.copyWith(color: context.colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
