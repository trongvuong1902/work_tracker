import 'package:flutter/material.dart';

abstract final class AppTypography {
  static TextStyle? headline(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall;
  static TextStyle? title(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge;
  static TextStyle? subtitle(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium;
  static TextStyle? body(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium;
  static TextStyle? label(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge;
  static TextStyle? caption(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall;
}
