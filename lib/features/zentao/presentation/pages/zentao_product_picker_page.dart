import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/task/domain/models/task.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_bug.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_import_kind.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_task.dart';
import 'package:work_tracker/features/zentao/presentation/cubit/zentao_product_picker_cubit.dart';

/// Product Picker step of the "Import from platform -> Zentao" flow —
/// replaces the design doc's generic Ticket List. Shows a flat list of
/// products; tapping one shows a loading state while the repository fetches
/// tasks or bugs (per [kind]) assigned to me under it, then the resulting
/// list (all within this same page/cubit — no separate route for the item
/// list). Tapping an item imports it immediately and pops the whole flow
/// back to the Task List with a confirmation snackbar.
class ZentaoProductPickerPage extends StatelessWidget {
  const ZentaoProductPickerPage({super.key, required this.kind});

  final ZentaoImportKind kind;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ZentaoProductPickerCubit(getIt(), getIt(), kind: kind),
      child: const _ZentaoProductPickerView(),
    );
  }
}

class _ZentaoProductPickerView extends StatefulWidget {
  const _ZentaoProductPickerView();

  @override
  State<_ZentaoProductPickerView> createState() =>
      _ZentaoProductPickerViewState();
}

class _ZentaoProductPickerViewState extends State<_ZentaoProductPickerView> {
  Future<void> _importTask(ZentaoTask task) async {
    final cubit = context.read<ZentaoProductPickerCubit>();
    await _handleImportResult(await cubit.importTask(task));
  }

  Future<void> _importBug(ZentaoBug bug) async {
    final cubit = context.read<ZentaoProductPickerCubit>();
    await _handleImportResult(await cubit.importBug(bug));
  }

  /// On a non-null [imported], returns to the Task List with a confirmation
  /// snackbar.
  Future<void> _handleImportResult(Task? imported) async {
    if (imported == null || !mounted) return;

    // Capture the (app-root) ScaffoldMessenger before navigating — it's the
    // single instance `MaterialApp` wraps the whole app in, so it stays valid
    // even after this page (several levels deep) is gone.
    final messenger = ScaffoldMessenger.of(context);
    // Go to the Tasks tab explicitly. This clears the whole import flow AND
    // guarantees we land on the Task List (which reloads on return), unlike
    // popUntil(isFirst), which in this shell setup can leave the app on a
    // different bottom-nav branch so the freshly imported task looks missing.
    AppNavigator.goTasks(context);
    messenger.showSnackBar(
      SnackBar(content: Text("Imported '${imported.title}'")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ZentaoProductPickerCubit, ZentaoProductPickerState>(
      builder: (context, state) {
        final cubit = context.read<ZentaoProductPickerCubit>();
        final showingItems = state.selectedProduct != null;
        final kindLabel = cubit.kind == ZentaoImportKind.task
            ? 'Tasks'
            : 'Bugs';

        return Scaffold(
          appBar: AppBar(
            title: Text(
              showingItems
                  ? '$kindLabel — ${state.selectedProduct!.name}'
                  : 'Pick a product',
            ),
            leading: showingItems
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: cubit.backToProducts,
                  )
                : null,
          ),
          body: SafeArea(
            child: showingItems
                ? _buildItems(context, state, cubit)
                : _buildProducts(context, state, cubit),
          ),
        );
      },
    );
  }

  Widget _buildProducts(
    BuildContext context,
    ZentaoProductPickerState state,
    ZentaoProductPickerCubit cubit,
  ) {
    if (state.isLoadingProducts) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.productsError != null) {
      return _MessageView(
        icon: Icons.error_outline,
        message: state.productsError!,
        retryLabel: 'Retry',
        onRetry: cubit.loadProducts,
      );
    }

    if (state.products.isEmpty) {
      return const _MessageView(
        icon: Icons.inventory_2_outlined,
        message: 'No products found on this Zentao instance.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.space16),
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        final product = state.products[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.space8),
          child: _PickerRow(
            title: product.name,
            onTap: () => cubit.selectProduct(product),
          ),
        );
      },
    );
  }

  Widget _buildItems(
    BuildContext context,
    ZentaoProductPickerState state,
    ZentaoProductPickerCubit cubit,
  ) {
    final isTaskMode = cubit.kind == ZentaoImportKind.task;
    final noun = isTaskMode ? 'tasks' : 'bugs';

    if (state.isLoadingItems) {
      return _MessageView(
        icon: null,
        message: 'Loading $noun assigned to you…',
        showSpinner: true,
      );
    }

    if (state.itemsError != null) {
      return _MessageView(
        icon: Icons.error_outline,
        message: state.itemsError!,
        retryLabel: 'Retry',
        onRetry: () => cubit.selectProduct(state.selectedProduct!),
      );
    }

    final itemCount = isTaskMode ? state.tasks.length : state.bugs.length;
    if (itemCount == 0) {
      return _MessageView(
        icon: Icons.checklist_rounded,
        message: 'No $noun assigned to you under this product.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.space16),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final child = isTaskMode
            ? _buildTaskRow(state, state.tasks[index])
            : _buildBugRow(state, state.bugs[index]);
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.space8),
          child: child,
        );
      },
    );
  }

  Widget _buildTaskRow(ZentaoProductPickerState state, ZentaoTask task) {
    final isImporting = state.importingId == task.id;
    return _TaskPickerRow(
      task: task,
      isImporting: isImporting,
      onTap: state.importingId != null ? null : () => _importTask(task),
    );
  }

  Widget _buildBugRow(ZentaoProductPickerState state, ZentaoBug bug) {
    final isImporting = state.importingId == bug.id;
    return _BugPickerRow(
      bug: bug,
      isImporting: isImporting,
      onTap: state.importingId != null ? null : () => _importBug(bug),
    );
  }
}

class _PickerRow extends StatelessWidget {
  const _PickerRow({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: Row(
            children: [
              Expanded(
                child: Text(title, style: AppTypography.label(context)),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskPickerRow extends StatelessWidget {
  const _TaskPickerRow({
    required this.task,
    required this.isImporting,
    required this.onTap,
  });

  final ZentaoTask task;
  final bool isImporting;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.name,
                      style: AppTypography.label(
                        context,
                      )?.copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.space4),
                    Text(
                      '#${task.id} · ${task.status}',
                      style: AppTypography.caption(
                        context,
                      )?.copyWith(color: context.colors.textSecondary),
                    ),
                  ],
                ),
              ),
              if (isImporting)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                const Icon(Icons.download_outlined),
            ],
          ),
        ),
      ),
    );
  }
}

class _BugPickerRow extends StatelessWidget {
  const _BugPickerRow({
    required this.bug,
    required this.isImporting,
    required this.onTap,
  });

  final ZentaoBug bug;
  final bool isImporting;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bug.title,
                      style: AppTypography.label(
                        context,
                      )?.copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.space4),
                    Text(
                      '#${bug.id} · ${bug.status}',
                      style: AppTypography.caption(
                        context,
                      )?.copyWith(color: context.colors.textSecondary),
                    ),
                  ],
                ),
              ),
              if (isImporting)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                const Icon(Icons.download_outlined),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageView extends StatelessWidget {
  const _MessageView({
    required this.icon,
    required this.message,
    this.retryLabel,
    this.onRetry,
    this.showSpinner = false,
  });

  final IconData? icon;
  final String message;
  final String? retryLabel;
  final VoidCallback? onRetry;
  final bool showSpinner;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showSpinner)
              const CircularProgressIndicator()
            else if (icon != null)
              Icon(icon, size: 48, color: context.colors.textSecondary),
            const SizedBox(height: AppSpacing.space16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.body(
                context,
              )?.copyWith(color: context.colors.textSecondary),
            ),
            if (retryLabel != null && onRetry != null) ...[
              const SizedBox(height: AppSpacing.space16),
              SecondaryButton(
                label: retryLabel!,
                expanded: false,
                onPressed: onRetry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
