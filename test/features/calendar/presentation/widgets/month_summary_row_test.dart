import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:work_tracker/app/theme/app_theme.dart';
import 'package:work_tracker/features/calendar/domain/models/month_summary.dart';
import 'package:work_tracker/features/calendar/presentation/widgets/month_summary_row.dart';

/// Pumps [summary] inside a MaterialApp constrained to the width of the
/// smallest currently-supported iOS phone class (iPhone SE, 375 logical px),
/// which is the tightest layout this Row has to survive.
Future<void> _pumpNarrow(WidgetTester tester, MonthSummary summary) async {
  tester.view.physicalSize = const Size(375, 812);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: MonthSummaryRow(summary: summary)),
    ),
  );
}

void main() {
  group('MonthSummaryRow', () {
    testWidgets(
      'renders zero-state as a compact inline summary without exceptions',
      (tester) async {
        await _pumpNarrow(tester, const MonthSummary());

        expect(tester.takeException(), isNull);

        expect(find.text('late time'), findsOneWidget);
        expect(find.text('late days'), findsOneWidget);
        expect(find.text('overtime'), findsOneWidget);

        // Compact format: under an hour shows "Xm".
        expect(find.text('0m'), findsNWidgets(2));
        expect(find.text('0'), findsOneWidget);
      },
    );

    testWidgets(
      'uses compact durations and a singular "late day" label',
      (tester) async {
        const summary = MonthSummary(
          totalLateMinutes: 11,
          lateDayCount: 1,
          totalOvertimeMinutes: 45,
        );

        await _pumpNarrow(tester, summary);

        expect(find.text('11m'), findsOneWidget);
        expect(find.text('45m'), findsOneWidget);
        expect(find.text('1'), findsOneWidget);
        expect(find.text('late day'), findsOneWidget);
        expect(find.text('late days'), findsNothing);
      },
    );

    testWidgets(
      'formats values over an hour as "Hh Mm"',
      (tester) async {
        const summary = MonthSummary(
          totalLateMinutes: 245,
          lateDayCount: 3,
          totalOvertimeMinutes: 90,
        );

        await _pumpNarrow(tester, summary);

        expect(find.text('4h 5m'), findsOneWidget);
        expect(find.text('1h 30m'), findsOneWidget);
        expect(find.text('3'), findsOneWidget);
      },
    );

    testWidgets(
      'renders stress-test large values on a narrow screen without overflow',
      (tester) async {
        const stressSummary = MonthSummary(
          totalLateMinutes: 99999,
          lateDayCount: 31,
          totalOvertimeMinutes: 99999,
        );

        await _pumpNarrow(tester, stressSummary);

        expect(tester.takeException(), isNull);
        expect(find.text('late time'), findsOneWidget);
        expect(find.text('overtime'), findsOneWidget);
        expect(find.text('1666h 39m'), findsNWidgets(2));
        expect(find.text('31'), findsOneWidget);
      },
    );
  });
}
