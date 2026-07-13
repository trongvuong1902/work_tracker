import 'package:go_router/go_router.dart';
import 'package:work_tracker/app/router/app_routes.dart';
import 'package:work_tracker/features/home/presentation/pages/home_page.dart';

class HomeBranch extends StatefulShellBranch {
  HomeBranch()
    : super(
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const HomePage(),
          ),
        ],
      );
}
