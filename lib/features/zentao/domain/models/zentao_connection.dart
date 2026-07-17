import 'package:freezed_annotation/freezed_annotation.dart';

part 'zentao_connection.freezed.dart';

/// The connected Zentao account, without ever carrying the password past
/// the repository boundary — the password only ever lives in
/// `ZentaoCredentialsStore` (secure storage) and the client's login call.
@freezed
abstract class ZentaoConnection with _$ZentaoConnection {
  const factory ZentaoConnection({
    required String domain,
    required String account,
  }) = _ZentaoConnection;
}

extension ZentaoConnectionX on ZentaoConnection {
  /// Best-effort browser URL for viewing task [taskId] on this Zentao
  /// instance — Zentao's exact view-URL routing mode (`get`/`path`/etc) is
  /// unconfirmed against the real instance, so this assumes the common
  /// `index.php?m=task&f=view&taskID=` "get" form; verify against
  /// https://zentao.oasoft.xyz:4433 and adjust if it 404s.
  String taskUrl(int taskId) {
    final trimmed = domain.endsWith('/')
        ? domain.substring(0, domain.length - 1)
        : domain;
    return '$trimmed/index.php?m=task&f=view&taskID=$taskId';
  }

  /// Best-effort browser URL for viewing bug [bugId] — same caveat as
  /// [taskUrl]: assumes the common `index.php?m=bug&f=view&bugID=` "get"
  /// form; verify against a real instance and adjust if it 404s.
  String bugUrl(int bugId) {
    final trimmed = domain.endsWith('/')
        ? domain.substring(0, domain.length - 1)
        : domain;
    return '$trimmed/index.php?m=bug&f=view&bugID=$bugId';
  }
}
