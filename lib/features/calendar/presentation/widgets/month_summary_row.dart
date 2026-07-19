import 'package:flutter/material.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/features/calendar/domain/models/month_summary.dart';

/// A slim one-line month summary:
/// `11m late time | 1 late day | 45m overtime`.
class MonthSummaryRow extends StatelessWidget {
  final MonthSummary summary;

  const MonthSummaryRow({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final lateDays = summary.lateDayCount;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Stat(
          value: _compact(summary.totalLateMinutes),
          label: 'late time',
          color: colors.warning,
        ),
        _divider(context),
        _Stat(
          value: '$lateDays',
          label: lateDays == 1 ? 'late day' : 'late days',
          color: colors.warning,
        ),
        _divider(context),
        _Stat(
          value: _compact(summary.totalOvertimeMinutes),
          label: 'overtime',
          color: colors.tertiary,
        ),
      ],
    );
  }

  Widget _divider(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space8),
    child: Text(
      '|',
      style: AppTypography.caption(
        context,
      )?.copyWith(color: context.colors.divider),
    ),
  );

  /// Compact duration: `Xm` under an hour, else `Hh MMm`.
  static String _compact(int minutes) {
    if (minutes < 60) return '${minutes}m';
    final h = minutes ~/ 60;
    final m = minutes % 60;
    return m == 0 ? '${h}h' : '${h}h ${m}m';
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, required this.color});

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: AppSpacing.space4),
            Text(
              value,
              style: AppTypography.caption(
                context,
              )?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: AppSpacing.space4),
            Text(
              label,
              style: AppTypography.caption(
                context,
              )?.copyWith(color: context.colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
