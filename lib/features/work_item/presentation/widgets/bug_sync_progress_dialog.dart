import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/features/work_item/presentation/cubit/bug_sync_cubit.dart';

/// Modal progress shown while [BugSyncCubit.sync] runs. Kicks off the sync on
/// first build and closes itself once the cubit reports `done`; the caller then
/// reads the final state for the summary snackbar.
class BugSyncProgressDialog extends StatefulWidget {
  const BugSyncProgressDialog({super.key});

  @override
  State<BugSyncProgressDialog> createState() => _BugSyncProgressDialogState();
}

class _BugSyncProgressDialogState extends State<BugSyncProgressDialog> {
  @override
  void initState() {
    super.initState();
    context.read<BugSyncCubit>().sync();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BugSyncCubit, BugSyncState>(
      listenWhen: (prev, next) => !prev.done && next.done,
      listener: (context, state) => Navigator.of(context).pop(),
      child: BlocBuilder<BugSyncCubit, BugSyncState>(
        builder: (context, state) {
          return AlertDialog(
            content: Row(
              children: [
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: AppSpacing.space16),
                Expanded(
                  child: Text(
                    state.progressText ?? 'Syncing bugs…',
                    style: AppTypography.body(context),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
