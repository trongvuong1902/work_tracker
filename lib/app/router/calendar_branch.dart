import 'package:go_router/go_router.dart';
import 'package:work_tracker/app/router/app_routes.dart';
import 'package:work_tracker/features/calendar/presentation/pages/calendar_page.dart';

class CalendarBranch extends StatefulShellBranch {
  CalendarBranch()
    : super(
        routes: [
          GoRoute(
            path: AppRoutes.calendar,
            builder: (context, state) => const CalendarPage(),
          ),
        ],
      );
}
