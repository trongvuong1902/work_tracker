import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/// Plain (non-freezed) carrier for the full stored credential set,
/// including the password — this never crosses into the domain layer
/// (`ZentaoConnection` deliberately omits the password). Kept private to the
/// data layer.
class ZentaoCredentials {
  const ZentaoCredentials({
    required this.domain,
    required this.account,
    required this.password,
  });

  final String domain;
  final String account;
  final String password;
}

/// Wraps [FlutterSecureStorage] to persist the Zentao domain/account/
/// password under fixed keys. This is the only place the password is ever
/// persisted — no other feature in this app stores a raw password, so this
/// is deliberately the first (and only) consumer of secure storage.
@LazySingleton()
class ZentaoCredentialsStore {
  ZentaoCredentialsStore(this._storage);

  final FlutterSecureStorage _storage;

  static const _domainKey = 'zentao_domain';
  static const _accountKey = 'zentao_account';
  static const _passwordKey = 'zentao_password';

  Future<ZentaoCredentials?> read() async {
    final domain = await _storage.read(key: _domainKey);
    final account = await _storage.read(key: _accountKey);
    final password = await _storage.read(key: _passwordKey);
    if (domain == null || account == null || password == null) return null;
    return ZentaoCredentials(
      domain: domain,
      account: account,
      password: password,
    );
  }

  Future<void> write({
    required String domain,
    required String account,
    required String password,
  }) async {
    await _storage.write(key: _domainKey, value: domain);
    await _storage.write(key: _accountKey, value: account);
    await _storage.write(key: _passwordKey, value: password);
  }

  Future<void> clear() async {
    await _storage.delete(key: _domainKey);
    await _storage.delete(key: _accountKey);
    await _storage.delete(key: _passwordKey);
  }
}
