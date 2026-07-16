// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_reminder_setup_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LeaveReminderSetupState {

 bool get isLoading; bool get enabled; GeoPoint? get home; GeoPoint? get work; int? get lastCommuteMinutes; DateTime? get lastCommuteUpdatedAt; int? get averageCommuteMinutes; bool get isSettingHome; bool get isSettingWork; bool get isRefreshingCommute; bool get isTogglingEnabled; String? get errorMessage; int get headsUpLeadMinutes; WorkSchedule? get schedule;
/// Create a copy of LeaveReminderSetupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveReminderSetupStateCopyWith<LeaveReminderSetupState> get copyWith => _$LeaveReminderSetupStateCopyWithImpl<LeaveReminderSetupState>(this as LeaveReminderSetupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveReminderSetupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.home, home) || other.home == home)&&(identical(other.work, work) || other.work == work)&&(identical(other.lastCommuteMinutes, lastCommuteMinutes) || other.lastCommuteMinutes == lastCommuteMinutes)&&(identical(other.lastCommuteUpdatedAt, lastCommuteUpdatedAt) || other.lastCommuteUpdatedAt == lastCommuteUpdatedAt)&&(identical(other.averageCommuteMinutes, averageCommuteMinutes) || other.averageCommuteMinutes == averageCommuteMinutes)&&(identical(other.isSettingHome, isSettingHome) || other.isSettingHome == isSettingHome)&&(identical(other.isSettingWork, isSettingWork) || other.isSettingWork == isSettingWork)&&(identical(other.isRefreshingCommute, isRefreshingCommute) || other.isRefreshingCommute == isRefreshingCommute)&&(identical(other.isTogglingEnabled, isTogglingEnabled) || other.isTogglingEnabled == isTogglingEnabled)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.headsUpLeadMinutes, headsUpLeadMinutes) || other.headsUpLeadMinutes == headsUpLeadMinutes)&&(identical(other.schedule, schedule) || other.schedule == schedule));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,enabled,home,work,lastCommuteMinutes,lastCommuteUpdatedAt,averageCommuteMinutes,isSettingHome,isSettingWork,isRefreshingCommute,isTogglingEnabled,errorMessage,headsUpLeadMinutes,schedule);

@override
String toString() {
  return 'LeaveReminderSetupState(isLoading: $isLoading, enabled: $enabled, home: $home, work: $work, lastCommuteMinutes: $lastCommuteMinutes, lastCommuteUpdatedAt: $lastCommuteUpdatedAt, averageCommuteMinutes: $averageCommuteMinutes, isSettingHome: $isSettingHome, isSettingWork: $isSettingWork, isRefreshingCommute: $isRefreshingCommute, isTogglingEnabled: $isTogglingEnabled, errorMessage: $errorMessage, headsUpLeadMinutes: $headsUpLeadMinutes, schedule: $schedule)';
}


}

/// @nodoc
abstract mixin class $LeaveReminderSetupStateCopyWith<$Res>  {
  factory $LeaveReminderSetupStateCopyWith(LeaveReminderSetupState value, $Res Function(LeaveReminderSetupState) _then) = _$LeaveReminderSetupStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool enabled, GeoPoint? home, GeoPoint? work, int? lastCommuteMinutes, DateTime? lastCommuteUpdatedAt, int? averageCommuteMinutes, bool isSettingHome, bool isSettingWork, bool isRefreshingCommute, bool isTogglingEnabled, String? errorMessage, int headsUpLeadMinutes, WorkSchedule? schedule
});


$GeoPointCopyWith<$Res>? get home;$GeoPointCopyWith<$Res>? get work;$WorkScheduleCopyWith<$Res>? get schedule;

}
/// @nodoc
class _$LeaveReminderSetupStateCopyWithImpl<$Res>
    implements $LeaveReminderSetupStateCopyWith<$Res> {
  _$LeaveReminderSetupStateCopyWithImpl(this._self, this._then);

  final LeaveReminderSetupState _self;
  final $Res Function(LeaveReminderSetupState) _then;

/// Create a copy of LeaveReminderSetupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? enabled = null,Object? home = freezed,Object? work = freezed,Object? lastCommuteMinutes = freezed,Object? lastCommuteUpdatedAt = freezed,Object? averageCommuteMinutes = freezed,Object? isSettingHome = null,Object? isSettingWork = null,Object? isRefreshingCommute = null,Object? isTogglingEnabled = null,Object? errorMessage = freezed,Object? headsUpLeadMinutes = null,Object? schedule = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,home: freezed == home ? _self.home : home // ignore: cast_nullable_to_non_nullable
as GeoPoint?,work: freezed == work ? _self.work : work // ignore: cast_nullable_to_non_nullable
as GeoPoint?,lastCommuteMinutes: freezed == lastCommuteMinutes ? _self.lastCommuteMinutes : lastCommuteMinutes // ignore: cast_nullable_to_non_nullable
as int?,lastCommuteUpdatedAt: freezed == lastCommuteUpdatedAt ? _self.lastCommuteUpdatedAt : lastCommuteUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,averageCommuteMinutes: freezed == averageCommuteMinutes ? _self.averageCommuteMinutes : averageCommuteMinutes // ignore: cast_nullable_to_non_nullable
as int?,isSettingHome: null == isSettingHome ? _self.isSettingHome : isSettingHome // ignore: cast_nullable_to_non_nullable
as bool,isSettingWork: null == isSettingWork ? _self.isSettingWork : isSettingWork // ignore: cast_nullable_to_non_nullable
as bool,isRefreshingCommute: null == isRefreshingCommute ? _self.isRefreshingCommute : isRefreshingCommute // ignore: cast_nullable_to_non_nullable
as bool,isTogglingEnabled: null == isTogglingEnabled ? _self.isTogglingEnabled : isTogglingEnabled // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,headsUpLeadMinutes: null == headsUpLeadMinutes ? _self.headsUpLeadMinutes : headsUpLeadMinutes // ignore: cast_nullable_to_non_nullable
as int,schedule: freezed == schedule ? _self.schedule : schedule // ignore: cast_nullable_to_non_nullable
as WorkSchedule?,
  ));
}
/// Create a copy of LeaveReminderSetupState
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
}/// Create a copy of LeaveReminderSetupState
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
}/// Create a copy of LeaveReminderSetupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkScheduleCopyWith<$Res>? get schedule {
    if (_self.schedule == null) {
    return null;
  }

  return $WorkScheduleCopyWith<$Res>(_self.schedule!, (value) {
    return _then(_self.copyWith(schedule: value));
  });
}
}


/// Adds pattern-matching-related methods to [LeaveReminderSetupState].
extension LeaveReminderSetupStatePatterns on LeaveReminderSetupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveReminderSetupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveReminderSetupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveReminderSetupState value)  $default,){
final _that = this;
switch (_that) {
case _LeaveReminderSetupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveReminderSetupState value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveReminderSetupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool enabled,  GeoPoint? home,  GeoPoint? work,  int? lastCommuteMinutes,  DateTime? lastCommuteUpdatedAt,  int? averageCommuteMinutes,  bool isSettingHome,  bool isSettingWork,  bool isRefreshingCommute,  bool isTogglingEnabled,  String? errorMessage,  int headsUpLeadMinutes,  WorkSchedule? schedule)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveReminderSetupState() when $default != null:
return $default(_that.isLoading,_that.enabled,_that.home,_that.work,_that.lastCommuteMinutes,_that.lastCommuteUpdatedAt,_that.averageCommuteMinutes,_that.isSettingHome,_that.isSettingWork,_that.isRefreshingCommute,_that.isTogglingEnabled,_that.errorMessage,_that.headsUpLeadMinutes,_that.schedule);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool enabled,  GeoPoint? home,  GeoPoint? work,  int? lastCommuteMinutes,  DateTime? lastCommuteUpdatedAt,  int? averageCommuteMinutes,  bool isSettingHome,  bool isSettingWork,  bool isRefreshingCommute,  bool isTogglingEnabled,  String? errorMessage,  int headsUpLeadMinutes,  WorkSchedule? schedule)  $default,) {final _that = this;
switch (_that) {
case _LeaveReminderSetupState():
return $default(_that.isLoading,_that.enabled,_that.home,_that.work,_that.lastCommuteMinutes,_that.lastCommuteUpdatedAt,_that.averageCommuteMinutes,_that.isSettingHome,_that.isSettingWork,_that.isRefreshingCommute,_that.isTogglingEnabled,_that.errorMessage,_that.headsUpLeadMinutes,_that.schedule);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool enabled,  GeoPoint? home,  GeoPoint? work,  int? lastCommuteMinutes,  DateTime? lastCommuteUpdatedAt,  int? averageCommuteMinutes,  bool isSettingHome,  bool isSettingWork,  bool isRefreshingCommute,  bool isTogglingEnabled,  String? errorMessage,  int headsUpLeadMinutes,  WorkSchedule? schedule)?  $default,) {final _that = this;
switch (_that) {
case _LeaveReminderSetupState() when $default != null:
return $default(_that.isLoading,_that.enabled,_that.home,_that.work,_that.lastCommuteMinutes,_that.lastCommuteUpdatedAt,_that.averageCommuteMinutes,_that.isSettingHome,_that.isSettingWork,_that.isRefreshingCommute,_that.isTogglingEnabled,_that.errorMessage,_that.headsUpLeadMinutes,_that.schedule);case _:
  return null;

}
}

}

/// @nodoc


class _LeaveReminderSetupState implements LeaveReminderSetupState {
  const _LeaveReminderSetupState({this.isLoading = true, this.enabled = false, this.home, this.work, this.lastCommuteMinutes, this.lastCommuteUpdatedAt, this.averageCommuteMinutes, this.isSettingHome = false, this.isSettingWork = false, this.isRefreshingCommute = false, this.isTogglingEnabled = false, this.errorMessage, this.headsUpLeadMinutes = kDefaultHeadsUpLeadMinutes, this.schedule});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool enabled;
@override final  GeoPoint? home;
@override final  GeoPoint? work;
@override final  int? lastCommuteMinutes;
@override final  DateTime? lastCommuteUpdatedAt;
@override final  int? averageCommuteMinutes;
@override@JsonKey() final  bool isSettingHome;
@override@JsonKey() final  bool isSettingWork;
@override@JsonKey() final  bool isRefreshingCommute;
@override@JsonKey() final  bool isTogglingEnabled;
@override final  String? errorMessage;
@override@JsonKey() final  int headsUpLeadMinutes;
@override final  WorkSchedule? schedule;

/// Create a copy of LeaveReminderSetupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveReminderSetupStateCopyWith<_LeaveReminderSetupState> get copyWith => __$LeaveReminderSetupStateCopyWithImpl<_LeaveReminderSetupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveReminderSetupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.home, home) || other.home == home)&&(identical(other.work, work) || other.work == work)&&(identical(other.lastCommuteMinutes, lastCommuteMinutes) || other.lastCommuteMinutes == lastCommuteMinutes)&&(identical(other.lastCommuteUpdatedAt, lastCommuteUpdatedAt) || other.lastCommuteUpdatedAt == lastCommuteUpdatedAt)&&(identical(other.averageCommuteMinutes, averageCommuteMinutes) || other.averageCommuteMinutes == averageCommuteMinutes)&&(identical(other.isSettingHome, isSettingHome) || other.isSettingHome == isSettingHome)&&(identical(other.isSettingWork, isSettingWork) || other.isSettingWork == isSettingWork)&&(identical(other.isRefreshingCommute, isRefreshingCommute) || other.isRefreshingCommute == isRefreshingCommute)&&(identical(other.isTogglingEnabled, isTogglingEnabled) || other.isTogglingEnabled == isTogglingEnabled)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.headsUpLeadMinutes, headsUpLeadMinutes) || other.headsUpLeadMinutes == headsUpLeadMinutes)&&(identical(other.schedule, schedule) || other.schedule == schedule));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,enabled,home,work,lastCommuteMinutes,lastCommuteUpdatedAt,averageCommuteMinutes,isSettingHome,isSettingWork,isRefreshingCommute,isTogglingEnabled,errorMessage,headsUpLeadMinutes,schedule);

@override
String toString() {
  return 'LeaveReminderSetupState(isLoading: $isLoading, enabled: $enabled, home: $home, work: $work, lastCommuteMinutes: $lastCommuteMinutes, lastCommuteUpdatedAt: $lastCommuteUpdatedAt, averageCommuteMinutes: $averageCommuteMinutes, isSettingHome: $isSettingHome, isSettingWork: $isSettingWork, isRefreshingCommute: $isRefreshingCommute, isTogglingEnabled: $isTogglingEnabled, errorMessage: $errorMessage, headsUpLeadMinutes: $headsUpLeadMinutes, schedule: $schedule)';
}


}

/// @nodoc
abstract mixin class _$LeaveReminderSetupStateCopyWith<$Res> implements $LeaveReminderSetupStateCopyWith<$Res> {
  factory _$LeaveReminderSetupStateCopyWith(_LeaveReminderSetupState value, $Res Function(_LeaveReminderSetupState) _then) = __$LeaveReminderSetupStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool enabled, GeoPoint? home, GeoPoint? work, int? lastCommuteMinutes, DateTime? lastCommuteUpdatedAt, int? averageCommuteMinutes, bool isSettingHome, bool isSettingWork, bool isRefreshingCommute, bool isTogglingEnabled, String? errorMessage, int headsUpLeadMinutes, WorkSchedule? schedule
});


@override $GeoPointCopyWith<$Res>? get home;@override $GeoPointCopyWith<$Res>? get work;@override $WorkScheduleCopyWith<$Res>? get schedule;

}
/// @nodoc
class __$LeaveReminderSetupStateCopyWithImpl<$Res>
    implements _$LeaveReminderSetupStateCopyWith<$Res> {
  __$LeaveReminderSetupStateCopyWithImpl(this._self, this._then);

  final _LeaveReminderSetupState _self;
  final $Res Function(_LeaveReminderSetupState) _then;

/// Create a copy of LeaveReminderSetupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? enabled = null,Object? home = freezed,Object? work = freezed,Object? lastCommuteMinutes = freezed,Object? lastCommuteUpdatedAt = freezed,Object? averageCommuteMinutes = freezed,Object? isSettingHome = null,Object? isSettingWork = null,Object? isRefreshingCommute = null,Object? isTogglingEnabled = null,Object? errorMessage = freezed,Object? headsUpLeadMinutes = null,Object? schedule = freezed,}) {
  return _then(_LeaveReminderSetupState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,home: freezed == home ? _self.home : home // ignore: cast_nullable_to_non_nullable
as GeoPoint?,work: freezed == work ? _self.work : work // ignore: cast_nullable_to_non_nullable
as GeoPoint?,lastCommuteMinutes: freezed == lastCommuteMinutes ? _self.lastCommuteMinutes : lastCommuteMinutes // ignore: cast_nullable_to_non_nullable
as int?,lastCommuteUpdatedAt: freezed == lastCommuteUpdatedAt ? _self.lastCommuteUpdatedAt : lastCommuteUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,averageCommuteMinutes: freezed == averageCommuteMinutes ? _self.averageCommuteMinutes : averageCommuteMinutes // ignore: cast_nullable_to_non_nullable
as int?,isSettingHome: null == isSettingHome ? _self.isSettingHome : isSettingHome // ignore: cast_nullable_to_non_nullable
as bool,isSettingWork: null == isSettingWork ? _self.isSettingWork : isSettingWork // ignore: cast_nullable_to_non_nullable
as bool,isRefreshingCommute: null == isRefreshingCommute ? _self.isRefreshingCommute : isRefreshingCommute // ignore: cast_nullable_to_non_nullable
as bool,isTogglingEnabled: null == isTogglingEnabled ? _self.isTogglingEnabled : isTogglingEnabled // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,headsUpLeadMinutes: null == headsUpLeadMinutes ? _self.headsUpLeadMinutes : headsUpLeadMinutes // ignore: cast_nullable_to_non_nullable
as int,schedule: freezed == schedule ? _self.schedule : schedule // ignore: cast_nullable_to_non_nullable
as WorkSchedule?,
  ));
}

/// Create a copy of LeaveReminderSetupState
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
}/// Create a copy of LeaveReminderSetupState
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
}/// Create a copy of LeaveReminderSetupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkScheduleCopyWith<$Res>? get schedule {
    if (_self.schedule == null) {
    return null;
  }

  return $WorkScheduleCopyWith<$Res>(_self.schedule!, (value) {
    return _then(_self.copyWith(schedule: value));
  });
}
}

// dart format on
