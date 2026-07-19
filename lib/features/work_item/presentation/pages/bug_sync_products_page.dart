import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/work_item/presentation/cubit/bug_sync_products_cubit.dart';
import 'package:work_tracker/features/work_item/presentation/widgets/bug_sync_runner.dart';

/// "Choose products to sync" — the product multi-select step of the "Bugs
/// assigned to me" flow. On confirm it saves the selection, runs the sync with
/// a progress dialog, and lands on the Tasks tab with the synced data.
class BugSyncProductsPage extends StatelessWidget {
  const BugSyncProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BugSyncProductsCubit>(),
      child: const _BugSyncProductsView(),
    );
  }
}

class _BugSyncProductsView extends StatelessWidget {
  const _BugSyncProductsView();

  /// Saves the selection, runs the bulk sync with a progress dialog, reports a
  /// summary, and navigates to the Tasks tab (which reactively shows the synced
  /// rows).
  Future<void> _confirmAndSync(BuildContext context) async {
    await context.read<BugSyncProductsCubit>().save();
    if (!context.mounted) return;
    await runBugSyncWithProgress(context);
    if (!context.mounted) return;
    AppNavigator.goTasks(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BugSyncProductsCubit, BugSyncProductsState>(
      builder: (context, state) {
        final cubit = context.read<BugSyncProductsCubit>();
        final canSync = !state.isLoading &&
            state.errorMessage == null &&
            state.selectedIds.isNotEmpty;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Products to sync'),
            actions: [
              if (canSync)
                TextButton(
                  onPressed: () => _confirmAndSync(context),
                  child: const Text('Sync'),
                ),
            ],
          ),
          body: SafeArea(child: _buildBody(context, state, cubit)),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    BugSyncProductsState state,
    BugSyncProductsCubit cubit,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: context.colors.textSecondary,
              ),
              const SizedBox(height: AppSpacing.space16),
              Text(
                state.errorMessage!,
                textAlign: TextAlign.center,
                style: AppTypography.body(
                  context,
                )?.copyWith(color: context.colors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.space16),
              SecondaryButton(
                label: 'Retry',
                expanded: false,
                onPressed: cubit.load,
              ),
            ],
          ),
        ),
      );
    }

    if (state.products.isEmpty) {
      return Center(
        child: Text(
          'No products found on this Zentao instance.',
          style: AppTypography.body(
            context,
          )?.copyWith(color: context.colors.textSecondary),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.space16,
            AppSpacing.space16,
            AppSpacing.space16,
            AppSpacing.space8,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Bugs assigned to you under the selected products will be '
              'synced into your task list.',
              style: AppTypography.caption(
                context,
              )?.copyWith(color: context.colors.textSecondary),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space16,
            ),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              final selected = state.selectedIds.contains(product.id);
              return CheckboxListTile(
                value: selected,
                onChanged: (_) => cubit.toggle(product.id),
                title: Text(product.name, style: AppTypography.label(context)),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: context.colors.primary,
              );
            },
          ),
        ),
      ],
    );
  }
}
