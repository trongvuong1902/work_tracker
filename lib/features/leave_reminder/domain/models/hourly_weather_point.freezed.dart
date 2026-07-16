// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hourly_weather_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HourlyWeatherPoint {

 DateTime get time; double get temperature; int get weatherCode;
/// Create a copy of HourlyWeatherPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HourlyWeatherPointCopyWith<HourlyWeatherPoint> get copyWith => _$HourlyWeatherPointCopyWithImpl<HourlyWeatherPoint>(this as HourlyWeatherPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HourlyWeatherPoint&&(identical(other.time, time) || other.time == time)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode));
}


@override
int get hashCode => Object.hash(runtimeType,time,temperature,weatherCode);

@override
String toString() {
  return 'HourlyWeatherPoint(time: $time, temperature: $temperature, weatherCode: $weatherCode)';
}


}

/// @nodoc
abstract mixin class $HourlyWeatherPointCopyWith<$Res>  {
  factory $HourlyWeatherPointCopyWith(HourlyWeatherPoint value, $Res Function(HourlyWeatherPoint) _then) = _$HourlyWeatherPointCopyWithImpl;
@useResult
$Res call({
 DateTime time, double temperature, int weatherCode
});




}
/// @nodoc
class _$HourlyWeatherPointCopyWithImpl<$Res>
    implements $HourlyWeatherPointCopyWith<$Res> {
  _$HourlyWeatherPointCopyWithImpl(this._self, this._then);

  final HourlyWeatherPoint _self;
  final $Res Function(HourlyWeatherPoint) _then;

/// Create a copy of HourlyWeatherPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? temperature = null,Object? weatherCode = null,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,weatherCode: null == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HourlyWeatherPoint].
extension HourlyWeatherPointPatterns on HourlyWeatherPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HourlyWeatherPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HourlyWeatherPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HourlyWeatherPoint value)  $default,){
final _that = this;
switch (_that) {
case _HourlyWeatherPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HourlyWeatherPoint value)?  $default,){
final _that = this;
switch (_that) {
case _HourlyWeatherPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime time,  double temperature,  int weatherCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HourlyWeatherPoint() when $default != null:
return $default(_that.time,_that.temperature,_that.weatherCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime time,  double temperature,  int weatherCode)  $default,) {final _that = this;
switch (_that) {
case _HourlyWeatherPoint():
return $default(_that.time,_that.temperature,_that.weatherCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime time,  double temperature,  int weatherCode)?  $default,) {final _that = this;
switch (_that) {
case _HourlyWeatherPoint() when $default != null:
return $default(_that.time,_that.temperature,_that.weatherCode);case _:
  return null;

}
}

}

/// @nodoc


class _HourlyWeatherPoint implements HourlyWeatherPoint {
  const _HourlyWeatherPoint({required this.time, required this.temperature, required this.weatherCode});
  

@override final  DateTime time;
@override final  double temperature;
@override final  int weatherCode;

/// Create a copy of HourlyWeatherPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HourlyWeatherPointCopyWith<_HourlyWeatherPoint> get copyWith => __$HourlyWeatherPointCopyWithImpl<_HourlyWeatherPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HourlyWeatherPoint&&(identical(other.time, time) || other.time == time)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode));
}


@override
int get hashCode => Object.hash(runtimeType,time,temperature,weatherCode);

@override
String toString() {
  return 'HourlyWeatherPoint(time: $time, temperature: $temperature, weatherCode: $weatherCode)';
}


}

/// @nodoc
abstract mixin class _$HourlyWeatherPointCopyWith<$Res> implements $HourlyWeatherPointCopyWith<$Res> {
  factory _$HourlyWeatherPointCopyWith(_HourlyWeatherPoint value, $Res Function(_HourlyWeatherPoint) _then) = __$HourlyWeatherPointCopyWithImpl;
@override @useResult
$Res call({
 DateTime time, double temperature, int weatherCode
});




}
/// @nodoc
class __$HourlyWeatherPointCopyWithImpl<$Res>
    implements _$HourlyWeatherPointCopyWith<$Res> {
  __$HourlyWeatherPointCopyWithImpl(this._self, this._then);

  final _HourlyWeatherPoint _self;
  final $Res Function(_HourlyWeatherPoint) _then;

/// Create a copy of HourlyWeatherPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? temperature = null,Object? weatherCode = null,}) {
  return _then(_HourlyWeatherPoint(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,weatherCode: null == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
