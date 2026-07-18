/// The external platform a task is synced from. `manual` means a local-only
/// task with no external link. Zentao is the only integration implemented
/// today; `notion`/`jira` are reserved so the Task entity is sync-ready without
/// another schema migration.
enum TaskSource { manual, zentao, notion, jira }

/// The kind of external item a task links to. Extendable later (issue, story,
/// page) as more platforms are added.
enum ExternalItemType { task, bug }

extension TaskSourceX on TaskSource {
  /// Parses a persisted [TaskSource.name], falling back to [TaskSource.manual]
  /// for null/unknown values so an old or future-written value never throws.
  static TaskSource fromName(String? name) {
    if (name == null) return TaskSource.manual;
    for (final value in TaskSource.values) {
      if (value.name == name) return value;
    }
    return TaskSource.manual;
  }
}

extension ExternalItemTypeX on ExternalItemType {
  /// Parses a persisted [ExternalItemType.name]; null/unknown → null.
  static ExternalItemType? fromName(String? name) {
    if (name == null) return null;
    for (final value in ExternalItemType.values) {
      if (value.name == name) return value;
    }
    return null;
  }
}
