import 'package:flutter/material.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/icon/app_icon.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';

class PlannendLeaveView extends StatelessWidget {
  const PlannendLeaveView({super.key, required this.endTime});
  final String endTime;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.space8,
      children: [
        AppIcon(
          icon: Icon(Icons.flag, color: context.colors.primary),
          backgroundColor: context.colors.primaryLight,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.space4,
          children: [
            Text(
              'Planned Leave',
              style: AppTypography.label(context)?.copyWith(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              endTime,
              style: AppTypography.title(context)?.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 28,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
