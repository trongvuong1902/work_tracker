import 'package:flutter/material.dart';
import 'package:work_tracker/components/card/shadow_card.dart';
import 'package:work_tracker/core/typography/app_typography.dart';

class AttendanceCheckInView extends StatelessWidget {
  const AttendanceCheckInView({super.key});

  @override
  Widget build(BuildContext context) {
    final plainedTime = DateTime.now().add(const Duration(hours: 1));
    return ShadowCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          spacing: 12,
          children: [
            icon(context, Icons.access_time),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'CHECK IN',
                  style: AppTypography.title(
                    context,
                  )?.copyWith(fontWeight: FontWeight.w500),
                ),
                Text('08:00 AM', style: AppTypography.body(context)),
                Text(
                  'Plained ${plainedTime.hour}:${plainedTime.minute} PM',
                  style: AppTypography.body(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget icon(BuildContext context, IconData iconData) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(iconData, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
