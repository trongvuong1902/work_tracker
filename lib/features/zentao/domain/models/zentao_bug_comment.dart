import 'package:freezed_annotation/freezed_annotation.dart';

part 'zentao_bug_comment.freezed.dart';

/// One entry from a Zentao bug's action/history log (the `actions` array on a
/// bug detail response) — the actor who acted, when, and the comment text (may
/// be empty for pure status-change actions with no written comment).
@freezed
abstract class ZentaoBugComment with _$ZentaoBugComment {
  const factory ZentaoBugComment({
    int? id,
    String? actor,
    DateTime? date,
    required String comment,
  }) = _ZentaoBugComment;
}
