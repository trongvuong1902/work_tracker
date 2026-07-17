import 'package:go_router/go_router.dart';
import 'package:work_tracker/app/router/app_routes.dart';
import 'package:work_tracker/features/task/presentation/pages/task_list_page.dart';

class TaskBranch extends StatefulShellBranch {
  TaskBranch()
    : super(
        routes: [
          GoRoute(
            path: AppRoutes.tasks,
            builder: (context, state) => const TaskListPage(),
          ),
        ],
      );
}
