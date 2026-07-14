// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendace_card_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttendaceCardState {

 AttendanceCardModel? get model;
/// Create a copy of AttendaceCardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendaceCardStateCopyWith<AttendaceCardState> get copyWith => _$AttendaceCardStateCopyWithImpl<AttendaceCardState>(this as AttendaceCardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendaceCardState&&(identical(other.model, model) || other.model == model));
}


@override
int get hashCode => Object.hash(runtimeType,model);

@override
String toString() {
  return 'AttendaceCardState(model: $model)';
}


}

/// @nodoc
abstract mixin class $AttendaceCardStateCopyWith<$Res>  {
  factory $AttendaceCardStateCopyWith(AttendaceCardState value, $Res Function(AttendaceCardState) _then) = _$AttendaceCardStateCopyWithImpl;
@useResult
$Res call({
 AttendanceCardModel? model
});


$AttendanceCardModelCopyWith<$Res>? get model;

}
/// @nodoc
class _$AttendaceCardStateCopyWithImpl<$Res>
    implements $AttendaceCardStateCopyWith<$Res> {
  _$AttendaceCardStateCopyWithImpl(this._self, this._then);

  final AttendaceCardState _self;
  final $Res Function(AttendaceCardState) _then;

/// Create a copy of AttendaceCardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? model = freezed,}) {
  return _then(_self.copyWith(
model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as AttendanceCardModel?,
  ));
}
/// Create a copy of AttendaceCardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceCardModelCopyWith<$Res>? get model {
    if (_self.model == null) {
    return null;
  }

  return $AttendanceCardModelCopyWith<$Res>(_self.model!, (value) {
    return _then(_self.copyWith(model: value));
  });
}
}


/// Adds pattern-matching-related methods to [AttendaceCardState].
extension AttendaceCardStatePatterns on AttendaceCardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendaceCardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendaceCardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendaceCardState value)  $default,){
final _that = this;
switch (_that) {
case _AttendaceCardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendaceCardState value)?  $default,){
final _that = this;
switch (_that) {
case _AttendaceCardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AttendanceCardModel? model)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendaceCardState() when $default != null:
return $default(_that.model);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AttendanceCardModel? model)  $default,) {final _that = this;
switch (_that) {
case _AttendaceCardState():
return $default(_that.model);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AttendanceCardModel? model)?  $default,) {final _that = this;
switch (_that) {
case _AttendaceCardState() when $default != null:
return $default(_that.model);case _:
  return null;

}
}

}

/// @nodoc


class _AttendaceCardState implements AttendaceCardState {
  const _AttendaceCardState({this.model});
  

@override final  AttendanceCardModel? model;

/// Create a copy of AttendaceCardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendaceCardStateCopyWith<_AttendaceCardState> get copyWith => __$AttendaceCardStateCopyWithImpl<_AttendaceCardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendaceCardState&&(identical(other.model, model) || other.model == model));
}


@override
int get hashCode => Object.hash(runtimeType,model);

@override
String toString() {
  return 'AttendaceCardState(model: $model)';
}


}

/// @nodoc
abstract mixin class _$AttendaceCardStateCopyWith<$Res> implements $AttendaceCardStateCopyWith<$Res> {
  factory _$AttendaceCardStateCopyWith(_AttendaceCardState value, $Res Function(_AttendaceCardState) _then) = __$AttendaceCardStateCopyWithImpl;
@override @useResult
$Res call({
 AttendanceCardModel? model
});


@override $AttendanceCardModelCopyWith<$Res>? get model;

}
/// @nodoc
class __$AttendaceCardStateCopyWithImpl<$Res>
    implements _$AttendaceCardStateCopyWith<$Res> {
  __$AttendaceCardStateCopyWithImpl(this._self, this._then);

  final _AttendaceCardState _self;
  final $Res Function(_AttendaceCardState) _then;

/// Create a copy of AttendaceCardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? model = freezed,}) {
  return _then(_AttendaceCardState(
model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as AttendanceCardModel?,
  ));
}

/// Create a copy of AttendaceCardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceCardModelCopyWith<$Res>? get model {
    if (_self.model == null) {
    return null;
  }

  return $AttendanceCardModelCopyWith<$Res>(_self.model!, (value) {
    return _then(_self.copyWith(model: value));
  });
}
}

// dart format on
