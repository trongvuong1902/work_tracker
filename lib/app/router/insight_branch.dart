import 'package:go_router/go_router.dart';
import 'package:work_tracker/app/router/app_routes.dart';
import 'package:work_tracker/features/insight/presentation/pages/insight_page.dart';

class InsightBranch extends StatefulShellBranch {
  InsightBranch()
    : super(
        routes: [
          GoRoute(
            path: AppRoutes.statistics,
            builder: (context, state) => const InsightPage(),
          ),
        ],
      );
}
