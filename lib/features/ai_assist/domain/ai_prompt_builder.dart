import '../../work_item/domain/bug_prompt.dart';
import '../../work_item/domain/models/work_item.dart';
import 'ai_target.dart';

/// The machine-readable marker the model emits as the first output line when
/// it has to infer the framework (no cached value yet). The cubit parses this
/// to cache the stack and strips the line before display/copy.
const aiFrameworkMarker = 'FRAMEWORK:';

/// The framework name from a leading `FRAMEWORK: <name>` line in [output], or
/// null if the first line isn't the marker. Trims and ignores empty values.
String? parseFrameworkMarker(String output) {
  final firstLine = output.split('\n').first.trimLeft();
  if (!firstLine.startsWith(aiFrameworkMarker)) return null;
  final value = firstLine.substring(aiFrameworkMarker.length).trim();
  return value.isEmpty ? null : value;
}

/// [output] with a leading `FRAMEWORK: <name>` line (plus any blank line right
/// after it) removed. Returns [output] unchanged when there's no marker.
String stripFrameworkMarker(String output) {
  final lines = output.split('\n');
  if (lines.isEmpty || !lines.first.trimLeft().startsWith(aiFrameworkMarker)) {
    return output;
  }
  var start = 1;
  if (start < lines.length && lines[start].trim().isEmpty) start++;
  return lines.sublist(start).join('\n');
}

/// Builds the instruction sent to the model (Groq etc.): it acts as a prompt
/// engineer that reads the bug and writes ONE copy-paste-ready prompt tailored
/// for [target] to fix it. When [cachedFramework] is null the model is told to
/// infer the stack and emit a leading `FRAMEWORK: <name>` line; when known it
/// is told to assume that stack and skip the marker.
String buildAiPromptRequest(
  WorkItem task,
  AiTarget target, {
  String? cachedFramework,
}) {
  final buffer = StringBuffer();

  buffer.writeln(
    'You are an expert prompt engineer. Read the bug report below and write '
    'ONE precise, copy-paste-ready prompt that I will paste into '
    '${target.label} to get it to fix this bug.',
  );
  buffer.writeln();
  buffer.writeln('Rules:');

  final hasFramework = cachedFramework != null && cachedFramework.isNotEmpty;
  if (hasFramework) {
    buffer.writeln(
      '- The project uses $cachedFramework; assume that stack. Do NOT emit a '
      '$aiFrameworkMarker line.',
    );
  } else {
    buffer.writeln(
      '- First infer the project\'s tech stack/framework (e.g. Flutter/Dart, '
      'React/TypeScript, Spring/Java, ...) from the bug details.',
    );
    buffer.writeln(
      '- Make the very first line exactly: $aiFrameworkMarker <name> '
      '(the inferred stack, nothing else on that line).',
    );
  }
  buffer.writeln(
    '- Then output ONLY the prompt itself — no preamble, no explanation, and '
    'do not wrap the whole thing in a code fence.',
  );
  buffer.writeln('- Tailor it for ${target.promptGuidance}');
  buffer.writeln(
    '- The prompt must state the stack, the symptom, steps to reproduce, '
    'expected vs actual behaviour, key constraints, and ask for a concrete '
    'fix.',
  );
  buffer.writeln();
  buffer.writeln('--- BUG REPORT ---');
  buffer.write(buildBugContext(task));

  return buffer.toString();
}
