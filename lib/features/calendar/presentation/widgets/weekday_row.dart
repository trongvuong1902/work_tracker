import 'package:flutter/material.dart';
import 'package:work_tracker/core/core.dart';

class WeekdayRow extends StatelessWidget {
  const WeekdayRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final label in weekdayInitials)
          Expanded(
            child: Center(
              child: Text(
                label,
                style: AppTypography.caption(
                  context,
                )?.copyWith(color: context.colors.textSecondary),
              ),
            ),
          ),
      ],
    );
  }
}
