import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';

/// Asks the user to confirm the time spent before resolving a Zentao bug,
/// pre-filled with [suggestedMinutes] (the already-tracked total). Returns the
/// confirmed duration in minutes, or `null` if the user cancelled — in which
/// case the caller must not resolve.
Future<int?> showResolveDurationSheet(
  BuildContext context, {
  required int suggestedMinutes,
}) {
  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => _ResolveDurationSheet(suggestedMinutes: suggestedMinutes),
  );
}

class _ResolveDurationSheet extends StatefulWidget {
  const _ResolveDurationSheet({required this.suggestedMinutes});

  final int suggestedMinutes;

  @override
  State<_ResolveDurationSheet> createState() => _ResolveDurationSheetState();
}

class _ResolveDurationSheetState extends State<_ResolveDurationSheet> {
  late final TextEditingController _hoursController;
  late final TextEditingController _minutesController;

  @override
  void initState() {
    super.initState();
    _hoursController = TextEditingController(
      text: (widget.suggestedMinutes ~/ 60).toString(),
    );
    _minutesController = TextEditingController(
      text: (widget.suggestedMinutes % 60).toString(),
    );
  }

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    super.dispose();
  }

  void _confirm() {
    final hours = int.tryParse(_hoursController.text.trim()) ?? 0;
    final minutes = int.tryParse(_minutesController.text.trim()) ?? 0;
    final total = (hours * 60 + minutes).clamp(0, 24 * 60 * 999);
    Navigator.of(context).pop(total);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.space16,
          0,
          AppSpacing.space16,
          AppSpacing.space16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Time spent', style: AppTypography.title(context)),
                IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: 'Cancel',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(
              'Confirm the time to report on Zentao. Pre-filled from your '
              'tracked time.',
              style: AppTypography.body(
                context,
              )?.copyWith(color: context.colors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.space16),
            Row(
              children: [
                Expanded(
                  child: _DurationField(
                    controller: _hoursController,
                    label: 'Hours',
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: _DurationField(
                    controller: _minutesController,
                    label: 'Minutes',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space16),
            PrimaryButton(
              label: 'Resolve',
              icon: Icons.check_circle_outline,
              onPressed: _confirm,
            ),
          ],
        ),
      ),
    );
  }
}

class _DurationField extends StatelessWidget {
  const _DurationField({required this.controller, required this.label});

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
