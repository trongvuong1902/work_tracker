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

 int get totalLateMinutes; int get lateDayCount; int get totalOvertimeMinutes;
/// Create a copy of MonthSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthSummaryCopyWith<MonthSummary> get copyWith => _$MonthSummaryCopyWithImpl<MonthSummary>(this as MonthSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthSummary&&(identical(other.totalLateMinutes, totalLateMinutes) || other.totalLateMinutes == totalLateMinutes)&&(identical(other.lateDayCount, lateDayCount) || other.lateDayCount == lateDayCount)&&(identical(other.totalOvertimeMinutes, totalOvertimeMinutes) || other.totalOvertimeMinutes == totalOvertimeMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,totalLateMinutes,lateDayCount,totalOvertimeMinutes);

@override
String toString() {
  return 'MonthSummary(totalLateMinutes: $totalLateMinutes, lateDayCount: $lateDayCount, totalOvertimeMinutes: $totalOvertimeMinutes)';
}


}

/// @nodoc
abstract mixin class $MonthSummaryCopyWith<$Res>  {
  factory $MonthSummaryCopyWith(MonthSummary value, $Res Function(MonthSummary) _then) = _$MonthSummaryCopyWithImpl;
@useResult
$Res call({
 int totalLateMinutes, int lateDayCount, int totalOvertimeMinutes
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
@pragma('vm:prefer-inline') @override $Res call({Object? totalLateMinutes = null,Object? lateDayCount = null,Object? totalOvertimeMinutes = null,}) {
  return _then(_self.copyWith(
totalLateMinutes: null == totalLateMinutes ? _self.totalLateMinutes : totalLateMinutes // ignore: cast_nullable_to_non_nullable
as int,lateDayCount: null == lateDayCount ? _self.lateDayCount : lateDayCount // ignore: cast_nullable_to_non_nullable
as int,totalOvertimeMinutes: null == totalOvertimeMinutes ? _self.totalOvertimeMinutes : totalOvertimeMinutes // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalLateMinutes,  int lateDayCount,  int totalOvertimeMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthSummary() when $default != null:
return $default(_that.totalLateMinutes,_that.lateDayCount,_that.totalOvertimeMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalLateMinutes,  int lateDayCount,  int totalOvertimeMinutes)  $default,) {final _that = this;
switch (_that) {
case _MonthSummary():
return $default(_that.totalLateMinutes,_that.lateDayCount,_that.totalOvertimeMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalLateMinutes,  int lateDayCount,  int totalOvertimeMinutes)?  $default,) {final _that = this;
switch (_that) {
case _MonthSummary() when $default != null:
return $default(_that.totalLateMinutes,_that.lateDayCount,_that.totalOvertimeMinutes);case _:
  return null;

}
}

}

/// @nodoc


class _MonthSummary implements MonthSummary {
  const _MonthSummary({this.totalLateMinutes = 0, this.lateDayCount = 0, this.totalOvertimeMinutes = 0});
  

@override@JsonKey() final  int totalLateMinutes;
@override@JsonKey() final  int lateDayCount;
@override@JsonKey() final  int totalOvertimeMinutes;

/// Create a copy of MonthSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthSummaryCopyWith<_MonthSummary> get copyWith => __$MonthSummaryCopyWithImpl<_MonthSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthSummary&&(identical(other.totalLateMinutes, totalLateMinutes) || other.totalLateMinutes == totalLateMinutes)&&(identical(other.lateDayCount, lateDayCount) || other.lateDayCount == lateDayCount)&&(identical(other.totalOvertimeMinutes, totalOvertimeMinutes) || other.totalOvertimeMinutes == totalOvertimeMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,totalLateMinutes,lateDayCount,totalOvertimeMinutes);

@override
String toString() {
  return 'MonthSummary(totalLateMinutes: $totalLateMinutes, lateDayCount: $lateDayCount, totalOvertimeMinutes: $totalOvertimeMinutes)';
}


}

/// @nodoc
abstract mixin class _$MonthSummaryCopyWith<$Res> implements $MonthSummaryCopyWith<$Res> {
  factory _$MonthSummaryCopyWith(_MonthSummary value, $Res Function(_MonthSummary) _then) = __$MonthSummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalLateMinutes, int lateDayCount, int totalOvertimeMinutes
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
@override @pragma('vm:prefer-inline') $Res call({Object? totalLateMinutes = null,Object? lateDayCount = null,Object? totalOvertimeMinutes = null,}) {
  return _then(_MonthSummary(
totalLateMinutes: null == totalLateMinutes ? _self.totalLateMinutes : totalLateMinutes // ignore: cast_nullable_to_non_nullable
as int,lateDayCount: null == lateDayCount ? _self.lateDayCount : lateDayCount // ignore: cast_nullable_to_non_nullable
as int,totalOvertimeMinutes: null == totalOvertimeMinutes ? _self.totalOvertimeMinutes : totalOvertimeMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
