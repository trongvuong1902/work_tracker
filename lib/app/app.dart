import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/theme/app_theme.dart';
import 'package:work_tracker/di/injection.dart';

import 'cubit/app_cubit.dart';
import 'router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => getIt<AppCubit>())],

      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) => MaterialApp.router(
          title: 'Work Tracker',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: state.themeMode,
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
