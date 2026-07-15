import 'package:flutter/widgets.dart';
import 'package:work_tracker/components/components.dart';

class InsightPage extends StatefulWidget {
  const InsightPage({super.key});

  @override
  State<InsightPage> createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
  @override
  Widget build(BuildContext context) {
    return const ComingSoonView(
      title: 'Insight',
      message: 'Insight view is coming in a future update.',
    );
  }
}
