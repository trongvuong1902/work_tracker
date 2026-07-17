// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationLog {

 int get dayKey; LocationLogType get type; DateTime get timestamp; double? get latitude; double? get longitude; String? get address;
/// Create a copy of LocationLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationLogCopyWith<LocationLog> get copyWith => _$LocationLogCopyWithImpl<LocationLog>(this as LocationLog, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationLog&&(identical(other.dayKey, dayKey) || other.dayKey == dayKey)&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address));
}


@override
int get hashCode => Object.hash(runtimeType,dayKey,type,timestamp,latitude,longitude,address);

@override
String toString() {
  return 'LocationLog(dayKey: $dayKey, type: $type, timestamp: $timestamp, latitude: $latitude, longitude: $longitude, address: $address)';
}


}

/// @nodoc
abstract mixin class $LocationLogCopyWith<$Res>  {
  factory $LocationLogCopyWith(LocationLog value, $Res Function(LocationLog) _then) = _$LocationLogCopyWithImpl;
@useResult
$Res call({
 int dayKey, LocationLogType type, DateTime timestamp, double? latitude, double? longitude, String? address
});




}
/// @nodoc
class _$LocationLogCopyWithImpl<$Res>
    implements $LocationLogCopyWith<$Res> {
  _$LocationLogCopyWithImpl(this._self, this._then);

  final LocationLog _self;
  final $Res Function(LocationLog) _then;

/// Create a copy of LocationLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dayKey = null,Object? type = null,Object? timestamp = null,Object? latitude = freezed,Object? longitude = freezed,Object? address = freezed,}) {
  return _then(_self.copyWith(
dayKey: null == dayKey ? _self.dayKey : dayKey // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LocationLogType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationLog].
extension LocationLogPatterns on LocationLog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationLog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationLog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationLog value)  $default,){
final _that = this;
switch (_that) {
case _LocationLog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationLog value)?  $default,){
final _that = this;
switch (_that) {
case _LocationLog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int dayKey,  LocationLogType type,  DateTime timestamp,  double? latitude,  double? longitude,  String? address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationLog() when $default != null:
return $default(_that.dayKey,_that.type,_that.timestamp,_that.latitude,_that.longitude,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int dayKey,  LocationLogType type,  DateTime timestamp,  double? latitude,  double? longitude,  String? address)  $default,) {final _that = this;
switch (_that) {
case _LocationLog():
return $default(_that.dayKey,_that.type,_that.timestamp,_that.latitude,_that.longitude,_that.address);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int dayKey,  LocationLogType type,  DateTime timestamp,  double? latitude,  double? longitude,  String? address)?  $default,) {final _that = this;
switch (_that) {
case _LocationLog() when $default != null:
return $default(_that.dayKey,_that.type,_that.timestamp,_that.latitude,_that.longitude,_that.address);case _:
  return null;

}
}

}

/// @nodoc


class _LocationLog implements LocationLog {
  const _LocationLog({required this.dayKey, required this.type, required this.timestamp, this.latitude, this.longitude, this.address});
  

@override final  int dayKey;
@override final  LocationLogType type;
@override final  DateTime timestamp;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? address;

/// Create a copy of LocationLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationLogCopyWith<_LocationLog> get copyWith => __$LocationLogCopyWithImpl<_LocationLog>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationLog&&(identical(other.dayKey, dayKey) || other.dayKey == dayKey)&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address));
}


@override
int get hashCode => Object.hash(runtimeType,dayKey,type,timestamp,latitude,longitude,address);

@override
String toString() {
  return 'LocationLog(dayKey: $dayKey, type: $type, timestamp: $timestamp, latitude: $latitude, longitude: $longitude, address: $address)';
}


}

/// @nodoc
abstract mixin class _$LocationLogCopyWith<$Res> implements $LocationLogCopyWith<$Res> {
  factory _$LocationLogCopyWith(_LocationLog value, $Res Function(_LocationLog) _then) = __$LocationLogCopyWithImpl;
@override @useResult
$Res call({
 int dayKey, LocationLogType type, DateTime timestamp, double? latitude, double? longitude, String? address
});




}
/// @nodoc
class __$LocationLogCopyWithImpl<$Res>
    implements _$LocationLogCopyWith<$Res> {
  __$LocationLogCopyWithImpl(this._self, this._then);

  final _LocationLog _self;
  final $Res Function(_LocationLog) _then;

/// Create a copy of LocationLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dayKey = null,Object? type = null,Object? timestamp = null,Object? latitude = freezed,Object? longitude = freezed,Object? address = freezed,}) {
  return _then(_LocationLog(
dayKey: null == dayKey ? _self.dayKey : dayKey // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LocationLogType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
