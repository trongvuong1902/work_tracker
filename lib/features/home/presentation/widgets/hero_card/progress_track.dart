import 'package:flutter/material.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/core/time/time_format.dart';
import 'package:work_tracker/core/typography/app_typography.dart';

/// A thumb-on-track day-progress bar with an optional floating "now" time
/// label above it. Shared by the full working-day card and the slim working
/// status strip, which uses smaller track/thumb sizes and hides the label.
class ProgressTrack extends StatelessWidget {
  const ProgressTrack({
    super.key,
    required this.progress,
    required this.now,
    this.trackHeight = 8,
    this.thumbSize = 16,
    this.showNowLabel = true,
  });

  final double progress;
  final DateTime now;
  final double trackHeight;
  final double thumbSize;
  final bool showNowLabel;

  static const double _labelWidth = 44;
  // Matches the original fixed layout: a 16px label plus 4px of breathing
  // room above the track.
  static const double _trackTopWithLabel = 20;
  static const double _heightWithLabel = 36;

  @override
  Widget build(BuildContext context) {
    // With the label shown, the track sits a fixed distance below it and the
    // thumb is vertically centered on the track within that same box. Without
    // the label, the track/thumb pair is centered in a box just tall enough
    // to fit the (larger) thumb.
    final trackTop = showNowLabel
        ? _trackTopWithLabel
        : (thumbSize - trackHeight) / 2;
    final thumbTop = showNowLabel
        ? _trackTopWithLabel - (thumbSize - trackHeight) / 2
        : 0.0;
    final height = showNowLabel ? _heightWithLabel : thumbSize;

    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final trackWidth = constraints.maxWidth;
          final thumbCenterX = progress * trackWidth;
          final thumbLeft = (thumbCenterX - thumbSize / 2).clamp(
            0.0,
            trackWidth - thumbSize,
          );
          final labelLeft = (thumbCenterX - _labelWidth / 2).clamp(
            0.0,
            trackWidth - _labelWidth,
          );

          return Stack(
            clipBehavior: Clip.none,
            children: [
              if (showNowLabel)
                Positioned(
                  left: labelLeft,
                  top: 0,
                  width: _labelWidth,
                  child: Text(
                    TimeFormat.hhMmFromDateTime(now),
                    textAlign: TextAlign.center,
                    style: AppTypography.caption(context)?.copyWith(
                      color: context.colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              Positioned(
                left: 0,
                right: 0,
                top: trackTop,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(trackHeight / 2),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: trackHeight,
                    backgroundColor: context.colors.surfaceSecondary,
                    color: context.colors.primary,
                  ),
                ),
              ),
              Positioned(
                left: thumbLeft,
                top: thumbTop,
                child: Container(
                  width: thumbSize,
                  height: thumbSize,
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(color: context.colors.primary, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
