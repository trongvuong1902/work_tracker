import 'package:flutter/material.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/card/shadow_card.dart';
import 'package:work_tracker/components/inputs/app_time_picker.dart';
import 'package:work_tracker/core/radius/app_radius.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';

/// A reusable row that shows a label and an editable timestamp value.
///
/// Unlike the schedule feature's minute-of-day time row, this widget works
/// with a nullable [DateTime] since check-in/check-out are real timestamps,
/// not just a minute-of-day offset.
class TimePickerRow extends StatelessWidget {
  const TimePickerRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.placeholder = 'Not set',
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final bool enabled;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    final valueStyle = AppTypography.body(context);

    return ShadowCard(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.radius8),
        onTap: enabled ? () => _pickTime(context) : null,
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
                value != null
                    ? TimeOfDay.fromDateTime(value!).format(context)
                    : placeholder,
                style: value != null
                    ? valueStyle
                    : valueStyle?.copyWith(color: context.colors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickTime(BuildContext context) async {
    final result = await showAppTimePicker(
      context: context,
      initialTime: value != null
          ? TimeOfDay.fromDateTime(value!)
          : TimeOfDay.now(),
    );
    if (result != null) {
      final now = DateTime.now();
      onChanged(
        DateTime(now.year, now.month, now.day, result.hour, result.minute),
      );
    }
  }
}
