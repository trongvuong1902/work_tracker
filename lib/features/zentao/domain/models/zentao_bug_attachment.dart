import 'package:freezed_annotation/freezed_annotation.dart';

part 'zentao_bug_attachment.freezed.dart';

/// A file attached to a Zentao bug (an entry in the bug detail `files` array).
/// Only metadata — the bytes are fetched on demand via
/// `ZentaoRepository.downloadAttachment`.
@freezed
abstract class ZentaoBugAttachment with _$ZentaoBugAttachment {
  const factory ZentaoBugAttachment({
    required int id,
    required String title,
    String? fileExtension,
    int? sizeBytes,
  }) = _ZentaoBugAttachment;
}

extension ZentaoBugAttachmentX on ZentaoBugAttachment {
  String get _ext => (fileExtension ?? '').toLowerCase();

  bool get isImage =>
      const {'png', 'jpg', 'jpeg', 'gif', 'webp', 'bmp', 'heic'}.contains(_ext);

  bool get isVideo => const {
    'mp4',
    'mov',
    'm4v',
    'webm',
    '3gp',
    'mkv',
    'avi',
  }.contains(_ext);
}
