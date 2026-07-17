import 'package:flutter/material.dart';
import 'package:work_tracker/components/icon/app_icon.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/features/location_log/domain/models/location_log.dart';
import 'package:work_tracker/features/location_log/domain/models/location_log_type.dart';
import 'package:work_tracker/features/location_log/presentation/widgets/location_log_badge.dart';

/// One row of a location activity timeline (arrival or departure), shared by
/// the Home "Today's Activity" card and the full-history screens. Purely
/// presentational — the badge tier is computed by the caller.
class LocationLogEventRow extends StatelessWidget {
  const LocationLogEventRow({
    super.key,
    required this.log,
    this.badgeTier = LocationLogBadgeTier.none,
  });

  final LocationLog log;
  final LocationLogBadgeTier badgeTier;

  @override
  Widget build(BuildContext context) {
    final isArrival = log.type == LocationLogType.arrival;
    return Row(
      spacing: AppSpacing.space8,
      children: [
        AppIcon(
          icon: Icon(
            isArrival ? Icons.login : Icons.logout,
            color: isArrival ? context.colors.primary : context.colors.error,
          ),
          backgroundColor: isArrival
              ? context.colors.primaryLight
              : context.colors.error.withValues(alpha: 0.12),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.space4,
            children: [
              Text(
                isArrival ? 'Arrived' : 'Left',
                style: AppTypography.label(context)?.copyWith(
                  color: context.colors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                TimeFormat.hhMmFromDateTime(log.timestamp),
                style: AppTypography.body(context)?.copyWith(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        LocationLogBadge(tier: badgeTier, type: log.type),
      ],
    );
  }
}
