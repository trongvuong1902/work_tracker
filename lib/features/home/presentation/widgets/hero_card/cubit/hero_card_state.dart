part of 'hero_card_cubit.dart';

@freezed
abstract class HeroCardState with _$HeroCardState {
  const factory HeroCardState({HeroCardModel? heroCardModel}) = _HeroCardState;
}
