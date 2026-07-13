import 'package:flutter/material.dart';
import 'package:work_tracker/app/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap();
}
