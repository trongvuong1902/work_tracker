import 'package:flutter/material.dart';
import 'package:work_tracker/components/card/shadow_card.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/features/location_log/domain/models/location_log.dart';
import 'package:work_tracker/features/location_log/presentation/widgets/location_log_badge.dart';
import 'package:work_tracker/features/location_log/presentation/widgets/location_log_event_row.dart';

/// Date header + a [ShadowCard] of that day's [LocationLogEventRow]s, slim
/// dividers between rows — one section per day on Screen A's day-grouped
/// history list.
class LocationLogDaySection extends StatelessWidget {
  const LocationLogDaySection({
    super.key,
    required this.date,
    required this.events,
    required this.badges,
    this.onAssignedTap,
  });

  final DateTime date;
  final List<LocationLog> events;
  final Map<LocationLog, LocationLogBadgeTier> badges;

  /// Called when an "assigned" badge row is tapped, i.e. this event became
  /// that day's check-in/check-out.
  final VoidCallback? onAssignedTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locationLogDayLabel(date),
          style: AppTypography.label(
            context,
          )?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSpacing.space8),
        ShadowCard(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.space16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final log in events) ...[
                  _EventRow(
                    log: log,
                    tier: badges[log] ?? LocationLogBadgeTier.none,
                    onAssignedTap: onAssignedTap,
                  ),
                  if (log != events.last)
                    Divider(height: AppSpacing.space24, color: context.colors.outline),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EventRow extends StatelessWidget {
  const _EventRow({required this.log, required this.tier, this.onAssignedTap});

  final LocationLog log;
  final LocationLogBadgeTier tier;
  final VoidCallback? onAssignedTap;

  @override
  Widget build(BuildContext context) {
    final row = LocationLogEventRow(log: log, badgeTier: tier);
    if (tier != LocationLogBadgeTier.assigned || onAssignedTap == null) {
      return row;
    }
    return InkWell(onTap: onAssignedTap, child: row);
  }
}

/// Date header label matching [DaySummaryView]'s convention (weekday
/// initial + day + month + year), with a "Today"/"Yesterday" suffix.
String locationLogDayLabel(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final dateOnly = DateTime(date.year, date.month, date.day);

  final base =
      '${weekdayInitials[date.weekday - 1]}, ${date.day} '
      '${monthNames[date.month - 1]} ${date.year}';

  if (dateOnly == today) return '$base · Today';
  if (dateOnly == yesterday) return '$base · Yesterday';
  return base;
}
