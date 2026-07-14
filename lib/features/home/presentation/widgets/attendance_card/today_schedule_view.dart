import 'package:flutter/material.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/card/shadow_card.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/features/home/presentation/widgets/attendance_card/start_work_view.dart';

import 'plannend_leave_view.dart';

class TodayScheduleView extends StatelessWidget {
  const TodayScheduleView({
    super.key,
    required this.startWorkTime,
    required this.plannedEndWorkTime,
  });
  final String startWorkTime;
  final String plannedEndWorkTime;
  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TODAY SCHEDULE',
              style: AppTypography.body(
                context,
              )?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: AppSpacing.space8),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  StartWorkView(startWorkTime: startWorkTime),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: VerticalDivider(
                      color: context.colors.divider,
                      thickness: 1,
                      width: 1,
                    ),
                  ),
                  PlannendLeaveView(endTime: plannedEndWorkTime),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
