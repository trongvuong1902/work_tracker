import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Shows an iOS-style scrolling wheel time picker, matching this app's
/// iOS-first design principle (in place of Material's dial [showTimePicker]).
/// Returns the picked [TimeOfDay], or null if the user dismissed without
/// tapping Done.
Future<TimeOfDay?> showAppTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
}) async {
  var selected = initialTime;

  final confirmed = await showCupertinoModalPopup<bool>(
    context: context,
    builder: (context) => Container(
      height: 260,
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: CupertinoButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Done'),
            ),
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              use24hFormat: false,
              initialDateTime: DateTime(
                2000,
                1,
                1,
                initialTime.hour,
                initialTime.minute,
              ),
              onDateTimeChanged: (dateTime) {
                selected = TimeOfDay(
                  hour: dateTime.hour,
                  minute: dateTime.minute,
                );
              },
            ),
          ),
        ],
      ),
    ),
  );

  return confirmed == true ? selected : null;
}
