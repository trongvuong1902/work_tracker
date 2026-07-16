// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WeatherSnapshot {

 DateTime get currentTime; int get currentWeatherCode; double get currentTemperature; List<HourlyWeatherPoint> get hourly;
/// Create a copy of WeatherSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherSnapshotCopyWith<WeatherSnapshot> get copyWith => _$WeatherSnapshotCopyWithImpl<WeatherSnapshot>(this as WeatherSnapshot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherSnapshot&&(identical(other.currentTime, currentTime) || other.currentTime == currentTime)&&(identical(other.currentWeatherCode, currentWeatherCode) || other.currentWeatherCode == currentWeatherCode)&&(identical(other.currentTemperature, currentTemperature) || other.currentTemperature == currentTemperature)&&const DeepCollectionEquality().equals(other.hourly, hourly));
}


@override
int get hashCode => Object.hash(runtimeType,currentTime,currentWeatherCode,currentTemperature,const DeepCollectionEquality().hash(hourly));

@override
String toString() {
  return 'WeatherSnapshot(currentTime: $currentTime, currentWeatherCode: $currentWeatherCode, currentTemperature: $currentTemperature, hourly: $hourly)';
}


}

/// @nodoc
abstract mixin class $WeatherSnapshotCopyWith<$Res>  {
  factory $WeatherSnapshotCopyWith(WeatherSnapshot value, $Res Function(WeatherSnapshot) _then) = _$WeatherSnapshotCopyWithImpl;
@useResult
$Res call({
 DateTime currentTime, int currentWeatherCode, double currentTemperature, List<HourlyWeatherPoint> hourly
});




}
/// @nodoc
class _$WeatherSnapshotCopyWithImpl<$Res>
    implements $WeatherSnapshotCopyWith<$Res> {
  _$WeatherSnapshotCopyWithImpl(this._self, this._then);

  final WeatherSnapshot _self;
  final $Res Function(WeatherSnapshot) _then;

/// Create a copy of WeatherSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentTime = null,Object? currentWeatherCode = null,Object? currentTemperature = null,Object? hourly = null,}) {
  return _then(_self.copyWith(
currentTime: null == currentTime ? _self.currentTime : currentTime // ignore: cast_nullable_to_non_nullable
as DateTime,currentWeatherCode: null == currentWeatherCode ? _self.currentWeatherCode : currentWeatherCode // ignore: cast_nullable_to_non_nullable
as int,currentTemperature: null == currentTemperature ? _self.currentTemperature : currentTemperature // ignore: cast_nullable_to_non_nullable
as double,hourly: null == hourly ? _self.hourly : hourly // ignore: cast_nullable_to_non_nullable
as List<HourlyWeatherPoint>,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherSnapshot].
extension WeatherSnapshotPatterns on WeatherSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _WeatherSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime currentTime,  int currentWeatherCode,  double currentTemperature,  List<HourlyWeatherPoint> hourly)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherSnapshot() when $default != null:
return $default(_that.currentTime,_that.currentWeatherCode,_that.currentTemperature,_that.hourly);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime currentTime,  int currentWeatherCode,  double currentTemperature,  List<HourlyWeatherPoint> hourly)  $default,) {final _that = this;
switch (_that) {
case _WeatherSnapshot():
return $default(_that.currentTime,_that.currentWeatherCode,_that.currentTemperature,_that.hourly);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime currentTime,  int currentWeatherCode,  double currentTemperature,  List<HourlyWeatherPoint> hourly)?  $default,) {final _that = this;
switch (_that) {
case _WeatherSnapshot() when $default != null:
return $default(_that.currentTime,_that.currentWeatherCode,_that.currentTemperature,_that.hourly);case _:
  return null;

}
}

}

/// @nodoc


class _WeatherSnapshot implements WeatherSnapshot {
  const _WeatherSnapshot({required this.currentTime, required this.currentWeatherCode, required this.currentTemperature, required final  List<HourlyWeatherPoint> hourly}): _hourly = hourly;
  

@override final  DateTime currentTime;
@override final  int currentWeatherCode;
@override final  double currentTemperature;
 final  List<HourlyWeatherPoint> _hourly;
@override List<HourlyWeatherPoint> get hourly {
  if (_hourly is EqualUnmodifiableListView) return _hourly;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hourly);
}


/// Create a copy of WeatherSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherSnapshotCopyWith<_WeatherSnapshot> get copyWith => __$WeatherSnapshotCopyWithImpl<_WeatherSnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherSnapshot&&(identical(other.currentTime, currentTime) || other.currentTime == currentTime)&&(identical(other.currentWeatherCode, currentWeatherCode) || other.currentWeatherCode == currentWeatherCode)&&(identical(other.currentTemperature, currentTemperature) || other.currentTemperature == currentTemperature)&&const DeepCollectionEquality().equals(other._hourly, _hourly));
}


@override
int get hashCode => Object.hash(runtimeType,currentTime,currentWeatherCode,currentTemperature,const DeepCollectionEquality().hash(_hourly));

@override
String toString() {
  return 'WeatherSnapshot(currentTime: $currentTime, currentWeatherCode: $currentWeatherCode, currentTemperature: $currentTemperature, hourly: $hourly)';
}


}

/// @nodoc
abstract mixin class _$WeatherSnapshotCopyWith<$Res> implements $WeatherSnapshotCopyWith<$Res> {
  factory _$WeatherSnapshotCopyWith(_WeatherSnapshot value, $Res Function(_WeatherSnapshot) _then) = __$WeatherSnapshotCopyWithImpl;
@override @useResult
$Res call({
 DateTime currentTime, int currentWeatherCode, double currentTemperature, List<HourlyWeatherPoint> hourly
});




}
/// @nodoc
class __$WeatherSnapshotCopyWithImpl<$Res>
    implements _$WeatherSnapshotCopyWith<$Res> {
  __$WeatherSnapshotCopyWithImpl(this._self, this._then);

  final _WeatherSnapshot _self;
  final $Res Function(_WeatherSnapshot) _then;

/// Create a copy of WeatherSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentTime = null,Object? currentWeatherCode = null,Object? currentTemperature = null,Object? hourly = null,}) {
  return _then(_WeatherSnapshot(
currentTime: null == currentTime ? _self.currentTime : currentTime // ignore: cast_nullable_to_non_nullable
as DateTime,currentWeatherCode: null == currentWeatherCode ? _self.currentWeatherCode : currentWeatherCode // ignore: cast_nullable_to_non_nullable
as int,currentTemperature: null == currentTemperature ? _self.currentTemperature : currentTemperature // ignore: cast_nullable_to_non_nullable
as double,hourly: null == hourly ? _self._hourly : hourly // ignore: cast_nullable_to_non_nullable
as List<HourlyWeatherPoint>,
  ));
}


}

// dart format on
