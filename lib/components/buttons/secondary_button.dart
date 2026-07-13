import 'package:flutter/material.dart';

import '../../core/radius/app_radius.dart';
import '../../core/spacing/app_spacing.dart';
import '../../app/theme/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final button = OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        disabledForegroundColor: AppColors.textPrimary.withValues(alpha: 0.5),
        side: const BorderSide(color: AppColors.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.radius12),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space24,
          vertical: AppSpacing.space12,
        ),
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.textPrimary,
                ),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 18),
                  const SizedBox(width: AppSpacing.space8),
                ],
                Text(label),
              ],
            ),
    );

    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
