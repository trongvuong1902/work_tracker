import 'package:freezed_annotation/freezed_annotation.dart';

part 'commute_estimate.freezed.dart';

@freezed
abstract class CommuteEstimate with _$CommuteEstimate {
  const factory CommuteEstimate({
    required int durationMinutes,
    required int durationInTrafficMinutes,
  }) = _CommuteEstimate;
}
