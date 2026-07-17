import 'dart:io';

import 'models/zentao_bug.dart';
import 'models/zentao_bug_attachment.dart';
import 'models/zentao_bug_detail.dart';
import 'models/zentao_connection.dart';
import 'models/zentao_product.dart';
import 'models/zentao_task.dart';

abstract class ZentaoRepository {
  /// Verifies [domain]/[account]/[password] against the real Zentao
  /// instance by logging in, and persists them (via the credentials store)
  /// only on success. Returns whether the connect succeeded.
  Future<bool> connect({
    required String domain,
    required String account,
    required String password,
  });

  /// The currently connected account, or `null` if never connected /
  /// disconnected.
  Future<ZentaoConnection?> getConnection();

  /// Clears the stored connection (domain/account/password).
  Future<void> disconnect();

  /// Products visible to the connected account. Auto re-logs-in once if the
  /// stored session token has expired.
  Future<List<ZentaoProduct>> getProducts();

  /// Walks Projects -> Executions -> Tasks under [productId] and filters to
  /// tasks whose `assignedTo.account` matches the connected account. Auto
  /// re-logs-in once if the stored session token has expired.
  Future<List<ZentaoTask>> getAssignedTasks(int productId);

  /// Re-fetches a single task's current state from Zentao — used for the
  /// "Refresh" action on an already-imported local task. Returns `null` if
  /// the fetch fails (e.g. the ticket no longer exists).
  Future<ZentaoTask?> refreshTask(int zentaoTaskId);

  /// Bugs under [productId] assigned to the connected account. Auto
  /// re-logs-in once if the stored session token has expired.
  Future<List<ZentaoBug>> getAssignedBugs(int productId);

  /// Re-fetches a single bug's current state from Zentao — used for the
  /// "Refresh" action on an already-imported local (bug-linked) task.
  /// Returns `null` if the fetch fails.
  Future<ZentaoBug?> refreshBug(int zentaoBugId);

  /// Full live bug view (base fields + comment/action history + attachments),
  /// fetched on demand for a bug-linked task's detail screen. Returns `null`
  /// if the fetch fails.
  Future<ZentaoBugDetail?> getBugDetail(int zentaoBugId);

  /// Downloads [attachment]'s bytes (authenticated) and caches them to a local
  /// file keyed by attachment id, returning that file. Re-uses the cached file
  /// on subsequent calls instead of re-downloading.
  Future<File> downloadAttachment(ZentaoBugAttachment attachment);
}
