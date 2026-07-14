import 'package:flutter/cupertino.dart';

/// Shows an iOS-style scrolling wheel picker over a fixed list of minute
/// values, matching this app's iOS-first design principle (see
/// [showAppTimePicker] for the equivalent time-of-day picker). Returns the
/// picked value, or null if the user dismissed without tapping Done.
Future<int?> showAppMinutePicker({
  required BuildContext context,
  required int initialMinutes,
  required List<int> options,
}) async {
  final initialIndex = options.indexOf(initialMinutes);
  var selected = initialIndex == -1 ? options.first : initialMinutes;

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
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                initialItem: initialIndex == -1 ? 0 : initialIndex,
              ),
              itemExtent: 32,
              onSelectedItemChanged: (index) => selected = options[index],
              children: options
                  .map((minutes) => Center(child: Text('$minutes min')))
                  .toList(),
            ),
          ),
        ],
      ),
    ),
  );

  return confirmed == true ? selected : null;
}
