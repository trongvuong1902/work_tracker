import 'package:flutter/material.dart';
import 'package:work_tracker/core/shadow/app_shadow.dart';

class ShadowCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final EdgeInsetsGeometry margin;
  final ShapeBorder shape;

  const ShadowCard({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.margin = const EdgeInsets.all(8.0),
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: shape is RoundedRectangleBorder
            ? (shape as RoundedRectangleBorder).borderRadius
            : null,
        boxShadow: AppShadow.small,
      ),
      margin: margin,
      child: child,
    );
  }
}
