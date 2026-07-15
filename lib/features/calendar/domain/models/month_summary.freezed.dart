// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'month_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MonthSummary {

 int get lateCount; int get soonCount; int get onTimeCount;
/// Create a copy of MonthSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthSummaryCopyWith<MonthSummary> get copyWith => _$MonthSummaryCopyWithImpl<MonthSummary>(this as MonthSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthSummary&&(identical(other.lateCount, lateCount) || other.lateCount == lateCount)&&(identical(other.soonCount, soonCount) || other.soonCount == soonCount)&&(identical(other.onTimeCount, onTimeCount) || other.onTimeCount == onTimeCount));
}


@override
int get hashCode => Object.hash(runtimeType,lateCount,soonCount,onTimeCount);

@override
String toString() {
  return 'MonthSummary(lateCount: $lateCount, soonCount: $soonCount, onTimeCount: $onTimeCount)';
}


}

/// @nodoc
abstract mixin class $MonthSummaryCopyWith<$Res>  {
  factory $MonthSummaryCopyWith(MonthSummary value, $Res Function(MonthSummary) _then) = _$MonthSummaryCopyWithImpl;
@useResult
$Res call({
 int lateCount, int soonCount, int onTimeCount
});




}
/// @nodoc
class _$MonthSummaryCopyWithImpl<$Res>
    implements $MonthSummaryCopyWith<$Res> {
  _$MonthSummaryCopyWithImpl(this._self, this._then);

  final MonthSummary _self;
  final $Res Function(MonthSummary) _then;

/// Create a copy of MonthSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lateCount = null,Object? soonCount = null,Object? onTimeCount = null,}) {
  return _then(_self.copyWith(
lateCount: null == lateCount ? _self.lateCount : lateCount // ignore: cast_nullable_to_non_nullable
as int,soonCount: null == soonCount ? _self.soonCount : soonCount // ignore: cast_nullable_to_non_nullable
as int,onTimeCount: null == onTimeCount ? _self.onTimeCount : onTimeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthSummary].
extension MonthSummaryPatterns on MonthSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthSummary value)  $default,){
final _that = this;
switch (_that) {
case _MonthSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthSummary value)?  $default,){
final _that = this;
switch (_that) {
case _MonthSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int lateCount,  int soonCount,  int onTimeCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthSummary() when $default != null:
return $default(_that.lateCount,_that.soonCount,_that.onTimeCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int lateCount,  int soonCount,  int onTimeCount)  $default,) {final _that = this;
switch (_that) {
case _MonthSummary():
return $default(_that.lateCount,_that.soonCount,_that.onTimeCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int lateCount,  int soonCount,  int onTimeCount)?  $default,) {final _that = this;
switch (_that) {
case _MonthSummary() when $default != null:
return $default(_that.lateCount,_that.soonCount,_that.onTimeCount);case _:
  return null;

}
}

}

/// @nodoc


class _MonthSummary implements MonthSummary {
  const _MonthSummary({this.lateCount = 0, this.soonCount = 0, this.onTimeCount = 0});
  

@override@JsonKey() final  int lateCount;
@override@JsonKey() final  int soonCount;
@override@JsonKey() final  int onTimeCount;

/// Create a copy of MonthSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthSummaryCopyWith<_MonthSummary> get copyWith => __$MonthSummaryCopyWithImpl<_MonthSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthSummary&&(identical(other.lateCount, lateCount) || other.lateCount == lateCount)&&(identical(other.soonCount, soonCount) || other.soonCount == soonCount)&&(identical(other.onTimeCount, onTimeCount) || other.onTimeCount == onTimeCount));
}


@override
int get hashCode => Object.hash(runtimeType,lateCount,soonCount,onTimeCount);

@override
String toString() {
  return 'MonthSummary(lateCount: $lateCount, soonCount: $soonCount, onTimeCount: $onTimeCount)';
}


}

/// @nodoc
abstract mixin class _$MonthSummaryCopyWith<$Res> implements $MonthSummaryCopyWith<$Res> {
  factory _$MonthSummaryCopyWith(_MonthSummary value, $Res Function(_MonthSummary) _then) = __$MonthSummaryCopyWithImpl;
@override @useResult
$Res call({
 int lateCount, int soonCount, int onTimeCount
});




}
/// @nodoc
class __$MonthSummaryCopyWithImpl<$Res>
    implements _$MonthSummaryCopyWith<$Res> {
  __$MonthSummaryCopyWithImpl(this._self, this._then);

  final _MonthSummary _self;
  final $Res Function(_MonthSummary) _then;

/// Create a copy of MonthSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lateCount = null,Object? soonCount = null,Object? onTimeCount = null,}) {
  return _then(_MonthSummary(
lateCount: null == lateCount ? _self.lateCount : lateCount // ignore: cast_nullable_to_non_nullable
as int,soonCount: null == soonCount ? _self.soonCount : soonCount // ignore: cast_nullable_to_non_nullable
as int,onTimeCount: null == onTimeCount ? _self.onTimeCount : onTimeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
