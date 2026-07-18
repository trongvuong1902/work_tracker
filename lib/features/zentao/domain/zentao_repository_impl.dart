import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import '../data/zentao_client.dart';
import '../data/zentao_credentials_store.dart';
import 'models/zentao_bug.dart';
import 'models/zentao_bug_attachment.dart';
import 'models/zentao_bug_detail.dart';
import 'models/zentao_connection.dart';
import 'models/zentao_product.dart';
import 'models/zentao_task.dart';
import 'zentao_repository.dart';

/// Composes [ZentaoClient] + [ZentaoCredentialsStore]. Token expiry is
/// undocumented for Zentao's API, so rather than guessing a TTL, every
/// authenticated call is wrapped in [_withToken], which retries exactly
/// once with a fresh login if the call throws [ZentaoAuthException]
/// (401/403).
@LazySingleton(as: ZentaoRepository)
class ZentaoRepositoryImpl implements ZentaoRepository {
  ZentaoRepositoryImpl(this._client, this._credentialsStore);

  final ZentaoClient _client;
  final ZentaoCredentialsStore _credentialsStore;

  // In-memory only — never persisted. Re-derived via login() whenever
  // missing (fresh app start) or after a 401/403.
  String? _cachedToken;

  @override
  Future<bool> connect({
    required String domain,
    required String account,
    required String password,
  }) async {
    try {
      final token = await _client.login(
        domain: domain,
        account: account,
        password: password,
      );
      _cachedToken = token;
      await _credentialsStore.write(
        domain: domain,
        account: account,
        password: password,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<ZentaoConnection?> getConnection() async {
    final credentials = await _credentialsStore.read();
    if (credentials == null) return null;
    return ZentaoConnection(
      domain: credentials.domain,
      account: credentials.account,
    );
  }

  @override
  Future<void> disconnect() async {
    _cachedToken = null;
    await _credentialsStore.clear();
  }

  @override
  Future<List<ZentaoProduct>> getProducts() {
    return _withToken(
      (domain, token) => _client.fetchProducts(domain: domain, token: token),
    );
  }

  @override
  Future<List<ZentaoTask>> getAssignedTasks(int productId) {
    return _withToken((domain, token) async {
      final credentials = await _credentialsStore.read();
      if (credentials == null) {
        throw Exception('Not connected to Zentao');
      }
      return _client.fetchAssignedTasks(
        domain: domain,
        token: token,
        productId: productId,
        account: credentials.account,
      );
    });
  }

  @override
  Future<ZentaoTask?> refreshTask(int zentaoTaskId) async {
    try {
      return await _withToken(
        (domain, token) =>
            _client.fetchTask(domain: domain, token: token, taskId: zentaoTaskId),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<ZentaoBug>> getAssignedBugs(int productId) {
    return _withToken((domain, token) async {
      final credentials = await _credentialsStore.read();
      if (credentials == null) {
        throw Exception('Not connected to Zentao');
      }
      return _client.fetchAssignedBugs(
        domain: domain,
        token: token,
        productId: productId,
        account: credentials.account,
      );
    });
  }

  @override
  Future<ZentaoBug?> refreshBug(int zentaoBugId) async {
    try {
      return await _withToken(
        (domain, token) =>
            _client.fetchBug(domain: domain, token: token, bugId: zentaoBugId),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<ZentaoBugDetail?> getBugDetail(int zentaoBugId) async {
    try {
      return await _withToken(
        (domain, token) => _client.fetchBugDetail(
          domain: domain,
          token: token,
          bugId: zentaoBugId,
        ),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<File> downloadAttachment(ZentaoBugAttachment attachment) async {
    final cacheDir = await _attachmentCacheDir();
    final suffix = (attachment.fileExtension == null)
        ? ''
        : '.${attachment.fileExtension}';
    final file = File('${cacheDir.path}/zentao_bug_file_${attachment.id}$suffix');
    if (await file.exists() && await file.length() > 0) return file;

    final bytes = await _withToken(
      (domain, token) => _client.downloadFile(
        domain: domain,
        token: token,
        attachmentId: attachment.id,
      ),
    );
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  @override
  Future<void> confirmBug(int bugId, {int? pri}) {
    return _withToken((domain, token) async {
      final credentials = await _credentialsStore.read();
      if (credentials == null) {
        throw Exception('Not connected to Zentao');
      }
      // Confirming keeps the bug on the connected (self) account.
      return _client.confirmBug(
        domain: domain,
        token: token,
        bugId: bugId,
        assignedTo: credentials.account,
        pri: pri,
      );
    });
  }

  @override
  Future<void> resolveBug(
    int bugId, {
    required String resolution,
    required String resolvedBuild,
    required DateTime resolvedDate,
    required String assignedTo,
    required String comment,
  }) {
    return _withToken(
      (domain, token) => _client.resolveBug(
        domain: domain,
        token: token,
        bugId: bugId,
        resolution: resolution,
        resolvedBuild: resolvedBuild,
        resolvedDate: resolvedDate,
        assignedTo: assignedTo,
        comment: comment,
      ),
    );
  }

  @override
  Future<void> closeBug(int bugId, {String comment = ''}) {
    return _withToken(
      (domain, token) => _client.closeBug(
        domain: domain,
        token: token,
        bugId: bugId,
        comment: comment,
      ),
    );
  }

  @override
  Future<void> activateBug(int bugId, {String comment = ''}) {
    return _withToken((domain, token) async {
      final credentials = await _credentialsStore.read();
      if (credentials == null) {
        throw Exception('Not connected to Zentao');
      }
      // Reopening assigns the bug back to the connected (self) account.
      return _client.activateBug(
        domain: domain,
        token: token,
        bugId: bugId,
        assignedTo: credentials.account,
        comment: comment,
      );
    });
  }

  Future<Directory> _attachmentCacheDir() async {
    final base = await getApplicationCacheDirectory();
    final dir = Directory('${base.path}/zentao_attachments');
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  Future<T> _withToken<T>(
    Future<T> Function(String domain, String token) action,
  ) async {
    final credentials = await _credentialsStore.read();
    if (credentials == null) {
      throw Exception('Not connected to Zentao');
    }

    _cachedToken ??= await _client.login(
      domain: credentials.domain,
      account: credentials.account,
      password: credentials.password,
    );

    try {
      return await action(credentials.domain, _cachedToken!);
    } on ZentaoAuthException {
      final freshToken = await _client.login(
        domain: credentials.domain,
        account: credentials.account,
        password: credentials.password,
      );
      _cachedToken = freshToken;
      return await action(credentials.domain, freshToken);
    }
  }
}
