import 'package:flutter/material.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/card/shadow_card.dart';
import 'package:work_tracker/core/time/time_format.dart';
import 'package:work_tracker/core/typography/app_typography.dart';

/// State D hero — a short confirmation line once checked out; the detailed
/// numbers live in [TodaySummaryView] below.
class CheckedOutHero extends StatelessWidget {
  const CheckedOutHero({super.key, required this.checkOutAt});

  final DateTime checkOutAt;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Checked out at ${TimeFormat.hhMmFromDateTime(checkOutAt)} — nice work.',
          textAlign: TextAlign.center,
          style: AppTypography.body(context)?.copyWith(
            color: context.colors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
