import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

/// A single inline image to attach to a Claude request — the raw bytes
/// (already base64-encoded) plus the media type Claude needs to decode them.
class ClaudeImage {
  const ClaudeImage({required this.mediaType, required this.base64Data});

  final String mediaType;
  final String base64Data;
}

/// Thrown when [ClaudeClient.resolveBug] is called but no API key was
/// compiled into this build (`--dart-define=ANTHROPIC_API_KEY=...`).
class ClaudeNotConfiguredException implements Exception {}

/// Thrown for any non-2xx response or mid-stream error event from the Claude
/// Messages API — mirrors [ZentaoAuthException]'s style. Never carries the
/// API key.
class ClaudeApiException implements Exception {
  ClaudeApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

abstract class ClaudeClient {
  /// Streams incremental text deltas from Claude analyzing [prompt] (plus
  /// any [images]) for the bug's root cause / fix. Throws
  /// [ClaudeNotConfiguredException] if no API key is configured, or
  /// [ClaudeApiException] on a request/stream-level failure.
  Stream<String> resolveBug({
    required String prompt,
    required List<ClaudeImage> images,
  });

  /// Whether an API key was compiled into this build.
  bool get isConfigured;
}

/// Talks to the real Anthropic Messages API
/// (`https://api.anthropic.com/v1/messages`) with `stream: true`, parsing the
/// server-sent-events response and yielding just the text deltas. Plain
/// `http` package, following `zentao_client.dart`'s style.
@LazySingleton(as: ClaudeClient)
class ClaudeRestClient implements ClaudeClient {
  static const _apiKey = String.fromEnvironment('ANTHROPIC_API_KEY');
  static final _uri = Uri.parse('https://api.anthropic.com/v1/messages');

  @override
  bool get isConfigured => _apiKey.isNotEmpty;

  @override
  Stream<String> resolveBug({
    required String prompt,
    required List<ClaudeImage> images,
  }) async* {
    if (_apiKey.isEmpty) throw ClaudeNotConfiguredException();

    final request = http.Request('POST', _uri)
      ..headers.addAll({
        'x-api-key': _apiKey,
        'anthropic-version': '2023-06-01',
        'content-type': 'application/json',
      })
      ..body = jsonEncode({
        'model': 'claude-opus-4-8',
        'max_tokens': 16000,
        'stream': true,
        'thinking': {'type': 'adaptive'},
        'messages': [
          {
            'role': 'user',
            'content': [
              for (final image in images)
                {
                  'type': 'image',
                  'source': {
                    'type': 'base64',
                    'media_type': image.mediaType,
                    'data': image.base64Data,
                  },
                },
              {'type': 'text', 'text': prompt},
            ],
          },
        ],
      });

    final response = await http.Client().send(request);

    if (response.statusCode != 200) {
      // Drain the body (without ever logging/including the api key).
      await response.stream.bytesToString();
      throw ClaudeApiException('Claude request failed (${response.statusCode})');
    }

    final lines = response.stream
        .transform(utf8.decoder)
        .transform(const LineSplitter());

    await for (final line in lines) {
      if (!line.startsWith('data: ')) continue;
      final payload = line.substring('data: '.length);
      final map = jsonDecode(payload) as Map<String, dynamic>;
      final type = map['type'];

      if (type == 'content_block_delta' &&
          map['delta']?['type'] == 'text_delta') {
        yield map['delta']['text'] as String;
      } else if (type == 'message_delta' &&
          map['delta']?['stop_reason'] == 'refusal') {
        throw ClaudeApiException('Claude declined to answer this request.');
      } else if (type == 'error') {
        throw ClaudeApiException(
          map['error']?['message']?.toString() ?? 'Claude stream error',
        );
      }
      // Ignore message_start, content_block_start, ping, thinking_delta,
      // message_stop, etc.
    }
  }
}
