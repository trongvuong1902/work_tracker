import 'package:freezed_annotation/freezed_annotation.dart';

import 'zentao_bug.dart';
import 'zentao_bug_attachment.dart';
import 'zentao_bug_comment.dart';

part 'zentao_bug_detail.freezed.dart';

/// Full live view of a Zentao bug — the base [bug] fields plus the
/// action/comment history and attachments, fetched on demand when opening a
/// bug-linked task's detail screen (not persisted locally).
@freezed
abstract class ZentaoBugDetail with _$ZentaoBugDetail {
  const factory ZentaoBugDetail({
    required ZentaoBug bug,
    @Default(<ZentaoBugComment>[]) List<ZentaoBugComment> comments,
    @Default(<ZentaoBugAttachment>[]) List<ZentaoBugAttachment> attachments,
  }) = _ZentaoBugDetail;
}
