import '../../zentao/domain/models/zentao_bug.dart';
import '../../zentao/domain/models/zentao_product.dart';
import '../../zentao/domain/models/zentao_task.dart';
import 'models/task.dart';

/// Outcome of a single [TaskRepository.upsertBugFromZentao] call, so the bulk
/// bug sync can tally how many tasks were newly created vs. refreshed.
enum BugUpsertOutcome { added, updated }

abstract class TaskRepository {
  Future<Task> createManual({required String title, String? description});

  /// Maps [task] to a new local `Task` linked to it (`zentaoTaskId` set,
  /// `zentaoLastSyncedAt` = now).
  Future<Task> importFromZentao(ZentaoTask task);

  /// Maps [bug] to a new local `Task` linked to it (`zentaoBugId` set,
  /// `zentaoLastSyncedAt` = now). Optionally carries the [product] it was
  /// fetched under so product name/priority are persisted for sorting.
  Future<Task> importBugFromZentao(ZentaoBug bug, {ZentaoProduct? product});

  /// Reconciles a single Zentao [bug] into the local store for the bulk
  /// "Bugs assigned to me" sync: if a task already links this bug, its Zentao
  /// fields (title/description/status/priority/severity/product) and
  /// `zentaoLastSyncedAt` are refreshed while local state
  /// (`done`/`elapsedSeconds`/`timerStartedAt`) is preserved; otherwise a new
  /// task is inserted. Returns whether it was [BugUpsertOutcome.added] or
  /// [BugUpsertOutcome.updated].
  Future<BugUpsertOutcome> upsertBugFromZentao(
    ZentaoBug bug, {
    ZentaoProduct? product,
  });

  /// Emits whenever any task changes (create/update/timer/done/resolve), so
  /// reactive views (e.g. the home "Today's tasks" section) can re-read. Emits
  /// only on writes, never on reads — mirrors `AttendanceRepository`.
  Stream<void> watchTasksChanges();

  /// All tasks, most-recently-created first.
  Future<List<Task>> getAll();

  Future<Task?> getById(int id);

  Future<void> toggleDone(int id);

  /// No-ops if the timer is already running.
  Future<void> startTimer(int id);

  /// Accumulates the running segment into `elapsedSeconds` and clears
  /// `timerStartedAt`. No-ops if the timer isn't running.
  Future<void> stopTimer(int id);

  /// Re-fetches the linked Zentao ticket/bug's current status (via
  /// `ZentaoRepository.refreshTask` or `refreshBug`, depending on which link
  /// is set) and updates `zentaoStatus`/`zentaoLastSyncedAt`. No-ops
  /// (returns the task unchanged) if the task isn't linked to Zentao at all,
  /// or if the refresh call fails.
  Future<Task> refreshFromZentao(int id);

  /// Confirms the linked Zentao bug (called on the first Start-timer). No-ops
  /// if the task isn't bug-linked or is already confirmed. On success flips the
  /// local `zentaoConfirmed` flag so later starts don't re-confirm. Throws if
  /// the Zentao call fails, so the caller can block starting the timer.
  Future<void> confirmZentaoBug(int id);

  /// Resolves the linked Zentao bug (called when a bug task is marked Done):
  /// finalizes the running timer, sends `resolution=fixed`, `build=trunk`,
  /// `resolvedDate=now`, assigns to the bug's opener, and records the tracked
  /// time as the resolve comment. Only on Zentao success does it stop the timer
  /// and mark the task done locally. Throws on failure so the caller can leave
  /// the task not-done.
  Future<Task> resolveZentaoBug(int id);
}
