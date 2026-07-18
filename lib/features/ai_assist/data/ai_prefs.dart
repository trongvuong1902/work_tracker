import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/ai_target.dart';

/// Persists the AI fix-prompt preferences globally (one project): the
/// last-selected target platform and the framework/stack detected from the
/// bugs. Non-sensitive, so it uses the shared (unencrypted)
/// [SharedPreferences] like `ZentaoSyncPrefs`.
@lazySingleton
class AiPrefs {
  AiPrefs(this._prefs);

  static const _targetKey = 'ai_prompt_target';
  static const _frameworkKey = 'ai_prompt_framework';

  final SharedPreferences _prefs;

  /// The last-selected target, defaulting to [AiTarget.claude] when unset.
  AiTarget getTarget() => AiTargetX.fromId(_prefs.getString(_targetKey));

  Future<void> setTarget(AiTarget target) =>
      _prefs.setString(_targetKey, target.id);

  /// The cached detected framework/stack (e.g. "Flutter / Dart"), or null if
  /// it hasn't been detected yet.
  String? getFramework() {
    final value = _prefs.getString(_frameworkKey)?.trim();
    return (value == null || value.isEmpty) ? null : value;
  }

  Future<void> setFramework(String framework) =>
      _prefs.setString(_frameworkKey, framework.trim());

  Future<void> clearFramework() => _prefs.remove(_frameworkKey);
}
