import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../task/domain/bug_prompt.dart';
import '../../task/domain/models/task.dart';
import '../../zentao/domain/models/zentao_bug_attachment.dart';
import '../../zentao/domain/zentao_repository.dart';
import '../data/ai_client.dart';

abstract class AiRepository {
  /// Whether an AI API key is configured for this build.
  bool get isConfigured;

  /// Streams the model's diagnosis/fix for [task]'s linked Zentao bug — builds
  /// the prompt from the task's synced fields and attaches whatever
  /// downloadable image attachments qualify (see [AiRepositoryImpl]).
  Stream<String> resolveBug(Task task);
}

/// Vision-supported image formats and their per-extension mapping.
const _supportedImageMediaTypes = {
  'png': 'image/png',
  'jpg': 'image/jpeg',
  'jpeg': 'image/jpeg',
  'gif': 'image/gif',
  'webp': 'image/webp',
};

const _maxImageBytes = 4 * 1024 * 1024;
const _maxImages = 5;

@LazySingleton(as: AiRepository)
class AiRepositoryImpl implements AiRepository {
  AiRepositoryImpl(this._client, this._zentaoRepository);

  final AiClient _client;
  final ZentaoRepository _zentaoRepository;

  @override
  bool get isConfigured => _client.isConfigured;

  @override
  Stream<String> resolveBug(Task task) async* {
    final prompt = buildBugResolutionPrompt(task);
    final images = await _buildImages(task.attachments);
    yield* _client.resolveBug(prompt: prompt, images: images);
  }

  Future<List<AiImage>> _buildImages(
    List<ZentaoBugAttachment> attachments,
  ) async {
    final images = <AiImage>[];
    for (final attachment in attachments) {
      if (images.length >= _maxImages) break;
      if (!attachment.isImage) continue;
      if (attachment.sizeBytes != null &&
          attachment.sizeBytes! > _maxImageBytes) {
        continue;
      }
      final mediaType =
          _supportedImageMediaTypes[(attachment.fileExtension ?? '')
              .toLowerCase()];
      if (mediaType == null) continue;

      try {
        final file = await _zentaoRepository.downloadAttachment(attachment);
        final bytes = await file.readAsBytes();
        images.add(
          AiImage(mediaType: mediaType, base64Data: base64Encode(bytes)),
        );
      } catch (_) {
        // Skip attachments that fail to download rather than aborting the
        // whole request.
      }
    }
    return images;
  }
}
