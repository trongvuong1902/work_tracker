import 'package:flutter/material.dart';

abstract final class AppShadow {
  static List<BoxShadow> get small => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.10),
          offset: const Offset(0, 2),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ];

  static List<BoxShadow> get medium => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          offset: const Offset(0, 4),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ];
}
