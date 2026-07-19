import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../zentao/data/zentao_sync_prefs.dart';
import '../../../zentao/domain/models/zentao_product.dart';
import '../../../zentao/domain/zentao_repository.dart';

part 'bug_sync_products_state.dart';
part 'bug_sync_products_cubit.freezed.dart';

/// Backs the "Choose products to sync" screen — loads the Zentao products,
/// pre-checks the ones already persisted in [ZentaoSyncPrefs], lets the user
/// toggle the selection, and saves it back.
@injectable
class BugSyncProductsCubit extends Cubit<BugSyncProductsState> {
  BugSyncProductsCubit(this._zentaoRepository, this._syncPrefs)
    : super(const BugSyncProductsState()) {
    load();
  }

  final ZentaoRepository _zentaoRepository;
  final ZentaoSyncPrefs _syncPrefs;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final products = await _zentaoRepository.getProducts();
      emit(
        state.copyWith(
          isLoading: false,
          products: products,
          selectedIds: _syncPrefs.getSyncedProductIds().toSet(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: _withDebugDetail(
            "Couldn't load products — try again.",
            e,
          ),
        ),
      );
    }
  }

  void toggle(int productId) {
    final next = Set<int>.from(state.selectedIds);
    if (!next.remove(productId)) next.add(productId);
    emit(state.copyWith(selectedIds: next));
  }

  Future<void> save() => _syncPrefs.setSyncedProductIds(
    state.selectedIds.toList(),
  );
}

String _withDebugDetail(String message, Object error) =>
    kDebugMode ? '$message ($error)' : message;
