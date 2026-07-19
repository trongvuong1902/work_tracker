import 'package:flutter/material.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/core/typography/app_typography.dart';

/// Color for a task priority, 1 (most urgent) → 5, with a neutral fallback for
/// unset priorities.
Color priorityColor(BuildContext context, int? priority) {
  switch (priority) {
    case 1:
      return const Color(0xFFEF4444); // red
    case 2:
      return const Color(0xFFF97316); // orange
    case 3:
      return const Color(0xFFF59E0B); // amber
    case 4:
      return const Color(0xFF3B82F6); // blue
    case 5:
      return const Color(0xFF9CA3AF); // grey
    default:
      return context.colors.textSecondary;
  }
}

/// A small rounded badge showing a task's priority number, tinted by
/// [priorityColor].
class PriorityBadge extends StatelessWidget {
  const PriorityBadge({super.key, required this.priority, this.size = 26});

  final int priority;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = priorityColor(context, priority);
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$priority',
        style: AppTypography.caption(
          context,
        )?.copyWith(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}
