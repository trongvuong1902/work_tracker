import 'package:flutter/material.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/features/zentao/presentation/widgets/zentao_connect_form.dart';

/// Pushed when there's no existing Zentao connection. On a successful connect
/// it *replaces* itself with the "products to sync" page, so the streamlined
/// flow is connect → pick products → sync → Tasks, and back from products
/// returns to whatever was under this form rather than to the form itself.
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
                AppNavigator.pushReplacementBugSyncProducts(context),
          ),
        ),
      ),
    );
  }
}
