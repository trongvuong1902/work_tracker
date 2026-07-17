// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'commute_waypoint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommuteWaypoint {

 GeoPoint get location; bool get enabled;
/// Create a copy of CommuteWaypoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommuteWaypointCopyWith<CommuteWaypoint> get copyWith => _$CommuteWaypointCopyWithImpl<CommuteWaypoint>(this as CommuteWaypoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommuteWaypoint&&(identical(other.location, location) || other.location == location)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,location,enabled);

@override
String toString() {
  return 'CommuteWaypoint(location: $location, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $CommuteWaypointCopyWith<$Res>  {
  factory $CommuteWaypointCopyWith(CommuteWaypoint value, $Res Function(CommuteWaypoint) _then) = _$CommuteWaypointCopyWithImpl;
@useResult
$Res call({
 GeoPoint location, bool enabled
});


$GeoPointCopyWith<$Res> get location;

}
/// @nodoc
class _$CommuteWaypointCopyWithImpl<$Res>
    implements $CommuteWaypointCopyWith<$Res> {
  _$CommuteWaypointCopyWithImpl(this._self, this._then);

  final CommuteWaypoint _self;
  final $Res Function(CommuteWaypoint) _then;

/// Create a copy of CommuteWaypoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? location = null,Object? enabled = null,}) {
  return _then(_self.copyWith(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of CommuteWaypoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get location {
  
  return $GeoPointCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommuteWaypoint].
extension CommuteWaypointPatterns on CommuteWaypoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommuteWaypoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommuteWaypoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommuteWaypoint value)  $default,){
final _that = this;
switch (_that) {
case _CommuteWaypoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommuteWaypoint value)?  $default,){
final _that = this;
switch (_that) {
case _CommuteWaypoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GeoPoint location,  bool enabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommuteWaypoint() when $default != null:
return $default(_that.location,_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GeoPoint location,  bool enabled)  $default,) {final _that = this;
switch (_that) {
case _CommuteWaypoint():
return $default(_that.location,_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GeoPoint location,  bool enabled)?  $default,) {final _that = this;
switch (_that) {
case _CommuteWaypoint() when $default != null:
return $default(_that.location,_that.enabled);case _:
  return null;

}
}

}

/// @nodoc


class _CommuteWaypoint implements CommuteWaypoint {
  const _CommuteWaypoint({required this.location, this.enabled = true});
  

@override final  GeoPoint location;
@override@JsonKey() final  bool enabled;

/// Create a copy of CommuteWaypoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommuteWaypointCopyWith<_CommuteWaypoint> get copyWith => __$CommuteWaypointCopyWithImpl<_CommuteWaypoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommuteWaypoint&&(identical(other.location, location) || other.location == location)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,location,enabled);

@override
String toString() {
  return 'CommuteWaypoint(location: $location, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$CommuteWaypointCopyWith<$Res> implements $CommuteWaypointCopyWith<$Res> {
  factory _$CommuteWaypointCopyWith(_CommuteWaypoint value, $Res Function(_CommuteWaypoint) _then) = __$CommuteWaypointCopyWithImpl;
@override @useResult
$Res call({
 GeoPoint location, bool enabled
});


@override $GeoPointCopyWith<$Res> get location;

}
/// @nodoc
class __$CommuteWaypointCopyWithImpl<$Res>
    implements _$CommuteWaypointCopyWith<$Res> {
  __$CommuteWaypointCopyWithImpl(this._self, this._then);

  final _CommuteWaypoint _self;
  final $Res Function(_CommuteWaypoint) _then;

/// Create a copy of CommuteWaypoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? location = null,Object? enabled = null,}) {
  return _then(_CommuteWaypoint(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of CommuteWaypoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get location {
  
  return $GeoPointCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

// dart format on
