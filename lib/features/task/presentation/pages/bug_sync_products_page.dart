import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/task/presentation/cubit/bug_sync_products_cubit.dart';

/// "Choose products to sync" — the product multi-select step of the bulk
/// "Bugs assigned to me" flow. Pops with `true` once the selection is saved,
/// signalling the caller to (re)run the sync.
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

  Future<void> _save(BuildContext context) async {
    await context.read<BugSyncProductsCubit>().save();
    if (context.mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BugSyncProductsCubit, BugSyncProductsState>(
      builder: (context, state) {
        final cubit = context.read<BugSyncProductsCubit>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Products to sync'),
            actions: [
              if (!state.isLoading && state.errorMessage == null)
                TextButton(
                  onPressed: () => _save(context),
                  child: const Text('Save'),
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
