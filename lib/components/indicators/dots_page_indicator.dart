import 'package:flutter/material.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/core/radius/app_radius.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';

/// A row of dots showing the current position in a fixed-length paged flow.
///
/// Purely presentational: the active dot widens into a short pill while
/// inactive dots stay small circles. Not tappable.
class DotsPageIndicator extends StatelessWidget {
  const DotsPageIndicator({
    super.key,
    required this.pageCount,
    required this.currentPage,
  });

  final int pageCount;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(pageCount, (index) {
        final isActive = index == currentPage;
        return Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? 0 : AppSpacing.space8,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isActive ? 20 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: isActive ? context.colors.primary : context.colors.outline,
              borderRadius: BorderRadius.circular(AppRadius.radius4),
            ),
          ),
        );
      }),
    );
  }
}
