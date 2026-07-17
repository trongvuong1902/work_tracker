import 'package:freezed_annotation/freezed_annotation.dart';

part 'zentao_task.freezed.dart';

@freezed
abstract class ZentaoTask with _$ZentaoTask {
  const factory ZentaoTask({
    required int id,
    required String name,
    required String status,
    String? assignedToAccount,
    String? assignedToRealName,
    double? estimate,
    double? consumed,
    double? left,
    DateTime? deadline,
  }) = _ZentaoTask;
}
