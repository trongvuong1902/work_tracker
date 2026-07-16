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
      'renders default/zero-state summary without exceptions and shows labels',
      (tester) async {
        await _pumpNarrow(tester, const MonthSummary());

        expect(tester.takeException(), isNull);

        expect(find.text('Late time'), findsOneWidget);
        expect(find.text('Late days'), findsOneWidget);
        expect(find.text('Overtime'), findsOneWidget);

        expect(find.text('0h 00m'), findsNWidgets(2));
        expect(find.text('0'), findsOneWidget);
      },
    );

    testWidgets(
      'renders stress-test large values on a narrow (iPhone SE width) screen '
      'without a RenderFlex overflow exception',
      (tester) async {
        const stressSummary = MonthSummary(
          totalLateMinutes: 99999,
          lateDayCount: 31,
          totalOvertimeMinutes: 99999,
        );

        await _pumpNarrow(tester, stressSummary);

        // The concrete regression guard: a "RenderFlex overflowed" (or any
        // other) exception thrown during layout/paint would be captured
        // here by the test framework rather than surfacing as a passing
        // test.
        expect(tester.takeException(), isNull);

        expect(find.text('Late time'), findsOneWidget);
        expect(find.text('Late days'), findsOneWidget);
        expect(find.text('Overtime'), findsOneWidget);

        // 99999 minutes -> 1666h 39m via TimeFormat.hMm.
        expect(find.text('1666h 39m'), findsNWidgets(2));
        expect(find.text('31'), findsOneWidget);
      },
    );

    testWidgets(
      'tapping the Late time tile toggles only its own format, independent '
      'of the Overtime tile',
      (tester) async {
        const summary = MonthSummary(
          totalLateMinutes: 245,
          lateDayCount: 3,
          totalOvertimeMinutes: 90,
        );

        await _pumpNarrow(tester, summary);

        expect(find.text('4h 05m'), findsOneWidget);
        expect(find.text('1h 30m'), findsOneWidget);

        await tester.tap(find.text('4h 05m'));
        await tester.pump();

        expect(find.text('245m'), findsOneWidget);
        expect(find.text('4h 05m'), findsNothing);
        // Overtime tile is unaffected by tapping the Late time tile.
        expect(find.text('1h 30m'), findsOneWidget);

        // Tapping again toggles back.
        await tester.tap(find.text('245m'));
        await tester.pump();

        expect(find.text('4h 05m'), findsOneWidget);
        expect(find.text('245m'), findsNothing);
      },
    );

    testWidgets(
      'tapping the Overtime tile toggles only its own format, independent '
      'of the Late time tile',
      (tester) async {
        const summary = MonthSummary(
          totalLateMinutes: 245,
          lateDayCount: 3,
          totalOvertimeMinutes: 90,
        );

        await _pumpNarrow(tester, summary);

        await tester.tap(find.text('1h 30m'));
        await tester.pump();

        expect(find.text('90m'), findsOneWidget);
        expect(find.text('1h 30m'), findsNothing);
        // Late time tile is unaffected by tapping the Overtime tile.
        expect(find.text('4h 05m'), findsOneWidget);
      },
    );

    testWidgets('Late days tile is not tappable and stays a plain count', (
      tester,
    ) async {
      const summary = MonthSummary(
        totalLateMinutes: 245,
        lateDayCount: 3,
        totalOvertimeMinutes: 90,
      );

      await _pumpNarrow(tester, summary);

      await tester.tap(find.text('3'));
      await tester.pump();

      expect(find.text('3'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
