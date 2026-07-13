import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:work_tracker/app/router/app_router.dart';
import 'package:work_tracker/app/router/app_routes.dart';
import 'package:work_tracker/core/core.dart';

class DebugOverlay extends StatelessWidget {
  const DebugOverlay({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return child;

    return Stack(
      children: [
        child,
        Align(
          alignment: Alignment.bottomRight,
          child: SafeArea(
            minimum: const EdgeInsets.only(
              right: AppSpacing.space16,
              bottom: AppSpacing.space64,
            ),
            child: FloatingActionButton(
              heroTag: 'debug-components-fab',
              tooltip: 'View components (debug)',
              onPressed: () => appRouter.push(AppRoutes.debug),
              child: const Icon(Icons.widgets_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
