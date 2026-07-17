// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_reminder_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LeaveReminderSettings {

 bool get enabled; GeoPoint? get home; GeoPoint? get work; int? get lastCommuteMinutes; DateTime? get lastCommuteUpdatedAt; int get headsUpLeadMinutes; List<CommuteWaypoint> get waypoints; int get workRadiusMeters;
/// Create a copy of LeaveReminderSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveReminderSettingsCopyWith<LeaveReminderSettings> get copyWith => _$LeaveReminderSettingsCopyWithImpl<LeaveReminderSettings>(this as LeaveReminderSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveReminderSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.home, home) || other.home == home)&&(identical(other.work, work) || other.work == work)&&(identical(other.lastCommuteMinutes, lastCommuteMinutes) || other.lastCommuteMinutes == lastCommuteMinutes)&&(identical(other.lastCommuteUpdatedAt, lastCommuteUpdatedAt) || other.lastCommuteUpdatedAt == lastCommuteUpdatedAt)&&(identical(other.headsUpLeadMinutes, headsUpLeadMinutes) || other.headsUpLeadMinutes == headsUpLeadMinutes)&&const DeepCollectionEquality().equals(other.waypoints, waypoints)&&(identical(other.workRadiusMeters, workRadiusMeters) || other.workRadiusMeters == workRadiusMeters));
}


@override
int get hashCode => Object.hash(runtimeType,enabled,home,work,lastCommuteMinutes,lastCommuteUpdatedAt,headsUpLeadMinutes,const DeepCollectionEquality().hash(waypoints),workRadiusMeters);

@override
String toString() {
  return 'LeaveReminderSettings(enabled: $enabled, home: $home, work: $work, lastCommuteMinutes: $lastCommuteMinutes, lastCommuteUpdatedAt: $lastCommuteUpdatedAt, headsUpLeadMinutes: $headsUpLeadMinutes, waypoints: $waypoints, workRadiusMeters: $workRadiusMeters)';
}


}

/// @nodoc
abstract mixin class $LeaveReminderSettingsCopyWith<$Res>  {
  factory $LeaveReminderSettingsCopyWith(LeaveReminderSettings value, $Res Function(LeaveReminderSettings) _then) = _$LeaveReminderSettingsCopyWithImpl;
@useResult
$Res call({
 bool enabled, GeoPoint? home, GeoPoint? work, int? lastCommuteMinutes, DateTime? lastCommuteUpdatedAt, int headsUpLeadMinutes, List<CommuteWaypoint> waypoints, int workRadiusMeters
});


$GeoPointCopyWith<$Res>? get home;$GeoPointCopyWith<$Res>? get work;

}
/// @nodoc
class _$LeaveReminderSettingsCopyWithImpl<$Res>
    implements $LeaveReminderSettingsCopyWith<$Res> {
  _$LeaveReminderSettingsCopyWithImpl(this._self, this._then);

  final LeaveReminderSettings _self;
  final $Res Function(LeaveReminderSettings) _then;

/// Create a copy of LeaveReminderSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? home = freezed,Object? work = freezed,Object? lastCommuteMinutes = freezed,Object? lastCommuteUpdatedAt = freezed,Object? headsUpLeadMinutes = null,Object? waypoints = null,Object? workRadiusMeters = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,home: freezed == home ? _self.home : home // ignore: cast_nullable_to_non_nullable
as GeoPoint?,work: freezed == work ? _self.work : work // ignore: cast_nullable_to_non_nullable
as GeoPoint?,lastCommuteMinutes: freezed == lastCommuteMinutes ? _self.lastCommuteMinutes : lastCommuteMinutes // ignore: cast_nullable_to_non_nullable
as int?,lastCommuteUpdatedAt: freezed == lastCommuteUpdatedAt ? _self.lastCommuteUpdatedAt : lastCommuteUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,headsUpLeadMinutes: null == headsUpLeadMinutes ? _self.headsUpLeadMinutes : headsUpLeadMinutes // ignore: cast_nullable_to_non_nullable
as int,waypoints: null == waypoints ? _self.waypoints : waypoints // ignore: cast_nullable_to_non_nullable
as List<CommuteWaypoint>,workRadiusMeters: null == workRadiusMeters ? _self.workRadiusMeters : workRadiusMeters // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of LeaveReminderSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get home {
    if (_self.home == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.home!, (value) {
    return _then(_self.copyWith(home: value));
  });
}/// Create a copy of LeaveReminderSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get work {
    if (_self.work == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.work!, (value) {
    return _then(_self.copyWith(work: value));
  });
}
}


/// Adds pattern-matching-related methods to [LeaveReminderSettings].
extension LeaveReminderSettingsPatterns on LeaveReminderSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveReminderSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveReminderSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveReminderSettings value)  $default,){
final _that = this;
switch (_that) {
case _LeaveReminderSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveReminderSettings value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveReminderSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  GeoPoint? home,  GeoPoint? work,  int? lastCommuteMinutes,  DateTime? lastCommuteUpdatedAt,  int headsUpLeadMinutes,  List<CommuteWaypoint> waypoints,  int workRadiusMeters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveReminderSettings() when $default != null:
return $default(_that.enabled,_that.home,_that.work,_that.lastCommuteMinutes,_that.lastCommuteUpdatedAt,_that.headsUpLeadMinutes,_that.waypoints,_that.workRadiusMeters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  GeoPoint? home,  GeoPoint? work,  int? lastCommuteMinutes,  DateTime? lastCommuteUpdatedAt,  int headsUpLeadMinutes,  List<CommuteWaypoint> waypoints,  int workRadiusMeters)  $default,) {final _that = this;
switch (_that) {
case _LeaveReminderSettings():
return $default(_that.enabled,_that.home,_that.work,_that.lastCommuteMinutes,_that.lastCommuteUpdatedAt,_that.headsUpLeadMinutes,_that.waypoints,_that.workRadiusMeters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  GeoPoint? home,  GeoPoint? work,  int? lastCommuteMinutes,  DateTime? lastCommuteUpdatedAt,  int headsUpLeadMinutes,  List<CommuteWaypoint> waypoints,  int workRadiusMeters)?  $default,) {final _that = this;
switch (_that) {
case _LeaveReminderSettings() when $default != null:
return $default(_that.enabled,_that.home,_that.work,_that.lastCommuteMinutes,_that.lastCommuteUpdatedAt,_that.headsUpLeadMinutes,_that.waypoints,_that.workRadiusMeters);case _:
  return null;

}
}

}

/// @nodoc


class _LeaveReminderSettings implements LeaveReminderSettings {
  const _LeaveReminderSettings({this.enabled = false, this.home, this.work, this.lastCommuteMinutes, this.lastCommuteUpdatedAt, this.headsUpLeadMinutes = kDefaultHeadsUpLeadMinutes, final  List<CommuteWaypoint> waypoints = const <CommuteWaypoint>[], this.workRadiusMeters = 150}): _waypoints = waypoints;
  

@override@JsonKey() final  bool enabled;
@override final  GeoPoint? home;
@override final  GeoPoint? work;
@override final  int? lastCommuteMinutes;
@override final  DateTime? lastCommuteUpdatedAt;
@override@JsonKey() final  int headsUpLeadMinutes;
 final  List<CommuteWaypoint> _waypoints;
@override@JsonKey() List<CommuteWaypoint> get waypoints {
  if (_waypoints is EqualUnmodifiableListView) return _waypoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_waypoints);
}

@override@JsonKey() final  int workRadiusMeters;

/// Create a copy of LeaveReminderSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveReminderSettingsCopyWith<_LeaveReminderSettings> get copyWith => __$LeaveReminderSettingsCopyWithImpl<_LeaveReminderSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveReminderSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.home, home) || other.home == home)&&(identical(other.work, work) || other.work == work)&&(identical(other.lastCommuteMinutes, lastCommuteMinutes) || other.lastCommuteMinutes == lastCommuteMinutes)&&(identical(other.lastCommuteUpdatedAt, lastCommuteUpdatedAt) || other.lastCommuteUpdatedAt == lastCommuteUpdatedAt)&&(identical(other.headsUpLeadMinutes, headsUpLeadMinutes) || other.headsUpLeadMinutes == headsUpLeadMinutes)&&const DeepCollectionEquality().equals(other._waypoints, _waypoints)&&(identical(other.workRadiusMeters, workRadiusMeters) || other.workRadiusMeters == workRadiusMeters));
}


@override
int get hashCode => Object.hash(runtimeType,enabled,home,work,lastCommuteMinutes,lastCommuteUpdatedAt,headsUpLeadMinutes,const DeepCollectionEquality().hash(_waypoints),workRadiusMeters);

@override
String toString() {
  return 'LeaveReminderSettings(enabled: $enabled, home: $home, work: $work, lastCommuteMinutes: $lastCommuteMinutes, lastCommuteUpdatedAt: $lastCommuteUpdatedAt, headsUpLeadMinutes: $headsUpLeadMinutes, waypoints: $waypoints, workRadiusMeters: $workRadiusMeters)';
}


}

/// @nodoc
abstract mixin class _$LeaveReminderSettingsCopyWith<$Res> implements $LeaveReminderSettingsCopyWith<$Res> {
  factory _$LeaveReminderSettingsCopyWith(_LeaveReminderSettings value, $Res Function(_LeaveReminderSettings) _then) = __$LeaveReminderSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, GeoPoint? home, GeoPoint? work, int? lastCommuteMinutes, DateTime? lastCommuteUpdatedAt, int headsUpLeadMinutes, List<CommuteWaypoint> waypoints, int workRadiusMeters
});


@override $GeoPointCopyWith<$Res>? get home;@override $GeoPointCopyWith<$Res>? get work;

}
/// @nodoc
class __$LeaveReminderSettingsCopyWithImpl<$Res>
    implements _$LeaveReminderSettingsCopyWith<$Res> {
  __$LeaveReminderSettingsCopyWithImpl(this._self, this._then);

  final _LeaveReminderSettings _self;
  final $Res Function(_LeaveReminderSettings) _then;

/// Create a copy of LeaveReminderSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? home = freezed,Object? work = freezed,Object? lastCommuteMinutes = freezed,Object? lastCommuteUpdatedAt = freezed,Object? headsUpLeadMinutes = null,Object? waypoints = null,Object? workRadiusMeters = null,}) {
  return _then(_LeaveReminderSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,home: freezed == home ? _self.home : home // ignore: cast_nullable_to_non_nullable
as GeoPoint?,work: freezed == work ? _self.work : work // ignore: cast_nullable_to_non_nullable
as GeoPoint?,lastCommuteMinutes: freezed == lastCommuteMinutes ? _self.lastCommuteMinutes : lastCommuteMinutes // ignore: cast_nullable_to_non_nullable
as int?,lastCommuteUpdatedAt: freezed == lastCommuteUpdatedAt ? _self.lastCommuteUpdatedAt : lastCommuteUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,headsUpLeadMinutes: null == headsUpLeadMinutes ? _self.headsUpLeadMinutes : headsUpLeadMinutes // ignore: cast_nullable_to_non_nullable
as int,waypoints: null == waypoints ? _self._waypoints : waypoints // ignore: cast_nullable_to_non_nullable
as List<CommuteWaypoint>,workRadiusMeters: null == workRadiusMeters ? _self.workRadiusMeters : workRadiusMeters // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of LeaveReminderSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get home {
    if (_self.home == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.home!, (value) {
    return _then(_self.copyWith(home: value));
  });
}/// Create a copy of LeaveReminderSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get work {
    if (_self.work == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.work!, (value) {
    return _then(_self.copyWith(work: value));
  });
}
}

// dart format on
