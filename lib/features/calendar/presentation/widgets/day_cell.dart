import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/features/calendar/domain/models/calendar_day.dart';
import 'package:work_tracker/features/calendar/domain/models/day_status.dart';
import 'package:work_tracker/features/calendar/presentation/cubit/calendar_cubit.dart';

class DayCell extends StatelessWidget {
  final CalendarDayModel day;

  const DayCell({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimmed = !day.isCurrentMonth;
    final isToday = day.isToday;
    final showBackground = isToday || day.isSelected;
    final showDot = !isToday && day.status != DayStatus.none;

    return GestureDetector(
      // Opaque so the whole cell (not just the painted number/dot) is tappable
      // — non-selected cells have no background, which made them hard to hit.
      behavior: HitTestBehavior.opaque,
      onTap: () => context.read<CalendarCubit>().selectDate(day.date),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.space4),
        decoration: showBackground
            ? BoxDecoration(
                color: colors.primaryLight,
                borderRadius: BorderRadius.circular(AppRadius.radius12),
              )
            : null,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.space8),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: isToday
                ? BoxDecoration(color: colors.primary, shape: BoxShape.circle)
                : null,
            child: Text(
              '${day.date.day}',
              style: AppTypography.body(context)?.copyWith(
                color: isToday
                    ? colors.surface
                    : dimmed
                    ? colors.textSecondary.withValues(alpha: 0.5)
                    : colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // const SizedBox(height: AppSpacing.space4),
          SizedBox(
            height: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showDot)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: day.status
                          .color(context)
                          .withValues(alpha: dimmed ? 0.4 : 1),
                      shape: BoxShape.circle,
                    ),
                  ),
                if (showDot && day.hasPlannedTasks)
                  const SizedBox(width: 3),
                if (day.hasPlannedTasks)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: colors.secondary.withValues(alpha: dimmed ? 0.4 : 1),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }
}
