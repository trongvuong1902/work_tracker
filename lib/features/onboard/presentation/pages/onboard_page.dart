import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/cubit/app_cubit.dart';
import 'package:work_tracker/components/buttons/primary_button.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'OnBoard Page',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            PrimaryButton(
              label: 'Complete Onboarding',
              onPressed: () {
                context.read<AppCubit>().completeOnboarding();
              },
            ),
          ],
        ),
      ),
    );
  }
}
