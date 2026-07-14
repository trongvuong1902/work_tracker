import 'package:flutter/material.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/card/shadow_card.dart';
import 'package:work_tracker/components/inputs/app_minute_picker.dart';
import 'package:work_tracker/core/radius/app_radius.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';

/// A reusable row that shows a label and an editable minutes value, backed
/// by [showAppMinutePicker]. Used anywhere a fixed set of minute options
/// (e.g. a reminder buffer) needs to be picked via the app's iOS-style wheel
/// picker rather than a stepper.
class MinutePickerRow extends StatelessWidget {
  const MinutePickerRow({
    super.key,
    required this.label,
    required this.minutes,
    required this.options,
    required this.onChanged,
    this.enabled = true,
    this.placeholder = 'Not set',
    this.valueBuilder,
  });

  final String label;
  final int? minutes;
  final List<int> options;
  final ValueChanged<int> onChanged;
  final bool enabled;
  final String placeholder;

  /// Optional override for the value text, e.g. to append a derived time
  /// (`'10 min · 08:50'`) instead of the plain `'10 min'` default.
  final String Function(int minutes)? valueBuilder;

  @override
  Widget build(BuildContext context) {
    final valueStyle = AppTypography.body(context);

    return ShadowCard(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.radius8),
        onTap: enabled ? () => _pickMinutes(context) : null,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: enabled
                    ? AppTypography.label(context)
                    : AppTypography.label(
                        context,
                      )?.copyWith(color: context.colors.textSecondary),
              ),
              Text(
                minutes != null
                    ? (valueBuilder?.call(minutes!) ?? '$minutes min')
                    : placeholder,
                style: minutes != null
                    ? valueStyle
                    : valueStyle?.copyWith(color: context.colors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickMinutes(BuildContext context) async {
    final result = await showAppMinutePicker(
      context: context,
      initialMinutes: minutes ?? options.first,
      options: options,
    );
    if (result != null) onChanged(result);
  }
}
