import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:work_tracker/features/work_item/domain/models/work_item.dart';
import 'package:work_tracker/features/work_item/domain/work_item_repository.dart';

import '../../domain/models/zentao_bug.dart';
import '../../domain/models/zentao_import_kind.dart';
import '../../domain/models/zentao_product.dart';
import '../../domain/models/zentao_task.dart';
import '../../domain/zentao_repository.dart';

part 'zentao_product_picker_state.dart';
part 'zentao_product_picker_cubit.freezed.dart';

/// Appends the real exception in debug builds only, so a failure is
/// diagnosable without device logs — release builds keep the clean
/// user-facing message as-is.
String _withDebugDetail(String message, Object error) =>
    kDebugMode ? '$message ($error)' : message;

/// Drives the Product Picker step of the "Import from platform -> Zentao"
/// flow: pick a product, then (internally, in the same page/cubit) fetch
/// either tasks or bugs assigned to me under it (per [kind]), then show the
/// resulting list. Not `@injectable` — `kind` is a runtime constructor
/// param decided by which Select Option row the user tapped, so the page
/// constructs this directly (`ZentaoProductPickerCubit(getIt(), getIt(),
/// kind: kind)`) rather than resolving it via `getIt<...>()`.
class ZentaoProductPickerCubit extends Cubit<ZentaoProductPickerState> {
  ZentaoProductPickerCubit(
    this._zentaoRepository,
    this._taskRepository, {
    required this.kind,
  }) : super(const ZentaoProductPickerState()) {
    loadProducts();
  }

  final ZentaoRepository _zentaoRepository;
  final WorkItemRepository _taskRepository;
  final ZentaoImportKind kind;

  Future<void> loadProducts() async {
    emit(state.copyWith(isLoadingProducts: true, productsError: null));
    try {
      final products = await _zentaoRepository.getProducts();
      emit(state.copyWith(isLoadingProducts: false, products: products));
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingProducts: false,
          productsError: _withDebugDetail(
            "Couldn't load products — try again.",
            e,
          ),
        ),
      );
    }
  }

  Future<void> selectProduct(ZentaoProduct product) async {
    emit(
      state.copyWith(
        selectedProduct: product,
        isLoadingItems: true,
        itemsError: null,
        tasks: const [],
        bugs: const [],
      ),
    );
    try {
      if (kind == ZentaoImportKind.task) {
        final tasks = await _zentaoRepository.getAssignedTasks(product.id);
        emit(state.copyWith(isLoadingItems: false, tasks: tasks));
      } else {
        final bugs = await _zentaoRepository.getAssignedBugs(product.id);
        emit(state.copyWith(isLoadingItems: false, bugs: bugs));
      }
    } catch (e) {
      final noun = kind == ZentaoImportKind.task ? 'tasks' : 'bugs';
      emit(
        state.copyWith(
          isLoadingItems: false,
          itemsError: _withDebugDetail(
            "Couldn't load $noun for this product — try again.",
            e,
          ),
        ),
      );
    }
  }

  /// Returns to the product list, discarding the currently-shown items.
  void backToProducts() {
    emit(
      state.copyWith(
        selectedProduct: null,
        tasks: const [],
        bugs: const [],
        itemsError: null,
      ),
    );
  }

  /// Imports [task] into the local WorkItem store. Returns the created `WorkItem`
  /// on success (the page then pops the whole flow back to the WorkItem List),
  /// or `null` on failure (stays on the list with an inline error).
  Future<WorkItem?> importTask(ZentaoTask task) async {
    emit(state.copyWith(importingId: task.id, itemsError: null));
    try {
      final imported = await _taskRepository.importFromZentao(task);
      emit(state.copyWith(importingId: null));
      return imported;
    } catch (e) {
      emit(
        state.copyWith(
          importingId: null,
          itemsError: _withDebugDetail(
            "Couldn't import that task — try again.",
            e,
          ),
        ),
      );
      return null;
    }
  }

  /// Imports [bug] into the local WorkItem store, mirroring [importTask].
  Future<WorkItem?> importBug(ZentaoBug bug) async {
    emit(state.copyWith(importingId: bug.id, itemsError: null));
    try {
      final imported = await _taskRepository.importBugFromZentao(
        bug,
        product: state.selectedProduct,
      );
      emit(state.copyWith(importingId: null));
      return imported;
    } catch (e) {
      emit(
        state.copyWith(
          importingId: null,
          itemsError: _withDebugDetail(
            "Couldn't import that bug — try again.",
            e,
          ),
        ),
      );
      return null;
    }
  }
}
