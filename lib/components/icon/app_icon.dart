import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key, required this.backgroundColor, required this.icon});
  final Color backgroundColor;
  final Widget icon;
  final Size size = const Size(40, 40);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: icon,
      ),
    );
  }
}
