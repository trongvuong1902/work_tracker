import 'models/task.dart';

/// Builds a Markdown prompt for Claude to analyze and propose a fix for the
/// Zentao bug backing [task]. Pure function — no Flutter imports — so it can
/// be tested without a widget test harness and reused anywhere (e.g. copy
/// button, share sheet).
///
/// Sections whose backing data is null/empty are omitted entirely rather
/// than rendered as empty headers.
String buildBugResolutionPrompt(Task task) {
  final buffer = StringBuffer();

  buffer.writeln(
    'You are an expert software engineer. Analyze the root cause of the '
    'bug below and propose a concrete fix, then explain how to verify it.',
  );
  buffer.writeln();

  buffer.write(buildBugContext(task));
  buffer.writeln();

  buffer.writeln('## What I need');
  buffer.writeln('1. The most likely root cause.');
  buffer.writeln('2. A concrete fix (code or steps).');
  buffer.writeln('3. How to verify the fix.');

  return buffer.toString();
}

/// Renders just the bug's facts (title, metadata, description, history,
/// attachment names) as Markdown — no resolution ask. Reused both by
/// [buildBugResolutionPrompt] and by the AI meta-prompt that asks a model to
/// generate a platform-tailored fix prompt. Sections with null/empty backing
/// data are omitted entirely.
String buildBugContext(Task task) {
  final buffer = StringBuffer();

  buffer.writeln('## Bug #${task.zentaoBugId}: ${task.title}');
  buffer.writeln();

  final metadata = _metadataLines(task);
  if (metadata.isNotEmpty) {
    for (final line in metadata) {
      buffer.writeln('- $line');
    }
    buffer.writeln();
  }

  final description = task.description;
  if (description != null && description.isNotEmpty) {
    buffer.writeln('## Description / Steps to reproduce');
    buffer.writeln(description);
    buffer.writeln();
  }

  final notes = task.notes;
  if (notes != null && notes.isNotEmpty) {
    buffer.writeln('## History / Comments');
    buffer.writeln(notes);
    buffer.writeln();
  }

  if (task.attachments.isNotEmpty) {
    buffer.writeln('## Attachments');
    for (final attachment in task.attachments) {
      buffer.writeln('- ${attachment.title}');
    }
    buffer.writeln(
      '(Binary contents are not included here — attach these files '
      'manually if relevant.)',
    );
    buffer.writeln();
  }

  return buffer.toString();
}

List<String> _metadataLines(Task task) {
  final lines = <String>[];

  final status = task.zentaoStatus;
  if (status != null && status.isNotEmpty) {
    lines.add('Status: $status');
  }

  final priority = task.priority;
  if (priority != null) {
    final severity = task.zentaoSeverity;
    final zentaoPriority = task.zentaoPriority;
    var line = 'Priority: P$priority';
    if (severity != null || zentaoPriority != null) {
      final rawParts = <String>[
        if (severity != null) 'severity $severity',
        if (zentaoPriority != null) 'zentao priority $zentaoPriority',
      ];
      line += ' (${rawParts.join(', ')})';
    }
    lines.add(line);
  }

  final productName = task.zentaoProductName;
  if (productName != null && productName.isNotEmpty) {
    var line = 'Product: $productName';
    final productPriority = task.zentaoProductPriority;
    if (productPriority != null) {
      line += ' (priority $productPriority)';
    }
    lines.add(line);
  }

  return lines;
}
