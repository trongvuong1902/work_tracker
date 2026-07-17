import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists which Zentao product ids the user has chosen to include in the
/// bulk "Bugs assigned to me" sync. Non-sensitive, so it uses the shared
/// (unencrypted) [SharedPreferences] rather than secure storage.
@lazySingleton
class ZentaoSyncPrefs {
  ZentaoSyncPrefs(this._prefs);

  static const _productIdsKey = 'zentao_sync_product_ids';

  final SharedPreferences _prefs;

  List<int> getSyncedProductIds() =>
      (_prefs.getStringList(_productIdsKey) ?? const [])
          .map(int.tryParse)
          .whereType<int>()
          .toList();

  Future<void> setSyncedProductIds(List<int> ids) => _prefs.setStringList(
    _productIdsKey,
    ids.map((id) => id.toString()).toList(),
  );

  bool get hasSelection => getSyncedProductIds().isNotEmpty;
}
