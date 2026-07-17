// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_activity_day_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationActivityDayState {

 bool get isLoading; List<LocationLog> get events; Map<LocationLog, LocationLogBadgeTier> get badges;
/// Create a copy of LocationActivityDayState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationActivityDayStateCopyWith<LocationActivityDayState> get copyWith => _$LocationActivityDayStateCopyWithImpl<LocationActivityDayState>(this as LocationActivityDayState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationActivityDayState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.events, events)&&const DeepCollectionEquality().equals(other.badges, badges));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(events),const DeepCollectionEquality().hash(badges));

@override
String toString() {
  return 'LocationActivityDayState(isLoading: $isLoading, events: $events, badges: $badges)';
}


}

/// @nodoc
abstract mixin class $LocationActivityDayStateCopyWith<$Res>  {
  factory $LocationActivityDayStateCopyWith(LocationActivityDayState value, $Res Function(LocationActivityDayState) _then) = _$LocationActivityDayStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<LocationLog> events, Map<LocationLog, LocationLogBadgeTier> badges
});




}
/// @nodoc
class _$LocationActivityDayStateCopyWithImpl<$Res>
    implements $LocationActivityDayStateCopyWith<$Res> {
  _$LocationActivityDayStateCopyWithImpl(this._self, this._then);

  final LocationActivityDayState _self;
  final $Res Function(LocationActivityDayState) _then;

/// Create a copy of LocationActivityDayState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? events = null,Object? badges = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<LocationLog>,badges: null == badges ? _self.badges : badges // ignore: cast_nullable_to_non_nullable
as Map<LocationLog, LocationLogBadgeTier>,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationActivityDayState].
extension LocationActivityDayStatePatterns on LocationActivityDayState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationActivityDayState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationActivityDayState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationActivityDayState value)  $default,){
final _that = this;
switch (_that) {
case _LocationActivityDayState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationActivityDayState value)?  $default,){
final _that = this;
switch (_that) {
case _LocationActivityDayState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<LocationLog> events,  Map<LocationLog, LocationLogBadgeTier> badges)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationActivityDayState() when $default != null:
return $default(_that.isLoading,_that.events,_that.badges);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<LocationLog> events,  Map<LocationLog, LocationLogBadgeTier> badges)  $default,) {final _that = this;
switch (_that) {
case _LocationActivityDayState():
return $default(_that.isLoading,_that.events,_that.badges);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<LocationLog> events,  Map<LocationLog, LocationLogBadgeTier> badges)?  $default,) {final _that = this;
switch (_that) {
case _LocationActivityDayState() when $default != null:
return $default(_that.isLoading,_that.events,_that.badges);case _:
  return null;

}
}

}

/// @nodoc


class _LocationActivityDayState implements LocationActivityDayState {
  const _LocationActivityDayState({this.isLoading = true, final  List<LocationLog> events = const <LocationLog>[], final  Map<LocationLog, LocationLogBadgeTier> badges = const <LocationLog, LocationLogBadgeTier>{}}): _events = events,_badges = badges;
  

@override@JsonKey() final  bool isLoading;
 final  List<LocationLog> _events;
@override@JsonKey() List<LocationLog> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

 final  Map<LocationLog, LocationLogBadgeTier> _badges;
@override@JsonKey() Map<LocationLog, LocationLogBadgeTier> get badges {
  if (_badges is EqualUnmodifiableMapView) return _badges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_badges);
}


/// Create a copy of LocationActivityDayState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationActivityDayStateCopyWith<_LocationActivityDayState> get copyWith => __$LocationActivityDayStateCopyWithImpl<_LocationActivityDayState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationActivityDayState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._events, _events)&&const DeepCollectionEquality().equals(other._badges, _badges));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_events),const DeepCollectionEquality().hash(_badges));

@override
String toString() {
  return 'LocationActivityDayState(isLoading: $isLoading, events: $events, badges: $badges)';
}


}

/// @nodoc
abstract mixin class _$LocationActivityDayStateCopyWith<$Res> implements $LocationActivityDayStateCopyWith<$Res> {
  factory _$LocationActivityDayStateCopyWith(_LocationActivityDayState value, $Res Function(_LocationActivityDayState) _then) = __$LocationActivityDayStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<LocationLog> events, Map<LocationLog, LocationLogBadgeTier> badges
});




}
/// @nodoc
class __$LocationActivityDayStateCopyWithImpl<$Res>
    implements _$LocationActivityDayStateCopyWith<$Res> {
  __$LocationActivityDayStateCopyWithImpl(this._self, this._then);

  final _LocationActivityDayState _self;
  final $Res Function(_LocationActivityDayState) _then;

/// Create a copy of LocationActivityDayState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? events = null,Object? badges = null,}) {
  return _then(_LocationActivityDayState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<LocationLog>,badges: null == badges ? _self._badges : badges // ignore: cast_nullable_to_non_nullable
as Map<LocationLog, LocationLogBadgeTier>,
  ));
}


}

// dart format on
