import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../zentao/data/zentao_sync_prefs.dart';
import '../../../zentao/domain/zentao_repository.dart';
import '../../domain/work_item_repository.dart';

part 'bug_sync_state.dart';
part 'bug_sync_cubit.freezed.dart';

/// Drives the bulk "Bugs assigned to me" sync: for every product the user has
/// chosen to sync (persisted in [ZentaoSyncPrefs]), fetches the bugs assigned
/// to the connected account and upserts each into the local task store
/// (updating already-linked tasks, adding new ones), tallying the outcome.
@injectable
class BugSyncCubit extends Cubit<BugSyncState> {
  BugSyncCubit(this._zentaoRepository, this._taskRepository, this._syncPrefs)
    : super(const BugSyncState());

  final ZentaoRepository _zentaoRepository;
  final WorkItemRepository _taskRepository;
  final ZentaoSyncPrefs _syncPrefs;

  Future<void> sync() async {
    emit(
      const BugSyncState(
        isSyncing: true,
        progressText: 'Loading products…',
      ),
    );

    try {
      final selectedIds = _syncPrefs.getSyncedProductIds().toSet();
      final allProducts = await _zentaoRepository.getProducts();
      final products = allProducts
          .where((p) => selectedIds.contains(p.id))
          .toList();

      if (products.isEmpty) {
        emit(
          const BugSyncState(
            done: true,
            errorMessage:
                'No products selected to sync. Choose products first.',
          ),
        );
        return;
      }

      var added = 0;
      var updated = 0;
      var failedProducts = 0;

      for (var i = 0; i < products.length; i++) {
        final product = products[i];
        emit(
          state.copyWith(
            isSyncing: true,
            progressText:
                'Syncing ${product.name} (${i + 1}/${products.length})…',
          ),
        );
        try {
          final bugs = await _zentaoRepository.getAssignedBugs(product.id);
          for (final bug in bugs) {
            final outcome = await _taskRepository.upsertBugFromZentao(
              bug,
              product: product,
            );
            switch (outcome) {
              case BugUpsertOutcome.added:
                added++;
              case BugUpsertOutcome.updated:
                updated++;
            }
          }
        } catch (_) {
          failedProducts++;
        }
      }

      emit(
        BugSyncState(
          done: true,
          added: added,
          updated: updated,
          failedProducts: failedProducts,
        ),
      );
    } catch (e) {
      emit(
        BugSyncState(
          done: true,
          errorMessage: _withDebugDetail(
            "Couldn't sync bugs — try again.",
            e,
          ),
        ),
      );
    }
  }
}

/// Appends the real exception in debug builds only (mirrors the Zentao picker
/// cubit) so failures are diagnosable without device logs.
String _withDebugDetail(String message, Object error) =>
    kDebugMode ? '$message ($error)' : message;
