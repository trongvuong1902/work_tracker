// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setting_schedule_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingScheduleState {

 int get startMinuteOfDay; int get endMinuteOfDay; int get lunchMinutes; int get reminderMinutes; int get workingDaysMask; bool get isLoading; bool get isSaving; bool get isEditing; String? get errorMessage;
/// Create a copy of SettingScheduleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingScheduleStateCopyWith<SettingScheduleState> get copyWith => _$SettingScheduleStateCopyWithImpl<SettingScheduleState>(this as SettingScheduleState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingScheduleState&&(identical(other.startMinuteOfDay, startMinuteOfDay) || other.startMinuteOfDay == startMinuteOfDay)&&(identical(other.endMinuteOfDay, endMinuteOfDay) || other.endMinuteOfDay == endMinuteOfDay)&&(identical(other.lunchMinutes, lunchMinutes) || other.lunchMinutes == lunchMinutes)&&(identical(other.reminderMinutes, reminderMinutes) || other.reminderMinutes == reminderMinutes)&&(identical(other.workingDaysMask, workingDaysMask) || other.workingDaysMask == workingDaysMask)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isEditing, isEditing) || other.isEditing == isEditing)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,startMinuteOfDay,endMinuteOfDay,lunchMinutes,reminderMinutes,workingDaysMask,isLoading,isSaving,isEditing,errorMessage);

@override
String toString() {
  return 'SettingScheduleState(startMinuteOfDay: $startMinuteOfDay, endMinuteOfDay: $endMinuteOfDay, lunchMinutes: $lunchMinutes, reminderMinutes: $reminderMinutes, workingDaysMask: $workingDaysMask, isLoading: $isLoading, isSaving: $isSaving, isEditing: $isEditing, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $SettingScheduleStateCopyWith<$Res>  {
  factory $SettingScheduleStateCopyWith(SettingScheduleState value, $Res Function(SettingScheduleState) _then) = _$SettingScheduleStateCopyWithImpl;
@useResult
$Res call({
 int startMinuteOfDay, int endMinuteOfDay, int lunchMinutes, int reminderMinutes, int workingDaysMask, bool isLoading, bool isSaving, bool isEditing, String? errorMessage
});




}
/// @nodoc
class _$SettingScheduleStateCopyWithImpl<$Res>
    implements $SettingScheduleStateCopyWith<$Res> {
  _$SettingScheduleStateCopyWithImpl(this._self, this._then);

  final SettingScheduleState _self;
  final $Res Function(SettingScheduleState) _then;

/// Create a copy of SettingScheduleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startMinuteOfDay = null,Object? endMinuteOfDay = null,Object? lunchMinutes = null,Object? reminderMinutes = null,Object? workingDaysMask = null,Object? isLoading = null,Object? isSaving = null,Object? isEditing = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
startMinuteOfDay: null == startMinuteOfDay ? _self.startMinuteOfDay : startMinuteOfDay // ignore: cast_nullable_to_non_nullable
as int,endMinuteOfDay: null == endMinuteOfDay ? _self.endMinuteOfDay : endMinuteOfDay // ignore: cast_nullable_to_non_nullable
as int,lunchMinutes: null == lunchMinutes ? _self.lunchMinutes : lunchMinutes // ignore: cast_nullable_to_non_nullable
as int,reminderMinutes: null == reminderMinutes ? _self.reminderMinutes : reminderMinutes // ignore: cast_nullable_to_non_nullable
as int,workingDaysMask: null == workingDaysMask ? _self.workingDaysMask : workingDaysMask // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isEditing: null == isEditing ? _self.isEditing : isEditing // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingScheduleState].
extension SettingScheduleStatePatterns on SettingScheduleState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingScheduleState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingScheduleState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingScheduleState value)  $default,){
final _that = this;
switch (_that) {
case _SettingScheduleState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingScheduleState value)?  $default,){
final _that = this;
switch (_that) {
case _SettingScheduleState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int startMinuteOfDay,  int endMinuteOfDay,  int lunchMinutes,  int reminderMinutes,  int workingDaysMask,  bool isLoading,  bool isSaving,  bool isEditing,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingScheduleState() when $default != null:
return $default(_that.startMinuteOfDay,_that.endMinuteOfDay,_that.lunchMinutes,_that.reminderMinutes,_that.workingDaysMask,_that.isLoading,_that.isSaving,_that.isEditing,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int startMinuteOfDay,  int endMinuteOfDay,  int lunchMinutes,  int reminderMinutes,  int workingDaysMask,  bool isLoading,  bool isSaving,  bool isEditing,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _SettingScheduleState():
return $default(_that.startMinuteOfDay,_that.endMinuteOfDay,_that.lunchMinutes,_that.reminderMinutes,_that.workingDaysMask,_that.isLoading,_that.isSaving,_that.isEditing,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int startMinuteOfDay,  int endMinuteOfDay,  int lunchMinutes,  int reminderMinutes,  int workingDaysMask,  bool isLoading,  bool isSaving,  bool isEditing,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _SettingScheduleState() when $default != null:
return $default(_that.startMinuteOfDay,_that.endMinuteOfDay,_that.lunchMinutes,_that.reminderMinutes,_that.workingDaysMask,_that.isLoading,_that.isSaving,_that.isEditing,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SettingScheduleState implements SettingScheduleState {
  const _SettingScheduleState({this.startMinuteOfDay = 540, this.endMinuteOfDay = 1080, this.lunchMinutes = 60, this.reminderMinutes = 0, this.workingDaysMask = kDefaultWorkingDaysMask, this.isLoading = false, this.isSaving = false, this.isEditing = false, this.errorMessage});
  

@override@JsonKey() final  int startMinuteOfDay;
@override@JsonKey() final  int endMinuteOfDay;
@override@JsonKey() final  int lunchMinutes;
@override@JsonKey() final  int reminderMinutes;
@override@JsonKey() final  int workingDaysMask;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isEditing;
@override final  String? errorMessage;

/// Create a copy of SettingScheduleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingScheduleStateCopyWith<_SettingScheduleState> get copyWith => __$SettingScheduleStateCopyWithImpl<_SettingScheduleState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingScheduleState&&(identical(other.startMinuteOfDay, startMinuteOfDay) || other.startMinuteOfDay == startMinuteOfDay)&&(identical(other.endMinuteOfDay, endMinuteOfDay) || other.endMinuteOfDay == endMinuteOfDay)&&(identical(other.lunchMinutes, lunchMinutes) || other.lunchMinutes == lunchMinutes)&&(identical(other.reminderMinutes, reminderMinutes) || other.reminderMinutes == reminderMinutes)&&(identical(other.workingDaysMask, workingDaysMask) || other.workingDaysMask == workingDaysMask)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isEditing, isEditing) || other.isEditing == isEditing)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,startMinuteOfDay,endMinuteOfDay,lunchMinutes,reminderMinutes,workingDaysMask,isLoading,isSaving,isEditing,errorMessage);

@override
String toString() {
  return 'SettingScheduleState(startMinuteOfDay: $startMinuteOfDay, endMinuteOfDay: $endMinuteOfDay, lunchMinutes: $lunchMinutes, reminderMinutes: $reminderMinutes, workingDaysMask: $workingDaysMask, isLoading: $isLoading, isSaving: $isSaving, isEditing: $isEditing, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$SettingScheduleStateCopyWith<$Res> implements $SettingScheduleStateCopyWith<$Res> {
  factory _$SettingScheduleStateCopyWith(_SettingScheduleState value, $Res Function(_SettingScheduleState) _then) = __$SettingScheduleStateCopyWithImpl;
@override @useResult
$Res call({
 int startMinuteOfDay, int endMinuteOfDay, int lunchMinutes, int reminderMinutes, int workingDaysMask, bool isLoading, bool isSaving, bool isEditing, String? errorMessage
});




}
/// @nodoc
class __$SettingScheduleStateCopyWithImpl<$Res>
    implements _$SettingScheduleStateCopyWith<$Res> {
  __$SettingScheduleStateCopyWithImpl(this._self, this._then);

  final _SettingScheduleState _self;
  final $Res Function(_SettingScheduleState) _then;

/// Create a copy of SettingScheduleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startMinuteOfDay = null,Object? endMinuteOfDay = null,Object? lunchMinutes = null,Object? reminderMinutes = null,Object? workingDaysMask = null,Object? isLoading = null,Object? isSaving = null,Object? isEditing = null,Object? errorMessage = freezed,}) {
  return _then(_SettingScheduleState(
startMinuteOfDay: null == startMinuteOfDay ? _self.startMinuteOfDay : startMinuteOfDay // ignore: cast_nullable_to_non_nullable
as int,endMinuteOfDay: null == endMinuteOfDay ? _self.endMinuteOfDay : endMinuteOfDay // ignore: cast_nullable_to_non_nullable
as int,lunchMinutes: null == lunchMinutes ? _self.lunchMinutes : lunchMinutes // ignore: cast_nullable_to_non_nullable
as int,reminderMinutes: null == reminderMinutes ? _self.reminderMinutes : reminderMinutes // ignore: cast_nullable_to_non_nullable
as int,workingDaysMask: null == workingDaysMask ? _self.workingDaysMask : workingDaysMask // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isEditing: null == isEditing ? _self.isEditing : isEditing // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
