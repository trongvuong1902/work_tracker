import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

/// A single inline image to attach to a request — the raw bytes (already
/// base64-encoded) plus the media type, sent as an OpenAI-style `image_url`
/// data URI.
class AiImage {
  const AiImage({required this.mediaType, required this.base64Data});

  final String mediaType;
  final String base64Data;
}

/// Thrown when [AiClient.resolveBug] is called but no API key was compiled
/// into this build (`--dart-define=AI_API_KEY=...`).
class AiNotConfiguredException implements Exception {}

/// Thrown for any non-2xx response or mid-stream error from the AI provider.
/// Never carries the API key.
class AiApiException implements Exception {
  AiApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

abstract class AiClient {
  /// Streams incremental text deltas from the model analyzing [prompt] (plus
  /// any [images]) for the bug's root cause / fix. Throws
  /// [AiNotConfiguredException] if no API key is configured, or
  /// [AiApiException] on a request/stream-level failure.
  Stream<String> resolveBug({
    required String prompt,
    required List<AiImage> images,
  });

  /// Whether an API key was compiled into this build.
  bool get isConfigured;
}

/// Talks to any OpenAI-compatible `/chat/completions` endpoint with
/// `stream: true`, parsing the server-sent-events response and yielding just
/// the text deltas. Provider/model/key are build-time config
/// (`--dart-define`), defaulting to Google Gemini Flash (free tier, vision).
/// Plain `http` package, following `zentao_client.dart`'s style.
@LazySingleton(as: AiClient)
class OpenAiCompatibleAiClient implements AiClient {
  static const _apiKey = String.fromEnvironment('AI_API_KEY');

  // Read raw (no defaultValue): `String.fromEnvironment` only applies its
  // default when the key is ABSENT, so a present-but-empty dart-define
  // (`"AI_BASE_URL": ""`) would otherwise yield "" and produce a host-less URI.
  static const _baseUrlRaw = String.fromEnvironment('AI_BASE_URL');
  static const _modelRaw = String.fromEnvironment('AI_MODEL');

  // Defaults point at Gemini's OpenAI-compatibility layer; override via
  // --dart-define to use DeepSeek / Groq / OpenRouter / etc.
  static const _defaultBaseUrl =
      'https://generativelanguage.googleapis.com/v1beta/openai';
  static const _defaultModel = 'gemini-2.0-flash';

  static const _requestTimeout = Duration(seconds: 60);

  // Empty (not just absent) falls back to the Gemini defaults.
  String get _baseUrl => _baseUrlRaw.isEmpty ? _defaultBaseUrl : _baseUrlRaw;
  String get _model => _modelRaw.isEmpty ? _defaultModel : _modelRaw;

  @override
  bool get isConfigured => _apiKey.isNotEmpty;

  Uri get _uri {
    final trimmed = _baseUrl.endsWith('/')
        ? _baseUrl.substring(0, _baseUrl.length - 1)
        : _baseUrl;
    return Uri.parse('$trimmed/chat/completions');
  }

  @override
  Stream<String> resolveBug({
    required String prompt,
    required List<AiImage> images,
  }) async* {
    if (_apiKey.isEmpty) throw AiNotConfiguredException();

    final request = http.Request('POST', _uri)
      ..headers.addAll({
        'authorization': 'Bearer $_apiKey',
        'content-type': 'application/json',
      })
      ..body = jsonEncode({
        'model': _model,
        'stream': true,
        'max_tokens': 8192,
        'messages': [
          {
            'role': 'user',
            'content': [
              for (final image in images)
                {
                  'type': 'image_url',
                  'image_url': {
                    'url': 'data:${image.mediaType};base64,${image.base64Data}',
                  },
                },
              {'type': 'text', 'text': prompt},
            ],
          },
        ],
      });

    final response = await http.Client().send(request).timeout(_requestTimeout);

    if (response.statusCode != 200) {
      // Surface the provider's real error message (quota/model/etc.) — the
      // body never contains the api key. Falls back to just the status if the
      // body isn't the expected OpenAI-compatible error shape.
      final body = await response.stream.bytesToString();
      final detail = _extractError(body);
      throw AiApiException(
        detail == null
            ? 'AI request failed (${response.statusCode})'
            : 'AI request failed (${response.statusCode}): $detail',
      );
    }

    final lines = response.stream
        .transform(utf8.decoder)
        .transform(const LineSplitter());

    var emittedAny = false;
    await for (final line in lines) {
      if (!line.startsWith('data: ')) continue;
      final payload = line.substring('data: '.length).trim();
      if (payload == '[DONE]') break;
      if (payload.isEmpty) continue;

      final map = jsonDecode(payload) as Map<String, dynamic>;
      if (map['error'] != null) {
        final error = map['error'];
        final message = error is Map<String, dynamic>
            ? error['message']?.toString()
            : error.toString();
        throw AiApiException(message ?? 'AI stream error');
      }

      final choices = map['choices'];
      if (choices is List && choices.isNotEmpty) {
        final delta = (choices.first as Map<String, dynamic>)['delta'];
        final content = delta is Map<String, dynamic> ? delta['content'] : null;
        if (content is String && content.isNotEmpty) {
          emittedAny = true;
          yield content;
        }
      }
    }

    if (!emittedAny) {
      throw AiApiException(
        'The model returned no answer (it may have been blocked or rate-limited).',
      );
    }
  }

  /// Pulls `error.message` out of an OpenAI-compatible error body — handles the
  /// plain `{"error": {...}}` object and the list-wrapped `[{"error": {...}}]`
  /// shape some providers (e.g. Gemini) return. Null if it isn't that shape.
  String? _extractError(String body) {
    try {
      final decoded = jsonDecode(body);
      final map = decoded is List && decoded.isNotEmpty ? decoded.first : decoded;
      if (map is Map<String, dynamic>) {
        final error = map['error'];
        if (error is Map<String, dynamic>) return error['message']?.toString();
        if (error is String) return error;
      }
    } catch (_) {
      // Body wasn't JSON — fall back to the status-only message.
    }
    return null;
  }
}
