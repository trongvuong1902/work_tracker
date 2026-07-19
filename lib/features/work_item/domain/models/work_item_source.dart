/// The external platform a task is synced from. `manual` means a local-only
/// task with no external link. Zentao is the only integration implemented
/// today; `notion`/`jira` are reserved so the WorkItem entity is sync-ready without
/// another schema migration.
enum WorkItemSource { manual, zentao, notion, jira }

/// The kind of external item a task links to. Extendable later (issue, story,
/// page) as more platforms are added.
enum ExternalItemType { task, bug }

extension TaskSourceX on WorkItemSource {
  /// Parses a persisted [WorkItemSource.name], falling back to [WorkItemSource.manual]
  /// for null/unknown values so an old or future-written value never throws.
  static WorkItemSource fromName(String? name) {
    if (name == null) return WorkItemSource.manual;
    for (final value in WorkItemSource.values) {
      if (value.name == name) return value;
    }
    return WorkItemSource.manual;
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
