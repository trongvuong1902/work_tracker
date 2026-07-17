/// Converts a Zentao-supplied HTML fragment (bug `steps`/description and
/// action comments come back as HTML) into readable plain text for display in
/// plain `Text` widgets. Not a full HTML renderer — it keeps line structure
/// (breaks, paragraphs, list items) and decodes the common entities, then
/// strips every remaining tag.
String htmlToPlainText(String html) {
  if (html.isEmpty) return html;

  var text = html;

  // Block/line elements become newlines so structure survives the strip.
  text = text.replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n');
  text = text.replaceAll(
    RegExp(r'</(p|div|li|tr|h[1-6]|ul|ol)>', caseSensitive: false),
    '\n',
  );
  text = text.replaceAll(RegExp(r'<li[^>]*>', caseSensitive: false), '• ');

  // Drop every remaining tag.
  text = text.replaceAll(RegExp(r'<[^>]+>'), '');

  text = _decodeEntities(text);

  // Tidy whitespace: collapse runs of spaces/tabs and cap blank-line runs.
  text = text.replaceAll(RegExp(r'[ \t]+'), ' ');
  text = text.replaceAll(RegExp(r' *\n *'), '\n');
  text = text.replaceAll(RegExp(r'\n{3,}'), '\n\n');

  return text.trim();
}

const _namedEntities = <String, String>{
  'amp': '&',
  'lt': '<',
  'gt': '>',
  'quot': '"',
  'apos': "'",
  'nbsp': ' ',
  'hellip': '…',
  'mdash': '—',
  'ndash': '–',
  'rsquo': '’',
  'lsquo': '‘',
  'ldquo': '“',
  'rdquo': '”',
};

String _decodeEntities(String input) {
  return input.replaceAllMapped(RegExp(r'&(#x?[0-9a-fA-F]+|\w+);'), (match) {
    final body = match.group(1)!;
    if (body.startsWith('#x') || body.startsWith('#X')) {
      final code = int.tryParse(body.substring(2), radix: 16);
      return code == null ? match.group(0)! : String.fromCharCode(code);
    }
    if (body.startsWith('#')) {
      final code = int.tryParse(body.substring(1));
      return code == null ? match.group(0)! : String.fromCharCode(code);
    }
    return _namedEntities[body] ?? match.group(0)!;
  });
}
