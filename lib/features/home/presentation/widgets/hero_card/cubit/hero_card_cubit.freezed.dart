// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hero_card_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HeroCardState {

 HeroCardModel? get heroCardModel;
/// Create a copy of HeroCardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeroCardStateCopyWith<HeroCardState> get copyWith => _$HeroCardStateCopyWithImpl<HeroCardState>(this as HeroCardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeroCardState&&(identical(other.heroCardModel, heroCardModel) || other.heroCardModel == heroCardModel));
}


@override
int get hashCode => Object.hash(runtimeType,heroCardModel);

@override
String toString() {
  return 'HeroCardState(heroCardModel: $heroCardModel)';
}


}

/// @nodoc
abstract mixin class $HeroCardStateCopyWith<$Res>  {
  factory $HeroCardStateCopyWith(HeroCardState value, $Res Function(HeroCardState) _then) = _$HeroCardStateCopyWithImpl;
@useResult
$Res call({
 HeroCardModel? heroCardModel
});


$HeroCardModelCopyWith<$Res>? get heroCardModel;

}
/// @nodoc
class _$HeroCardStateCopyWithImpl<$Res>
    implements $HeroCardStateCopyWith<$Res> {
  _$HeroCardStateCopyWithImpl(this._self, this._then);

  final HeroCardState _self;
  final $Res Function(HeroCardState) _then;

/// Create a copy of HeroCardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? heroCardModel = freezed,}) {
  return _then(_self.copyWith(
heroCardModel: freezed == heroCardModel ? _self.heroCardModel : heroCardModel // ignore: cast_nullable_to_non_nullable
as HeroCardModel?,
  ));
}
/// Create a copy of HeroCardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HeroCardModelCopyWith<$Res>? get heroCardModel {
    if (_self.heroCardModel == null) {
    return null;
  }

  return $HeroCardModelCopyWith<$Res>(_self.heroCardModel!, (value) {
    return _then(_self.copyWith(heroCardModel: value));
  });
}
}


/// Adds pattern-matching-related methods to [HeroCardState].
extension HeroCardStatePatterns on HeroCardState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HeroCardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HeroCardState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HeroCardState value)  $default,){
final _that = this;
switch (_that) {
case _HeroCardState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HeroCardState value)?  $default,){
final _that = this;
switch (_that) {
case _HeroCardState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HeroCardModel? heroCardModel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeroCardState() when $default != null:
return $default(_that.heroCardModel);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HeroCardModel? heroCardModel)  $default,) {final _that = this;
switch (_that) {
case _HeroCardState():
return $default(_that.heroCardModel);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HeroCardModel? heroCardModel)?  $default,) {final _that = this;
switch (_that) {
case _HeroCardState() when $default != null:
return $default(_that.heroCardModel);case _:
  return null;

}
}

}

/// @nodoc


class _HeroCardState implements HeroCardState {
  const _HeroCardState({this.heroCardModel});
  

@override final  HeroCardModel? heroCardModel;

/// Create a copy of HeroCardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeroCardStateCopyWith<_HeroCardState> get copyWith => __$HeroCardStateCopyWithImpl<_HeroCardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeroCardState&&(identical(other.heroCardModel, heroCardModel) || other.heroCardModel == heroCardModel));
}


@override
int get hashCode => Object.hash(runtimeType,heroCardModel);

@override
String toString() {
  return 'HeroCardState(heroCardModel: $heroCardModel)';
}


}

/// @nodoc
abstract mixin class _$HeroCardStateCopyWith<$Res> implements $HeroCardStateCopyWith<$Res> {
  factory _$HeroCardStateCopyWith(_HeroCardState value, $Res Function(_HeroCardState) _then) = __$HeroCardStateCopyWithImpl;
@override @useResult
$Res call({
 HeroCardModel? heroCardModel
});


@override $HeroCardModelCopyWith<$Res>? get heroCardModel;

}
/// @nodoc
class __$HeroCardStateCopyWithImpl<$Res>
    implements _$HeroCardStateCopyWith<$Res> {
  __$HeroCardStateCopyWithImpl(this._self, this._then);

  final _HeroCardState _self;
  final $Res Function(_HeroCardState) _then;

/// Create a copy of HeroCardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? heroCardModel = freezed,}) {
  return _then(_HeroCardState(
heroCardModel: freezed == heroCardModel ? _self.heroCardModel : heroCardModel // ignore: cast_nullable_to_non_nullable
as HeroCardModel?,
  ));
}

/// Create a copy of HeroCardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HeroCardModelCopyWith<$Res>? get heroCardModel {
    if (_self.heroCardModel == null) {
    return null;
  }

  return $HeroCardModelCopyWith<$Res>(_self.heroCardModel!, (value) {
    return _then(_self.copyWith(heroCardModel: value));
  });
}
}

// dart format on
