import 'package:flutter/material.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/features/zentao/presentation/widgets/zentao_connect_form.dart';

/// Pushed from the Platform Picker when there's no existing Zentao
/// connection. On a successful connect it *replaces* itself with the Select
/// Option screen (Tasks vs Bugs assigned to me), so the back button from
/// there returns to the Platform Picker rather than back to this form.
class ZentaoConnectPage extends StatelessWidget {
  const ZentaoConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connect Zentao')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: ZentaoConnectForm(
            onConnected: () =>
                AppNavigator.pushReplacementZentaoSelectOption(context),
          ),
        ),
      ),
    );
  }
}
