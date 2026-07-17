import 'package:freezed_annotation/freezed_annotation.dart';

part 'zentao_bug.freezed.dart';

@freezed
abstract class ZentaoBug with _$ZentaoBug {
  const factory ZentaoBug({
    required int id,
    required String title,
    required String status,
    String? description,
    int? priority,
    String? assignedToAccount,
    String? assignedToRealName,
    int? severity,
    DateTime? deadline,
  }) = _ZentaoBug;
}
