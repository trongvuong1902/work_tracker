import 'package:freezed_annotation/freezed_annotation.dart';

part 'tomorrow_preview.freezed.dart';

@freezed
abstract class TomorrowPreview with _$TomorrowPreview {
  const factory TomorrowPreview({
    required DateTime leaveTime,
    required int averageCommuteMinutes,
    int? weatherCode,
    double? temperature,
    required String bodyText,
  }) = _TomorrowPreview;
}
