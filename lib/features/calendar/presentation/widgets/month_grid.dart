import 'package:flutter/material.dart';
import 'package:work_tracker/features/calendar/domain/models/calendar_day.dart';

import 'day_cell.dart';

class MonthGrid extends StatelessWidget {
  final List<CalendarDayModel> days;

  const MonthGrid({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    const columns = 7;
    final rowCount = (days.length / columns).ceil();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var row = 0; row < rowCount; row++)
          Row(
            children: [
              for (var col = 0; col < columns; col++)
                Expanded(child: DayCell(day: days[row * columns + col])),
            ],
          ),
      ],
    );
  }
}
