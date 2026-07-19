import 'package:flutter_test/flutter_test.dart';
import 'package:work_tracker/features/work_item/domain/bug_prompt.dart';
import 'package:work_tracker/features/work_item/domain/models/work_item.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_bug_attachment.dart';

void main() {
  group('buildBugResolutionPrompt', () {
    test('a fully-populated bug task includes every section', () {
      final task = WorkItem(
        id: 1,
        title: '[42][Crash on save]',
        description: 'Steps: open app, tap save, app crashes.',
        done: false,
        createdAt: DateTime(2026, 7, 1),
        zentaoBugId: 42,
        zentaoStatus: 'active',
        priority: 2,
        notes: 'Alice: looking into it now.',
        attachments: const [
          ZentaoBugAttachment(id: 1, title: 'crash_log.txt'),
          ZentaoBugAttachment(id: 2, title: 'screenshot.png'),
        ],
        zentaoPriority: 2,
        zentaoSeverity: 1,
        zentaoProductId: 3,
        zentaoProductName: 'Mobile',
        zentaoProductPriority: 5,
        elapsedSeconds: 0,
      );

      final prompt = buildBugResolutionPrompt(task);

      expect(prompt, contains('42'));
      expect(prompt, contains('[42][Crash on save]'));
      expect(prompt, contains('active'));
      expect(prompt, contains('P2'));
      expect(prompt, contains('Mobile'));
      expect(prompt, contains('Steps: open app, tap save, app crashes.'));
      expect(prompt, contains('Alice: looking into it now.'));
      expect(prompt, contains('crash_log.txt'));
      expect(prompt, contains('screenshot.png'));
      expect(prompt, contains('What I need'));
    });

    test(
      'a minimal bug task omits empty sections but still returns a usable prompt',
      () {
        final task = WorkItem(
          id: 2,
          title: '[7][Minor issue]',
          done: false,
          createdAt: DateTime(2026, 7, 1),
          zentaoBugId: 7,
          elapsedSeconds: 0,
        );

        final prompt = buildBugResolutionPrompt(task);

        expect(prompt, isNotEmpty);
        expect(prompt, contains('What I need'));
        expect(prompt, contains('7'));
        expect(prompt, contains('[7][Minor issue]'));
        expect(prompt, isNot(contains('## Description')));
        expect(prompt, isNot(contains('## History')));
        expect(prompt, isNot(contains('## Attachments')));
      },
    );
  });
}
