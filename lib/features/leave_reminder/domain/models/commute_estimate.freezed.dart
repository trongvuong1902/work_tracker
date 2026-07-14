// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'commute_estimate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommuteEstimate {

 int get durationMinutes; int get durationInTrafficMinutes;
/// Create a copy of CommuteEstimate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommuteEstimateCopyWith<CommuteEstimate> get copyWith => _$CommuteEstimateCopyWithImpl<CommuteEstimate>(this as CommuteEstimate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommuteEstimate&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.durationInTrafficMinutes, durationInTrafficMinutes) || other.durationInTrafficMinutes == durationInTrafficMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,durationMinutes,durationInTrafficMinutes);

@override
String toString() {
  return 'CommuteEstimate(durationMinutes: $durationMinutes, durationInTrafficMinutes: $durationInTrafficMinutes)';
}


}

/// @nodoc
abstract mixin class $CommuteEstimateCopyWith<$Res>  {
  factory $CommuteEstimateCopyWith(CommuteEstimate value, $Res Function(CommuteEstimate) _then) = _$CommuteEstimateCopyWithImpl;
@useResult
$Res call({
 int durationMinutes, int durationInTrafficMinutes
});




}
/// @nodoc
class _$CommuteEstimateCopyWithImpl<$Res>
    implements $CommuteEstimateCopyWith<$Res> {
  _$CommuteEstimateCopyWithImpl(this._self, this._then);

  final CommuteEstimate _self;
  final $Res Function(CommuteEstimate) _then;

/// Create a copy of CommuteEstimate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMinutes = null,Object? durationInTrafficMinutes = null,}) {
  return _then(_self.copyWith(
durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,durationInTrafficMinutes: null == durationInTrafficMinutes ? _self.durationInTrafficMinutes : durationInTrafficMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CommuteEstimate].
extension CommuteEstimatePatterns on CommuteEstimate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommuteEstimate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommuteEstimate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommuteEstimate value)  $default,){
final _that = this;
switch (_that) {
case _CommuteEstimate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommuteEstimate value)?  $default,){
final _that = this;
switch (_that) {
case _CommuteEstimate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int durationMinutes,  int durationInTrafficMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommuteEstimate() when $default != null:
return $default(_that.durationMinutes,_that.durationInTrafficMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int durationMinutes,  int durationInTrafficMinutes)  $default,) {final _that = this;
switch (_that) {
case _CommuteEstimate():
return $default(_that.durationMinutes,_that.durationInTrafficMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int durationMinutes,  int durationInTrafficMinutes)?  $default,) {final _that = this;
switch (_that) {
case _CommuteEstimate() when $default != null:
return $default(_that.durationMinutes,_that.durationInTrafficMinutes);case _:
  return null;

}
}

}

/// @nodoc


class _CommuteEstimate implements CommuteEstimate {
  const _CommuteEstimate({required this.durationMinutes, required this.durationInTrafficMinutes});
  

@override final  int durationMinutes;
@override final  int durationInTrafficMinutes;

/// Create a copy of CommuteEstimate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommuteEstimateCopyWith<_CommuteEstimate> get copyWith => __$CommuteEstimateCopyWithImpl<_CommuteEstimate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommuteEstimate&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.durationInTrafficMinutes, durationInTrafficMinutes) || other.durationInTrafficMinutes == durationInTrafficMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,durationMinutes,durationInTrafficMinutes);

@override
String toString() {
  return 'CommuteEstimate(durationMinutes: $durationMinutes, durationInTrafficMinutes: $durationInTrafficMinutes)';
}


}

/// @nodoc
abstract mixin class _$CommuteEstimateCopyWith<$Res> implements $CommuteEstimateCopyWith<$Res> {
  factory _$CommuteEstimateCopyWith(_CommuteEstimate value, $Res Function(_CommuteEstimate) _then) = __$CommuteEstimateCopyWithImpl;
@override @useResult
$Res call({
 int durationMinutes, int durationInTrafficMinutes
});




}
/// @nodoc
class __$CommuteEstimateCopyWithImpl<$Res>
    implements _$CommuteEstimateCopyWith<$Res> {
  __$CommuteEstimateCopyWithImpl(this._self, this._then);

  final _CommuteEstimate _self;
  final $Res Function(_CommuteEstimate) _then;

/// Create a copy of CommuteEstimate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? durationMinutes = null,Object? durationInTrafficMinutes = null,}) {
  return _then(_CommuteEstimate(
durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,durationInTrafficMinutes: null == durationInTrafficMinutes ? _self.durationInTrafficMinutes : durationInTrafficMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
