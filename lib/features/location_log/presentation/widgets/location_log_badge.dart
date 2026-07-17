import 'package:flutter/material.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/features/location_log/domain/models/location_log_type.dart';

/// The 3 audit-badge tiers a [LocationLogEventRow] can show, per the
/// location-activity design (§7): whether the event became that day's
/// check-in/check-out, was eligible but unused, or is an ordinary
/// subsequent event with no badge at all.
enum LocationLogBadgeTier { assigned, notUsed, none }

class LocationLogBadge extends StatelessWidget {
  const LocationLogBadge({super.key, required this.tier, required this.type});

  final LocationLogBadgeTier tier;
  final LocationLogType type;

  @override
  Widget build(BuildContext context) {
    switch (tier) {
      case LocationLogBadgeTier.none:
        return const SizedBox.shrink();
      case LocationLogBadgeTier.assigned:
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space12,
            vertical: AppSpacing.space4,
          ),
          decoration: BoxDecoration(
            color: context.colors.primaryLight,
            borderRadius: BorderRadius.circular(AppRadius.radius24),
          ),
          child: Text(
            type == LocationLogType.arrival
                ? 'Set check-in'
                : 'Set check-out',
            style: AppTypography.caption(context)?.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      case LocationLogBadgeTier.notUsed:
        return Text(
          type == LocationLogType.arrival
              ? 'Not used — check-in already set'
              : 'Not used — check-out already set',
          style: AppTypography.caption(
            context,
          )?.copyWith(color: context.colors.textSecondary),
        );
    }
  }
}
