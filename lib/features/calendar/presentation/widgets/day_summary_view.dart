import 'package:flutter/material.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/features/calendar/domain/models/calendar_day.dart';

class DaySummaryView extends StatelessWidget {
  final CalendarDayModel day;

  const DaySummaryView({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final attendance = day.attendance;

    return ShadowCard(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${weekdayInitials[day.date.weekday - 1]}, ${day.date.day} '
              '${monthNames[day.date.month - 1]} ${day.date.year}',
              style: AppTypography.subtitle(
                context,
              )?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.space12),
            if (attendance == null)
              Text(
                'No attendance recorded for this day.',
                style: AppTypography.body(
                  context,
                )?.copyWith(color: colors.textSecondary),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: _DetailItem(
                      label: 'Check-in',
                      value: attendance.checkIn != null
                          ? TimeFormat.hhMmFromDateTime(attendance.checkIn!)
                          : '-',
                    ),
                  ),
                  Expanded(
                    child: _DetailItem(
                      label: 'Check-out',
                      value: attendance.checkOut != null
                          ? TimeFormat.hhMmFromDateTime(attendance.checkOut!)
                          : '-',
                    ),
                  ),
                  Expanded(
                    child: _DetailItem(
                      label: 'Worked',
                      value: attendance.checkOut != null
                          ? TimeFormat.hMm(attendance.workedMinutes)
                          : '-',
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;

  const _DetailItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: AppTypography.title(
            context,
          )?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.space4),
        Text(
          label,
          style: AppTypography.caption(
            context,
          )?.copyWith(color: context.colors.textSecondary),
        ),
      ],
    );
  }
}
