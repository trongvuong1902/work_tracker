import '../../zentao/domain/models/zentao_bug.dart';
import '../../zentao/domain/models/zentao_product.dart';
import '../../zentao/domain/models/zentao_task.dart';
import 'models/work_item.dart';

/// Outcome of a single [WorkItemRepository.upsertBugFromZentao] call, so the bulk
/// bug sync can tally how many tasks were newly created vs. refreshed.
enum BugUpsertOutcome { added, updated }

abstract class WorkItemRepository {
  Future<WorkItem> createManual({required String title, String? description});

  /// Maps [task] to a new local `WorkItem` linked to it (`zentaoTaskId` set,
  /// `zentaoLastSyncedAt` = now).
  Future<WorkItem> importFromZentao(ZentaoTask task);

  /// Maps [bug] to a new local `WorkItem` linked to it (`zentaoBugId` set,
  /// `zentaoLastSyncedAt` = now). Optionally carries the [product] it was
  /// fetched under so product name/priority are persisted for sorting.
  Future<WorkItem> importBugFromZentao(ZentaoBug bug, {ZentaoProduct? product});

  /// Reconciles a single Zentao [bug] into the local store for the bulk
  /// "Bugs assigned to me" sync: if a task already links this bug, its Zentao
  /// fields (title/description/status/priority/severity/product) and
  /// `zentaoLastSyncedAt` are refreshed while local state
  /// (`elapsedSeconds`/`timerStartedAt`) is preserved; otherwise a new task is
  /// inserted. `done` tracks the Zentao status two-way — set true (finalizing
  /// any running timer) when the bug is resolved/closed, and back to false when
  /// it's reopened to active — while tracked time is always preserved. Returns
  /// whether it was [BugUpsertOutcome.added] or [BugUpsertOutcome.updated].
  Future<BugUpsertOutcome> upsertBugFromZentao(
    ZentaoBug bug, {
    ZentaoProduct? product,
  });

  /// Emits whenever any task changes (create/update/timer/done/resolve), so
  /// reactive views (e.g. the home "Today's tasks" section) can re-read. Emits
  /// only on writes, never on reads — mirrors `AttendanceRepository`.
  Stream<void> watchTasksChanges();

  /// All tasks, most-recently-created first.
  Future<List<WorkItem>> getAll();

  Future<WorkItem?> getById(int id);

  Future<void> toggleDone(int id);

  /// Sets (or clears, when [date] is null) the day the task is planned for,
  /// normalized to local midnight. Returns the updated task.
  Future<WorkItem> setPlannedDate(int id, DateTime? date);

  /// All tasks planned within the given [year]/[month] — powers the calendar's
  /// per-day list and day markers.
  Future<List<WorkItem>> getPlannedTasksForMonth(int year, int month);

  /// Candidate tasks to plan onto a day: not done and not already planned.
  /// Sorted by priority (1 = most urgent first, unset last), then newest.
  Future<List<WorkItem>> getUnplannedOpenTasks();

  /// Plans every task in [ids] onto [day] (normalized to local midnight) in one
  /// batch, emitting a single change notification.
  Future<void> setPlannedDateForTasks(List<int> ids, DateTime day);

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
  Future<WorkItem> refreshFromZentao(int id);

  /// Pulls the current server status for every Zentao-linked task (tasks via
  /// `refreshTask`, bugs via the lightweight `refreshBug` — not the heavy detail
  /// fetch) and reconciles it locally two-way: a completed status marks the task
  /// done, a reopened one returns it to active. Individual failures are skipped
  /// so one bad item doesn't abort the batch. Emits a single change
  /// notification. Returns how many tasks were updated. Backs the Tasks page
  /// pull-to-refresh.
  Future<int> refreshAllZentaoFromServer();

  /// Confirms the linked Zentao bug (called on the first Start-timer). No-ops
  /// if the task isn't bug-linked or is already confirmed. On success flips the
  /// local `zentaoConfirmed` flag so later starts don't re-confirm. Throws if
  /// the Zentao call fails, so the caller can block starting the timer.
  Future<void> confirmZentaoBug(int id);

  /// Resolves the linked Zentao bug (called when a bug task is marked Done):
  /// finalizes the running timer, sends `resolution=fixed`, `build=trunk`,
  /// `resolvedDate=now`, assigns to the bug's opener, and records the reported
  /// time as the resolve comment. When [durationMinutes] is given (the value the
  /// user confirmed in the resolve sheet) it drives the comment; otherwise the
  /// actual tracked total is used. The local `elapsedSeconds` is always
  /// finalized from the real tracked time, never from [durationMinutes]. Only on
  /// Zentao success does it stop the timer and mark the task done locally.
  /// Throws on failure so the caller can leave the task not-done.
  Future<WorkItem> resolveZentaoBug(int id, {int? durationMinutes});

  /// Closes the linked Zentao bug in Zentao, then locally sets its status to
  /// `closed`, marks it done, and finalizes any running timer. Throws on Zentao
  /// failure so the caller can leave local state unchanged.
  Future<WorkItem> closeZentaoBug(int id);

  /// Activates (reopens) the linked Zentao bug in Zentao, then locally sets its
  /// status to `active`, un-marks done, and clears the confirmed flag so the
  /// next Start-timer re-confirms. Throws on Zentao failure.
  Future<WorkItem> reopenZentaoBug(int id);
}
