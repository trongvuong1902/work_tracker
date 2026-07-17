import 'package:flutter/material.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_connection.dart';
import 'package:work_tracker/features/zentao/domain/zentao_repository.dart';
import 'package:work_tracker/features/zentao/presentation/widgets/zentao_connect_form.dart';

/// Settings -> "Zentao account" row destination: shows the connected
/// instance + a "Disconnect" action, or the same Connect form inline if
/// not yet connected. Pops (with no return value) after a successful
/// connect or disconnect so the caller can refresh its status row.
Future<void> showManageZentaoConnectionSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => const _ManageZentaoConnectionSheet(),
  );
}

class _ManageZentaoConnectionSheet extends StatefulWidget {
  const _ManageZentaoConnectionSheet();

  @override
  State<_ManageZentaoConnectionSheet> createState() =>
      _ManageZentaoConnectionSheetState();
}

class _ManageZentaoConnectionSheetState
    extends State<_ManageZentaoConnectionSheet> {
  bool _isLoading = true;
  bool _isDisconnecting = false;
  ZentaoConnection? _connection;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final connection = await getIt<ZentaoRepository>().getConnection();
    if (mounted) {
      setState(() {
        _connection = connection;
        _isLoading = false;
      });
    }
  }

  Future<void> _disconnect() async {
    setState(() => _isDisconnecting = true);
    await getIt<ZentaoRepository>().disconnect();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Zentao account',
              style: AppTypography.title(
                context,
              )?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.space16),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_connection != null)
              _ConnectedCard(
                connection: _connection!,
                isDisconnecting: _isDisconnecting,
                onDisconnect: _disconnect,
              )
            else
              ZentaoConnectForm(
                onConnected: () {
                  if (mounted) Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _ConnectedCard extends StatelessWidget {
  const _ConnectedCard({
    required this.connection,
    required this.isDisconnecting,
    required this.onDisconnect,
  });

  final ZentaoConnection connection;
  final bool isDisconnecting;
  final VoidCallback onDisconnect;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              connection.domain,
              style: AppTypography.body(
                context,
              )?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(
              'Connected as ${connection.account}',
              style: AppTypography.caption(
                context,
              )?.copyWith(color: context.colors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.space16),
            SecondaryButton(
              label: 'Disconnect',
              isLoading: isDisconnecting,
              onPressed: onDisconnect,
            ),
          ],
        ),
      ),
    );
  }
}
