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
          alignment: Alignment.topRight,
          child: SafeArea(
            minimum: const EdgeInsets.only(
              right: AppSpacing.space8,
              top: AppSpacing.space8,
            ),
            child: Opacity(
              opacity: 0.6,
              child: Material(
                color: Colors.black87,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => appRouter.push(AppRoutes.debug),
                  child: const Padding(
                    padding: EdgeInsets.all(AppSpacing.space8),
                    child: Icon(
                      Icons.widgets_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
