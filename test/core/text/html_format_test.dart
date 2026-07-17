import 'package:flutter_test/flutter_test.dart';
import 'package:work_tracker/core/text/html_format.dart';

void main() {
  group('htmlToPlainText', () {
    test('strips tags and keeps text', () {
      expect(
        htmlToPlainText('<p>Login <b>crashes</b> on save</p>'),
        'Login crashes on save',
      );
    });

    test('converts <br> and block tags to newlines', () {
      expect(
        htmlToPlainText('Step 1<br>Step 2<br/>Step 3'),
        'Step 1\nStep 2\nStep 3',
      );
    });

    test('renders list items with bullets', () {
      final result = htmlToPlainText('<ul><li>one</li><li>two</li></ul>');
      expect(result, contains('• one'));
      expect(result, contains('• two'));
    });

    test('decodes named and numeric entities', () {
      expect(
        htmlToPlainText('Tom &amp; Jerry &lt;3 &#39;hi&#39; &#x2764;'),
        "Tom & Jerry <3 'hi' ❤",
      );
    });

    test('collapses excess whitespace and trims', () {
      expect(
        htmlToPlainText('  <div>a   b</div>\n\n\n<div>c</div>  '),
        'a b\n\nc',
      );
    });

    test('leaves plain text untouched', () {
      expect(htmlToPlainText('just text'), 'just text');
    });
  });
}
