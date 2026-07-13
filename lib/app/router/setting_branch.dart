import 'package:go_router/go_router.dart';
import 'package:work_tracker/app/router/app_routes.dart';
import 'package:work_tracker/features/setting/presentation/pages/setting_page.dart';

class SettingBranch extends StatefulShellBranch {
  SettingBranch()
    : super(
        routes: [
          GoRoute(
            path: AppRoutes.settings,
            builder: (context, state) => const SettingPage(),
          ),
        ],
      );
}
