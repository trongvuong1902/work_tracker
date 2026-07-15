// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkSchedule {

 int get startMinuteOfDay;// 540 (09:00)
 int get endMinuteOfDay;// 1080 (18:00)
 int get lunchMinutes; int get lunchStartMinuteOfDay;// 720 (12:00)
 int get reminderMinutes; int? get workingDaysMask;
/// Create a copy of WorkSchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkScheduleCopyWith<WorkSchedule> get copyWith => _$WorkScheduleCopyWithImpl<WorkSchedule>(this as WorkSchedule, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkSchedule&&(identical(other.startMinuteOfDay, startMinuteOfDay) || other.startMinuteOfDay == startMinuteOfDay)&&(identical(other.endMinuteOfDay, endMinuteOfDay) || other.endMinuteOfDay == endMinuteOfDay)&&(identical(other.lunchMinutes, lunchMinutes) || other.lunchMinutes == lunchMinutes)&&(identical(other.lunchStartMinuteOfDay, lunchStartMinuteOfDay) || other.lunchStartMinuteOfDay == lunchStartMinuteOfDay)&&(identical(other.reminderMinutes, reminderMinutes) || other.reminderMinutes == reminderMinutes)&&(identical(other.workingDaysMask, workingDaysMask) || other.workingDaysMask == workingDaysMask));
}


@override
int get hashCode => Object.hash(runtimeType,startMinuteOfDay,endMinuteOfDay,lunchMinutes,lunchStartMinuteOfDay,reminderMinutes,workingDaysMask);

@override
String toString() {
  return 'WorkSchedule(startMinuteOfDay: $startMinuteOfDay, endMinuteOfDay: $endMinuteOfDay, lunchMinutes: $lunchMinutes, lunchStartMinuteOfDay: $lunchStartMinuteOfDay, reminderMinutes: $reminderMinutes, workingDaysMask: $workingDaysMask)';
}


}

/// @nodoc
abstract mixin class $WorkScheduleCopyWith<$Res>  {
  factory $WorkScheduleCopyWith(WorkSchedule value, $Res Function(WorkSchedule) _then) = _$WorkScheduleCopyWithImpl;
@useResult
$Res call({
 int startMinuteOfDay, int endMinuteOfDay, int lunchMinutes, int lunchStartMinuteOfDay, int reminderMinutes, int? workingDaysMask
});




}
/// @nodoc
class _$WorkScheduleCopyWithImpl<$Res>
    implements $WorkScheduleCopyWith<$Res> {
  _$WorkScheduleCopyWithImpl(this._self, this._then);

  final WorkSchedule _self;
  final $Res Function(WorkSchedule) _then;

/// Create a copy of WorkSchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startMinuteOfDay = null,Object? endMinuteOfDay = null,Object? lunchMinutes = null,Object? lunchStartMinuteOfDay = null,Object? reminderMinutes = null,Object? workingDaysMask = freezed,}) {
  return _then(_self.copyWith(
startMinuteOfDay: null == startMinuteOfDay ? _self.startMinuteOfDay : startMinuteOfDay // ignore: cast_nullable_to_non_nullable
as int,endMinuteOfDay: null == endMinuteOfDay ? _self.endMinuteOfDay : endMinuteOfDay // ignore: cast_nullable_to_non_nullable
as int,lunchMinutes: null == lunchMinutes ? _self.lunchMinutes : lunchMinutes // ignore: cast_nullable_to_non_nullable
as int,lunchStartMinuteOfDay: null == lunchStartMinuteOfDay ? _self.lunchStartMinuteOfDay : lunchStartMinuteOfDay // ignore: cast_nullable_to_non_nullable
as int,reminderMinutes: null == reminderMinutes ? _self.reminderMinutes : reminderMinutes // ignore: cast_nullable_to_non_nullable
as int,workingDaysMask: freezed == workingDaysMask ? _self.workingDaysMask : workingDaysMask // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkSchedule].
extension WorkSchedulePatterns on WorkSchedule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkSchedule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkSchedule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkSchedule value)  $default,){
final _that = this;
switch (_that) {
case _WorkSchedule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkSchedule value)?  $default,){
final _that = this;
switch (_that) {
case _WorkSchedule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int startMinuteOfDay,  int endMinuteOfDay,  int lunchMinutes,  int lunchStartMinuteOfDay,  int reminderMinutes,  int? workingDaysMask)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkSchedule() when $default != null:
return $default(_that.startMinuteOfDay,_that.endMinuteOfDay,_that.lunchMinutes,_that.lunchStartMinuteOfDay,_that.reminderMinutes,_that.workingDaysMask);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int startMinuteOfDay,  int endMinuteOfDay,  int lunchMinutes,  int lunchStartMinuteOfDay,  int reminderMinutes,  int? workingDaysMask)  $default,) {final _that = this;
switch (_that) {
case _WorkSchedule():
return $default(_that.startMinuteOfDay,_that.endMinuteOfDay,_that.lunchMinutes,_that.lunchStartMinuteOfDay,_that.reminderMinutes,_that.workingDaysMask);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int startMinuteOfDay,  int endMinuteOfDay,  int lunchMinutes,  int lunchStartMinuteOfDay,  int reminderMinutes,  int? workingDaysMask)?  $default,) {final _that = this;
switch (_that) {
case _WorkSchedule() when $default != null:
return $default(_that.startMinuteOfDay,_that.endMinuteOfDay,_that.lunchMinutes,_that.lunchStartMinuteOfDay,_that.reminderMinutes,_that.workingDaysMask);case _:
  return null;

}
}

}

/// @nodoc


class _WorkSchedule implements WorkSchedule {
  const _WorkSchedule({required this.startMinuteOfDay, required this.endMinuteOfDay, required this.lunchMinutes, required this.lunchStartMinuteOfDay, required this.reminderMinutes, this.workingDaysMask});
  

@override final  int startMinuteOfDay;
// 540 (09:00)
@override final  int endMinuteOfDay;
// 1080 (18:00)
@override final  int lunchMinutes;
@override final  int lunchStartMinuteOfDay;
// 720 (12:00)
@override final  int reminderMinutes;
@override final  int? workingDaysMask;

/// Create a copy of WorkSchedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkScheduleCopyWith<_WorkSchedule> get copyWith => __$WorkScheduleCopyWithImpl<_WorkSchedule>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkSchedule&&(identical(other.startMinuteOfDay, startMinuteOfDay) || other.startMinuteOfDay == startMinuteOfDay)&&(identical(other.endMinuteOfDay, endMinuteOfDay) || other.endMinuteOfDay == endMinuteOfDay)&&(identical(other.lunchMinutes, lunchMinutes) || other.lunchMinutes == lunchMinutes)&&(identical(other.lunchStartMinuteOfDay, lunchStartMinuteOfDay) || other.lunchStartMinuteOfDay == lunchStartMinuteOfDay)&&(identical(other.reminderMinutes, reminderMinutes) || other.reminderMinutes == reminderMinutes)&&(identical(other.workingDaysMask, workingDaysMask) || other.workingDaysMask == workingDaysMask));
}


@override
int get hashCode => Object.hash(runtimeType,startMinuteOfDay,endMinuteOfDay,lunchMinutes,lunchStartMinuteOfDay,reminderMinutes,workingDaysMask);

@override
String toString() {
  return 'WorkSchedule(startMinuteOfDay: $startMinuteOfDay, endMinuteOfDay: $endMinuteOfDay, lunchMinutes: $lunchMinutes, lunchStartMinuteOfDay: $lunchStartMinuteOfDay, reminderMinutes: $reminderMinutes, workingDaysMask: $workingDaysMask)';
}


}

/// @nodoc
abstract mixin class _$WorkScheduleCopyWith<$Res> implements $WorkScheduleCopyWith<$Res> {
  factory _$WorkScheduleCopyWith(_WorkSchedule value, $Res Function(_WorkSchedule) _then) = __$WorkScheduleCopyWithImpl;
@override @useResult
$Res call({
 int startMinuteOfDay, int endMinuteOfDay, int lunchMinutes, int lunchStartMinuteOfDay, int reminderMinutes, int? workingDaysMask
});




}
/// @nodoc
class __$WorkScheduleCopyWithImpl<$Res>
    implements _$WorkScheduleCopyWith<$Res> {
  __$WorkScheduleCopyWithImpl(this._self, this._then);

  final _WorkSchedule _self;
  final $Res Function(_WorkSchedule) _then;

/// Create a copy of WorkSchedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startMinuteOfDay = null,Object? endMinuteOfDay = null,Object? lunchMinutes = null,Object? lunchStartMinuteOfDay = null,Object? reminderMinutes = null,Object? workingDaysMask = freezed,}) {
  return _then(_WorkSchedule(
startMinuteOfDay: null == startMinuteOfDay ? _self.startMinuteOfDay : startMinuteOfDay // ignore: cast_nullable_to_non_nullable
as int,endMinuteOfDay: null == endMinuteOfDay ? _self.endMinuteOfDay : endMinuteOfDay // ignore: cast_nullable_to_non_nullable
as int,lunchMinutes: null == lunchMinutes ? _self.lunchMinutes : lunchMinutes // ignore: cast_nullable_to_non_nullable
as int,lunchStartMinuteOfDay: null == lunchStartMinuteOfDay ? _self.lunchStartMinuteOfDay : lunchStartMinuteOfDay // ignore: cast_nullable_to_non_nullable
as int,reminderMinutes: null == reminderMinutes ? _self.reminderMinutes : reminderMinutes // ignore: cast_nullable_to_non_nullable
as int,workingDaysMask: freezed == workingDaysMask ? _self.workingDaysMask : workingDaysMask // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
