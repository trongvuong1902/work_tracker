import 'package:flutter/widgets.dart';
import 'package:work_tracker/components/components.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return const ComingSoonView(
      title: 'Calendar',
      message: 'Calendar view is coming in a future update.',
    );
  }
}
