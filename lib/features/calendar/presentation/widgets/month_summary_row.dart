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
                label: 'Late time',
                totalMinutes: summary.totalLateMinutes,
                color: colors.warning,
              ),
            ),
            Expanded(
              child: _SummaryItem(
                label: 'Late days',
                fixedValue: '${summary.lateDayCount}',
                color: colors.warning,
              ),
            ),
            Expanded(
              child: _SummaryItem(
                label: 'Overtime',
                totalMinutes: summary.totalOvertimeMinutes,
                color: colors.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A single stat tile. If [totalMinutes] is given, the tile is tappable and
/// toggles its own display between [TimeFormat.hMm] and
/// [TimeFormat.totalMinutesLabel] — purely a display-formatting choice, not
/// business state, so it lives here rather than in `CalendarState`.
/// Otherwise [fixedValue] is shown as a plain, non-tappable value (e.g.
/// "Late days").
class _SummaryItem extends StatefulWidget {
  final String label;
  final int? totalMinutes;
  final String? fixedValue;
  final Color color;

  const _SummaryItem({
    required this.label,
    this.totalMinutes,
    this.fixedValue,
    required this.color,
  }) : assert(
         (totalMinutes != null) != (fixedValue != null),
         'Provide exactly one of totalMinutes or fixedValue.',
       );

  @override
  State<_SummaryItem> createState() => _SummaryItemState();
}

class _SummaryItemState extends State<_SummaryItem> {
  bool _showTotalMinutes = false;

  void _toggleFormat() {
    setState(() => _showTotalMinutes = !_showTotalMinutes);
  }

  @override
  Widget build(BuildContext context) {
    final isTappable = widget.totalMinutes != null;
    final value = isTappable
        ? (_showTotalMinutes
              ? TimeFormat.totalMinutesLabel(widget.totalMinutes!)
              : TimeFormat.hMm(widget.totalMinutes!))
        : widget.fixedValue!;

    final content = Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSpacing.space4),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.title(
                    context,
                  )?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.space4),
        Text(
          widget.label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.caption(
            context,
          )?.copyWith(color: context.colors.textSecondary),
        ),
      ],
    );

    return isTappable
        ? InkWell(onTap: _toggleFormat, child: content)
        : content;
  }
}
