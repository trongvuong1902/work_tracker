import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/work_item/presentation/cubit/bug_sync_cubit.dart';
import 'package:work_tracker/features/work_item/presentation/widgets/bug_sync_progress_dialog.dart';

/// Runs the bulk "Bugs assigned to me" sync for the already-selected products,
/// showing the progress dialog and a summary snackbar. Does not navigate — the
/// caller decides where to go afterwards. The task list refreshes reactively
/// via `watchTasksChanges`.
Future<void> runBugSyncWithProgress(BuildContext context) async {
  final messenger = ScaffoldMessenger.of(context);
  final cubit = getIt<BugSyncCubit>();
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: const BugSyncProgressDialog(),
    ),
  );
  final result = cubit.state;
  await cubit.close();
  if (!context.mounted) return;

  if (result.errorMessage != null) {
    messenger.showSnackBar(SnackBar(content: Text(result.errorMessage!)));
  } else {
    final failed = result.failedProducts > 0
        ? ' · ${result.failedProducts} product(s) failed'
        : '';
    messenger.showSnackBar(
      SnackBar(
        content: Text('Added ${result.added} · Updated ${result.updated}$failed'),
      ),
    );
  }
}
