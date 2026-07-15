import 'package:flutter/material.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/features/calendar/domain/models/month_summary.dart';

class MonthSummaryRow extends StatelessWidget {
  final MonthSummary summary;

  const MonthSummaryRow({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ShadowCard(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space16,
          vertical: AppSpacing.space12,
        ),
        child: Row(
          children: [
            Expanded(
              child: _SummaryItem(
                label: 'Late',
                count: summary.lateCount,
                color: colors.warning,
              ),
            ),
            Expanded(
              child: _SummaryItem(
                label: 'Soon',
                count: summary.soonCount,
                color: colors.secondary,
              ),
            ),
            Expanded(
              child: _SummaryItem(
                label: 'In time',
                count: summary.onTimeCount,
                color: colors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _SummaryItem({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: AppSpacing.space4),
            Text(
              '$count',
              style: AppTypography.title(
                context,
              )?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
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
