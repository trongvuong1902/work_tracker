// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Attendance {

 DateTime get workDate; int get dayKey; DateTime? get checkIn; DateTime? get checkOut; int get expectedStartMinute; int get expectedEndMinute; int get lunchMinutes; int get workedMinutes; int get lateMinutes; int get overtimeMinutes; int get earlyLeaveMinutes; int get status; String? get note; bool get isEdited; DateTime? get editedAt;
/// Create a copy of Attendance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceCopyWith<Attendance> get copyWith => _$AttendanceCopyWithImpl<Attendance>(this as Attendance, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Attendance&&(identical(other.workDate, workDate) || other.workDate == workDate)&&(identical(other.dayKey, dayKey) || other.dayKey == dayKey)&&(identical(other.checkIn, checkIn) || other.checkIn == checkIn)&&(identical(other.checkOut, checkOut) || other.checkOut == checkOut)&&(identical(other.expectedStartMinute, expectedStartMinute) || other.expectedStartMinute == expectedStartMinute)&&(identical(other.expectedEndMinute, expectedEndMinute) || other.expectedEndMinute == expectedEndMinute)&&(identical(other.lunchMinutes, lunchMinutes) || other.lunchMinutes == lunchMinutes)&&(identical(other.workedMinutes, workedMinutes) || other.workedMinutes == workedMinutes)&&(identical(other.lateMinutes, lateMinutes) || other.lateMinutes == lateMinutes)&&(identical(other.overtimeMinutes, overtimeMinutes) || other.overtimeMinutes == overtimeMinutes)&&(identical(other.earlyLeaveMinutes, earlyLeaveMinutes) || other.earlyLeaveMinutes == earlyLeaveMinutes)&&(identical(other.status, status) || other.status == status)&&(identical(other.note, note) || other.note == note)&&(identical(other.isEdited, isEdited) || other.isEdited == isEdited)&&(identical(other.editedAt, editedAt) || other.editedAt == editedAt));
}


@override
int get hashCode => Object.hash(runtimeType,workDate,dayKey,checkIn,checkOut,expectedStartMinute,expectedEndMinute,lunchMinutes,workedMinutes,lateMinutes,overtimeMinutes,earlyLeaveMinutes,status,note,isEdited,editedAt);

@override
String toString() {
  return 'Attendance(workDate: $workDate, dayKey: $dayKey, checkIn: $checkIn, checkOut: $checkOut, expectedStartMinute: $expectedStartMinute, expectedEndMinute: $expectedEndMinute, lunchMinutes: $lunchMinutes, workedMinutes: $workedMinutes, lateMinutes: $lateMinutes, overtimeMinutes: $overtimeMinutes, earlyLeaveMinutes: $earlyLeaveMinutes, status: $status, note: $note, isEdited: $isEdited, editedAt: $editedAt)';
}


}

/// @nodoc
abstract mixin class $AttendanceCopyWith<$Res>  {
  factory $AttendanceCopyWith(Attendance value, $Res Function(Attendance) _then) = _$AttendanceCopyWithImpl;
@useResult
$Res call({
 DateTime workDate, int dayKey, DateTime? checkIn, DateTime? checkOut, int expectedStartMinute, int expectedEndMinute, int lunchMinutes, int workedMinutes, int lateMinutes, int overtimeMinutes, int earlyLeaveMinutes, int status, String? note, bool isEdited, DateTime? editedAt
});




}
/// @nodoc
class _$AttendanceCopyWithImpl<$Res>
    implements $AttendanceCopyWith<$Res> {
  _$AttendanceCopyWithImpl(this._self, this._then);

  final Attendance _self;
  final $Res Function(Attendance) _then;

/// Create a copy of Attendance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? workDate = null,Object? dayKey = null,Object? checkIn = freezed,Object? checkOut = freezed,Object? expectedStartMinute = null,Object? expectedEndMinute = null,Object? lunchMinutes = null,Object? workedMinutes = null,Object? lateMinutes = null,Object? overtimeMinutes = null,Object? earlyLeaveMinutes = null,Object? status = null,Object? note = freezed,Object? isEdited = null,Object? editedAt = freezed,}) {
  return _then(_self.copyWith(
workDate: null == workDate ? _self.workDate : workDate // ignore: cast_nullable_to_non_nullable
as DateTime,dayKey: null == dayKey ? _self.dayKey : dayKey // ignore: cast_nullable_to_non_nullable
as int,checkIn: freezed == checkIn ? _self.checkIn : checkIn // ignore: cast_nullable_to_non_nullable
as DateTime?,checkOut: freezed == checkOut ? _self.checkOut : checkOut // ignore: cast_nullable_to_non_nullable
as DateTime?,expectedStartMinute: null == expectedStartMinute ? _self.expectedStartMinute : expectedStartMinute // ignore: cast_nullable_to_non_nullable
as int,expectedEndMinute: null == expectedEndMinute ? _self.expectedEndMinute : expectedEndMinute // ignore: cast_nullable_to_non_nullable
as int,lunchMinutes: null == lunchMinutes ? _self.lunchMinutes : lunchMinutes // ignore: cast_nullable_to_non_nullable
as int,workedMinutes: null == workedMinutes ? _self.workedMinutes : workedMinutes // ignore: cast_nullable_to_non_nullable
as int,lateMinutes: null == lateMinutes ? _self.lateMinutes : lateMinutes // ignore: cast_nullable_to_non_nullable
as int,overtimeMinutes: null == overtimeMinutes ? _self.overtimeMinutes : overtimeMinutes // ignore: cast_nullable_to_non_nullable
as int,earlyLeaveMinutes: null == earlyLeaveMinutes ? _self.earlyLeaveMinutes : earlyLeaveMinutes // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,isEdited: null == isEdited ? _self.isEdited : isEdited // ignore: cast_nullable_to_non_nullable
as bool,editedAt: freezed == editedAt ? _self.editedAt : editedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Attendance].
extension AttendancePatterns on Attendance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Attendance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Attendance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Attendance value)  $default,){
final _that = this;
switch (_that) {
case _Attendance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Attendance value)?  $default,){
final _that = this;
switch (_that) {
case _Attendance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime workDate,  int dayKey,  DateTime? checkIn,  DateTime? checkOut,  int expectedStartMinute,  int expectedEndMinute,  int lunchMinutes,  int workedMinutes,  int lateMinutes,  int overtimeMinutes,  int earlyLeaveMinutes,  int status,  String? note,  bool isEdited,  DateTime? editedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Attendance() when $default != null:
return $default(_that.workDate,_that.dayKey,_that.checkIn,_that.checkOut,_that.expectedStartMinute,_that.expectedEndMinute,_that.lunchMinutes,_that.workedMinutes,_that.lateMinutes,_that.overtimeMinutes,_that.earlyLeaveMinutes,_that.status,_that.note,_that.isEdited,_that.editedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime workDate,  int dayKey,  DateTime? checkIn,  DateTime? checkOut,  int expectedStartMinute,  int expectedEndMinute,  int lunchMinutes,  int workedMinutes,  int lateMinutes,  int overtimeMinutes,  int earlyLeaveMinutes,  int status,  String? note,  bool isEdited,  DateTime? editedAt)  $default,) {final _that = this;
switch (_that) {
case _Attendance():
return $default(_that.workDate,_that.dayKey,_that.checkIn,_that.checkOut,_that.expectedStartMinute,_that.expectedEndMinute,_that.lunchMinutes,_that.workedMinutes,_that.lateMinutes,_that.overtimeMinutes,_that.earlyLeaveMinutes,_that.status,_that.note,_that.isEdited,_that.editedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime workDate,  int dayKey,  DateTime? checkIn,  DateTime? checkOut,  int expectedStartMinute,  int expectedEndMinute,  int lunchMinutes,  int workedMinutes,  int lateMinutes,  int overtimeMinutes,  int earlyLeaveMinutes,  int status,  String? note,  bool isEdited,  DateTime? editedAt)?  $default,) {final _that = this;
switch (_that) {
case _Attendance() when $default != null:
return $default(_that.workDate,_that.dayKey,_that.checkIn,_that.checkOut,_that.expectedStartMinute,_that.expectedEndMinute,_that.lunchMinutes,_that.workedMinutes,_that.lateMinutes,_that.overtimeMinutes,_that.earlyLeaveMinutes,_that.status,_that.note,_that.isEdited,_that.editedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Attendance implements Attendance {
  const _Attendance({required this.workDate, required this.dayKey, this.checkIn, this.checkOut, required this.expectedStartMinute, required this.expectedEndMinute, required this.lunchMinutes, this.workedMinutes = 0, this.lateMinutes = 0, this.overtimeMinutes = 0, this.earlyLeaveMinutes = 0, this.status = 0, this.note, this.isEdited = false, this.editedAt});
  

@override final  DateTime workDate;
@override final  int dayKey;
@override final  DateTime? checkIn;
@override final  DateTime? checkOut;
@override final  int expectedStartMinute;
@override final  int expectedEndMinute;
@override final  int lunchMinutes;
@override@JsonKey() final  int workedMinutes;
@override@JsonKey() final  int lateMinutes;
@override@JsonKey() final  int overtimeMinutes;
@override@JsonKey() final  int earlyLeaveMinutes;
@override@JsonKey() final  int status;
@override final  String? note;
@override@JsonKey() final  bool isEdited;
@override final  DateTime? editedAt;

/// Create a copy of Attendance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceCopyWith<_Attendance> get copyWith => __$AttendanceCopyWithImpl<_Attendance>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Attendance&&(identical(other.workDate, workDate) || other.workDate == workDate)&&(identical(other.dayKey, dayKey) || other.dayKey == dayKey)&&(identical(other.checkIn, checkIn) || other.checkIn == checkIn)&&(identical(other.checkOut, checkOut) || other.checkOut == checkOut)&&(identical(other.expectedStartMinute, expectedStartMinute) || other.expectedStartMinute == expectedStartMinute)&&(identical(other.expectedEndMinute, expectedEndMinute) || other.expectedEndMinute == expectedEndMinute)&&(identical(other.lunchMinutes, lunchMinutes) || other.lunchMinutes == lunchMinutes)&&(identical(other.workedMinutes, workedMinutes) || other.workedMinutes == workedMinutes)&&(identical(other.lateMinutes, lateMinutes) || other.lateMinutes == lateMinutes)&&(identical(other.overtimeMinutes, overtimeMinutes) || other.overtimeMinutes == overtimeMinutes)&&(identical(other.earlyLeaveMinutes, earlyLeaveMinutes) || other.earlyLeaveMinutes == earlyLeaveMinutes)&&(identical(other.status, status) || other.status == status)&&(identical(other.note, note) || other.note == note)&&(identical(other.isEdited, isEdited) || other.isEdited == isEdited)&&(identical(other.editedAt, editedAt) || other.editedAt == editedAt));
}


@override
int get hashCode => Object.hash(runtimeType,workDate,dayKey,checkIn,checkOut,expectedStartMinute,expectedEndMinute,lunchMinutes,workedMinutes,lateMinutes,overtimeMinutes,earlyLeaveMinutes,status,note,isEdited,editedAt);

@override
String toString() {
  return 'Attendance(workDate: $workDate, dayKey: $dayKey, checkIn: $checkIn, checkOut: $checkOut, expectedStartMinute: $expectedStartMinute, expectedEndMinute: $expectedEndMinute, lunchMinutes: $lunchMinutes, workedMinutes: $workedMinutes, lateMinutes: $lateMinutes, overtimeMinutes: $overtimeMinutes, earlyLeaveMinutes: $earlyLeaveMinutes, status: $status, note: $note, isEdited: $isEdited, editedAt: $editedAt)';
}


}

/// @nodoc
abstract mixin class _$AttendanceCopyWith<$Res> implements $AttendanceCopyWith<$Res> {
  factory _$AttendanceCopyWith(_Attendance value, $Res Function(_Attendance) _then) = __$AttendanceCopyWithImpl;
@override @useResult
$Res call({
 DateTime workDate, int dayKey, DateTime? checkIn, DateTime? checkOut, int expectedStartMinute, int expectedEndMinute, int lunchMinutes, int workedMinutes, int lateMinutes, int overtimeMinutes, int earlyLeaveMinutes, int status, String? note, bool isEdited, DateTime? editedAt
});




}
/// @nodoc
class __$AttendanceCopyWithImpl<$Res>
    implements _$AttendanceCopyWith<$Res> {
  __$AttendanceCopyWithImpl(this._self, this._then);

  final _Attendance _self;
  final $Res Function(_Attendance) _then;

/// Create a copy of Attendance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? workDate = null,Object? dayKey = null,Object? checkIn = freezed,Object? checkOut = freezed,Object? expectedStartMinute = null,Object? expectedEndMinute = null,Object? lunchMinutes = null,Object? workedMinutes = null,Object? lateMinutes = null,Object? overtimeMinutes = null,Object? earlyLeaveMinutes = null,Object? status = null,Object? note = freezed,Object? isEdited = null,Object? editedAt = freezed,}) {
  return _then(_Attendance(
workDate: null == workDate ? _self.workDate : workDate // ignore: cast_nullable_to_non_nullable
as DateTime,dayKey: null == dayKey ? _self.dayKey : dayKey // ignore: cast_nullable_to_non_nullable
as int,checkIn: freezed == checkIn ? _self.checkIn : checkIn // ignore: cast_nullable_to_non_nullable
as DateTime?,checkOut: freezed == checkOut ? _self.checkOut : checkOut // ignore: cast_nullable_to_non_nullable
as DateTime?,expectedStartMinute: null == expectedStartMinute ? _self.expectedStartMinute : expectedStartMinute // ignore: cast_nullable_to_non_nullable
as int,expectedEndMinute: null == expectedEndMinute ? _self.expectedEndMinute : expectedEndMinute // ignore: cast_nullable_to_non_nullable
as int,lunchMinutes: null == lunchMinutes ? _self.lunchMinutes : lunchMinutes // ignore: cast_nullable_to_non_nullable
as int,workedMinutes: null == workedMinutes ? _self.workedMinutes : workedMinutes // ignore: cast_nullable_to_non_nullable
as int,lateMinutes: null == lateMinutes ? _self.lateMinutes : lateMinutes // ignore: cast_nullable_to_non_nullable
as int,overtimeMinutes: null == overtimeMinutes ? _self.overtimeMinutes : overtimeMinutes // ignore: cast_nullable_to_non_nullable
as int,earlyLeaveMinutes: null == earlyLeaveMinutes ? _self.earlyLeaveMinutes : earlyLeaveMinutes // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,isEdited: null == isEdited ? _self.isEdited : isEdited // ignore: cast_nullable_to_non_nullable
as bool,editedAt: freezed == editedAt ? _self.editedAt : editedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
