/// The coding-AI platform a generated fix prompt is tailored for. The user
/// picks one in the AI sheet; the choice is cached globally (last-used
/// default) via `AiPrefs`.
enum AiTarget {
  claude,
  antigravityIde,
  githubCopilot,
}

extension AiTargetX on AiTarget {
  /// Stable id used as the persisted prefs value — decoupled from the enum
  /// name so renames don't invalidate a cached choice.
  String get id {
    switch (this) {
      case AiTarget.claude:
        return 'claude';
      case AiTarget.antigravityIde:
        return 'antigravity_ide';
      case AiTarget.githubCopilot:
        return 'github_copilot';
    }
  }

  /// Human-facing name shown in the selector and prompt.
  String get label {
    switch (this) {
      case AiTarget.claude:
        return 'Claude';
      case AiTarget.antigravityIde:
        return 'Antigravity IDE';
      case AiTarget.githubCopilot:
        return 'GitHub Copilot';
    }
  }

  /// How the generated prompt should be phrased for this tool — inlined into
  /// the meta-prompt sent to the model.
  String get promptGuidance {
    switch (this) {
      case AiTarget.claude:
        return 'Claude, a chat assistant. Ask it to first give a concise '
            'root-cause analysis, then a concrete, minimal fix with code.';
      case AiTarget.antigravityIde:
        return 'Antigravity, an agentic coding IDE. Phrase the prompt as an '
            'actionable task the agent executes across the repository: state '
            'what to change, where, and how to verify the fix.';
      case AiTarget.githubCopilot:
        return 'GitHub Copilot Chat inside the editor. Keep it concise, point '
            'at the likely file(s)/symbols, and ask for a minimal diff/patch.';
    }
  }

  static AiTarget fromId(String? id) {
    switch (id) {
      case 'antigravity_ide':
        return AiTarget.antigravityIde;
      case 'github_copilot':
        return AiTarget.githubCopilot;
      case 'claude':
      default:
        return AiTarget.claude;
    }
  }
}
