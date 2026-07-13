part of 'home_page_cubit.dart';

@freezed
abstract class HomePageState with _$HomePageState {
  const factory HomePageState({
    DateTime? checkInTime,
    DateTime? checkOutTime,
    WorkSchedule? workSchedule,
  }) = _HomePageState;
}
