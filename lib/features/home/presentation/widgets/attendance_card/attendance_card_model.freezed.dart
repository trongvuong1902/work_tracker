// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttendanceCardModel {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceCardModel);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceCardModel()';
}


}

/// @nodoc
class $AttendanceCardModelCopyWith<$Res>  {
$AttendanceCardModelCopyWith(AttendanceCardModel _, $Res Function(AttendanceCardModel) __);
}


/// Adds pattern-matching-related methods to [AttendanceCardModel].
extension AttendanceCardModelPatterns on AttendanceCardModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _BeforeCheckIn value)?  beforeCheckIn,TResult Function( _Working value)?  working,TResult Function( _AfterCheckOut value)?  afterCheckOut,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BeforeCheckIn() when beforeCheckIn != null:
return beforeCheckIn(_that);case _Working() when working != null:
return working(_that);case _AfterCheckOut() when afterCheckOut != null:
return afterCheckOut(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _BeforeCheckIn value)  beforeCheckIn,required TResult Function( _Working value)  working,required TResult Function( _AfterCheckOut value)  afterCheckOut,}){
final _that = this;
switch (_that) {
case _BeforeCheckIn():
return beforeCheckIn(_that);case _Working():
return working(_that);case _AfterCheckOut():
return afterCheckOut(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _BeforeCheckIn value)?  beforeCheckIn,TResult? Function( _Working value)?  working,TResult? Function( _AfterCheckOut value)?  afterCheckOut,}){
final _that = this;
switch (_that) {
case _BeforeCheckIn() when beforeCheckIn != null:
return beforeCheckIn(_that);case _Working() when working != null:
return working(_that);case _AfterCheckOut() when afterCheckOut != null:
return afterCheckOut(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String startWorkTime,  String endWorkTime,  String workingTime,  String breakTime)?  beforeCheckIn,TResult Function( String actualCheckInTime,  String plannedCheckInTime,  String estimateCheckOutTime,  String plannedLeave,  String? extraTimeCheckIn,  CheckInStatus? checkInStatus,  String? extraTimeCheckOut,  CheckOutStatus? checkOutStatus)?  working,TResult Function( String workedTime,  String plannedWorkedTime,  String overtime,  String actualCheckInTime,  String plannedCheckInTime,  CheckInStatus checkInStatus,  String checkInExtra,  String actualCheckOutTime,  String plannedCheckOutTime,  CheckOutStatus checkOutStatus,  String checkOutExtra)?  afterCheckOut,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BeforeCheckIn() when beforeCheckIn != null:
return beforeCheckIn(_that.startWorkTime,_that.endWorkTime,_that.workingTime,_that.breakTime);case _Working() when working != null:
return working(_that.actualCheckInTime,_that.plannedCheckInTime,_that.estimateCheckOutTime,_that.plannedLeave,_that.extraTimeCheckIn,_that.checkInStatus,_that.extraTimeCheckOut,_that.checkOutStatus);case _AfterCheckOut() when afterCheckOut != null:
return afterCheckOut(_that.workedTime,_that.plannedWorkedTime,_that.overtime,_that.actualCheckInTime,_that.plannedCheckInTime,_that.checkInStatus,_that.checkInExtra,_that.actualCheckOutTime,_that.plannedCheckOutTime,_that.checkOutStatus,_that.checkOutExtra);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String startWorkTime,  String endWorkTime,  String workingTime,  String breakTime)  beforeCheckIn,required TResult Function( String actualCheckInTime,  String plannedCheckInTime,  String estimateCheckOutTime,  String plannedLeave,  String? extraTimeCheckIn,  CheckInStatus? checkInStatus,  String? extraTimeCheckOut,  CheckOutStatus? checkOutStatus)  working,required TResult Function( String workedTime,  String plannedWorkedTime,  String overtime,  String actualCheckInTime,  String plannedCheckInTime,  CheckInStatus checkInStatus,  String checkInExtra,  String actualCheckOutTime,  String plannedCheckOutTime,  CheckOutStatus checkOutStatus,  String checkOutExtra)  afterCheckOut,}) {final _that = this;
switch (_that) {
case _BeforeCheckIn():
return beforeCheckIn(_that.startWorkTime,_that.endWorkTime,_that.workingTime,_that.breakTime);case _Working():
return working(_that.actualCheckInTime,_that.plannedCheckInTime,_that.estimateCheckOutTime,_that.plannedLeave,_that.extraTimeCheckIn,_that.checkInStatus,_that.extraTimeCheckOut,_that.checkOutStatus);case _AfterCheckOut():
return afterCheckOut(_that.workedTime,_that.plannedWorkedTime,_that.overtime,_that.actualCheckInTime,_that.plannedCheckInTime,_that.checkInStatus,_that.checkInExtra,_that.actualCheckOutTime,_that.plannedCheckOutTime,_that.checkOutStatus,_that.checkOutExtra);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String startWorkTime,  String endWorkTime,  String workingTime,  String breakTime)?  beforeCheckIn,TResult? Function( String actualCheckInTime,  String plannedCheckInTime,  String estimateCheckOutTime,  String plannedLeave,  String? extraTimeCheckIn,  CheckInStatus? checkInStatus,  String? extraTimeCheckOut,  CheckOutStatus? checkOutStatus)?  working,TResult? Function( String workedTime,  String plannedWorkedTime,  String overtime,  String actualCheckInTime,  String plannedCheckInTime,  CheckInStatus checkInStatus,  String checkInExtra,  String actualCheckOutTime,  String plannedCheckOutTime,  CheckOutStatus checkOutStatus,  String checkOutExtra)?  afterCheckOut,}) {final _that = this;
switch (_that) {
case _BeforeCheckIn() when beforeCheckIn != null:
return beforeCheckIn(_that.startWorkTime,_that.endWorkTime,_that.workingTime,_that.breakTime);case _Working() when working != null:
return working(_that.actualCheckInTime,_that.plannedCheckInTime,_that.estimateCheckOutTime,_that.plannedLeave,_that.extraTimeCheckIn,_that.checkInStatus,_that.extraTimeCheckOut,_that.checkOutStatus);case _AfterCheckOut() when afterCheckOut != null:
return afterCheckOut(_that.workedTime,_that.plannedWorkedTime,_that.overtime,_that.actualCheckInTime,_that.plannedCheckInTime,_that.checkInStatus,_that.checkInExtra,_that.actualCheckOutTime,_that.plannedCheckOutTime,_that.checkOutStatus,_that.checkOutExtra);case _:
  return null;

}
}

}

/// @nodoc


class _BeforeCheckIn implements AttendanceCardModel {
  const _BeforeCheckIn({required this.startWorkTime, required this.endWorkTime, required this.workingTime, required this.breakTime});
  

 final  String startWorkTime;
 final  String endWorkTime;
 final  String workingTime;
 final  String breakTime;

/// Create a copy of AttendanceCardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BeforeCheckInCopyWith<_BeforeCheckIn> get copyWith => __$BeforeCheckInCopyWithImpl<_BeforeCheckIn>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BeforeCheckIn&&(identical(other.startWorkTime, startWorkTime) || other.startWorkTime == startWorkTime)&&(identical(other.endWorkTime, endWorkTime) || other.endWorkTime == endWorkTime)&&(identical(other.workingTime, workingTime) || other.workingTime == workingTime)&&(identical(other.breakTime, breakTime) || other.breakTime == breakTime));
}


@override
int get hashCode => Object.hash(runtimeType,startWorkTime,endWorkTime,workingTime,breakTime);

@override
String toString() {
  return 'AttendanceCardModel.beforeCheckIn(startWorkTime: $startWorkTime, endWorkTime: $endWorkTime, workingTime: $workingTime, breakTime: $breakTime)';
}


}

/// @nodoc
abstract mixin class _$BeforeCheckInCopyWith<$Res> implements $AttendanceCardModelCopyWith<$Res> {
  factory _$BeforeCheckInCopyWith(_BeforeCheckIn value, $Res Function(_BeforeCheckIn) _then) = __$BeforeCheckInCopyWithImpl;
@useResult
$Res call({
 String startWorkTime, String endWorkTime, String workingTime, String breakTime
});




}
/// @nodoc
class __$BeforeCheckInCopyWithImpl<$Res>
    implements _$BeforeCheckInCopyWith<$Res> {
  __$BeforeCheckInCopyWithImpl(this._self, this._then);

  final _BeforeCheckIn _self;
  final $Res Function(_BeforeCheckIn) _then;

/// Create a copy of AttendanceCardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? startWorkTime = null,Object? endWorkTime = null,Object? workingTime = null,Object? breakTime = null,}) {
  return _then(_BeforeCheckIn(
startWorkTime: null == startWorkTime ? _self.startWorkTime : startWorkTime // ignore: cast_nullable_to_non_nullable
as String,endWorkTime: null == endWorkTime ? _self.endWorkTime : endWorkTime // ignore: cast_nullable_to_non_nullable
as String,workingTime: null == workingTime ? _self.workingTime : workingTime // ignore: cast_nullable_to_non_nullable
as String,breakTime: null == breakTime ? _self.breakTime : breakTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Working implements AttendanceCardModel {
  const _Working({required this.actualCheckInTime, required this.plannedCheckInTime, required this.estimateCheckOutTime, required this.plannedLeave, this.extraTimeCheckIn, this.checkInStatus, this.extraTimeCheckOut, this.checkOutStatus});
  

 final  String actualCheckInTime;
 final  String plannedCheckInTime;
 final  String estimateCheckOutTime;
 final  String plannedLeave;
 final  String? extraTimeCheckIn;
 final  CheckInStatus? checkInStatus;
 final  String? extraTimeCheckOut;
 final  CheckOutStatus? checkOutStatus;

/// Create a copy of AttendanceCardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkingCopyWith<_Working> get copyWith => __$WorkingCopyWithImpl<_Working>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Working&&(identical(other.actualCheckInTime, actualCheckInTime) || other.actualCheckInTime == actualCheckInTime)&&(identical(other.plannedCheckInTime, plannedCheckInTime) || other.plannedCheckInTime == plannedCheckInTime)&&(identical(other.estimateCheckOutTime, estimateCheckOutTime) || other.estimateCheckOutTime == estimateCheckOutTime)&&(identical(other.plannedLeave, plannedLeave) || other.plannedLeave == plannedLeave)&&(identical(other.extraTimeCheckIn, extraTimeCheckIn) || other.extraTimeCheckIn == extraTimeCheckIn)&&(identical(other.checkInStatus, checkInStatus) || other.checkInStatus == checkInStatus)&&(identical(other.extraTimeCheckOut, extraTimeCheckOut) || other.extraTimeCheckOut == extraTimeCheckOut)&&(identical(other.checkOutStatus, checkOutStatus) || other.checkOutStatus == checkOutStatus));
}


@override
int get hashCode => Object.hash(runtimeType,actualCheckInTime,plannedCheckInTime,estimateCheckOutTime,plannedLeave,extraTimeCheckIn,checkInStatus,extraTimeCheckOut,checkOutStatus);

@override
String toString() {
  return 'AttendanceCardModel.working(actualCheckInTime: $actualCheckInTime, plannedCheckInTime: $plannedCheckInTime, estimateCheckOutTime: $estimateCheckOutTime, plannedLeave: $plannedLeave, extraTimeCheckIn: $extraTimeCheckIn, checkInStatus: $checkInStatus, extraTimeCheckOut: $extraTimeCheckOut, checkOutStatus: $checkOutStatus)';
}


}

/// @nodoc
abstract mixin class _$WorkingCopyWith<$Res> implements $AttendanceCardModelCopyWith<$Res> {
  factory _$WorkingCopyWith(_Working value, $Res Function(_Working) _then) = __$WorkingCopyWithImpl;
@useResult
$Res call({
 String actualCheckInTime, String plannedCheckInTime, String estimateCheckOutTime, String plannedLeave, String? extraTimeCheckIn, CheckInStatus? checkInStatus, String? extraTimeCheckOut, CheckOutStatus? checkOutStatus
});




}
/// @nodoc
class __$WorkingCopyWithImpl<$Res>
    implements _$WorkingCopyWith<$Res> {
  __$WorkingCopyWithImpl(this._self, this._then);

  final _Working _self;
  final $Res Function(_Working) _then;

/// Create a copy of AttendanceCardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? actualCheckInTime = null,Object? plannedCheckInTime = null,Object? estimateCheckOutTime = null,Object? plannedLeave = null,Object? extraTimeCheckIn = freezed,Object? checkInStatus = freezed,Object? extraTimeCheckOut = freezed,Object? checkOutStatus = freezed,}) {
  return _then(_Working(
actualCheckInTime: null == actualCheckInTime ? _self.actualCheckInTime : actualCheckInTime // ignore: cast_nullable_to_non_nullable
as String,plannedCheckInTime: null == plannedCheckInTime ? _self.plannedCheckInTime : plannedCheckInTime // ignore: cast_nullable_to_non_nullable
as String,estimateCheckOutTime: null == estimateCheckOutTime ? _self.estimateCheckOutTime : estimateCheckOutTime // ignore: cast_nullable_to_non_nullable
as String,plannedLeave: null == plannedLeave ? _self.plannedLeave : plannedLeave // ignore: cast_nullable_to_non_nullable
as String,extraTimeCheckIn: freezed == extraTimeCheckIn ? _self.extraTimeCheckIn : extraTimeCheckIn // ignore: cast_nullable_to_non_nullable
as String?,checkInStatus: freezed == checkInStatus ? _self.checkInStatus : checkInStatus // ignore: cast_nullable_to_non_nullable
as CheckInStatus?,extraTimeCheckOut: freezed == extraTimeCheckOut ? _self.extraTimeCheckOut : extraTimeCheckOut // ignore: cast_nullable_to_non_nullable
as String?,checkOutStatus: freezed == checkOutStatus ? _self.checkOutStatus : checkOutStatus // ignore: cast_nullable_to_non_nullable
as CheckOutStatus?,
  ));
}


}

/// @nodoc


class _AfterCheckOut implements AttendanceCardModel {
  const _AfterCheckOut({required this.workedTime, required this.plannedWorkedTime, required this.overtime, required this.actualCheckInTime, required this.plannedCheckInTime, required this.checkInStatus, required this.checkInExtra, required this.actualCheckOutTime, required this.plannedCheckOutTime, required this.checkOutStatus, required this.checkOutExtra});
  

 final  String workedTime;
 final  String plannedWorkedTime;
 final  String overtime;
 final  String actualCheckInTime;
 final  String plannedCheckInTime;
 final  CheckInStatus checkInStatus;
 final  String checkInExtra;
 final  String actualCheckOutTime;
 final  String plannedCheckOutTime;
 final  CheckOutStatus checkOutStatus;
 final  String checkOutExtra;

/// Create a copy of AttendanceCardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AfterCheckOutCopyWith<_AfterCheckOut> get copyWith => __$AfterCheckOutCopyWithImpl<_AfterCheckOut>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AfterCheckOut&&(identical(other.workedTime, workedTime) || other.workedTime == workedTime)&&(identical(other.plannedWorkedTime, plannedWorkedTime) || other.plannedWorkedTime == plannedWorkedTime)&&(identical(other.overtime, overtime) || other.overtime == overtime)&&(identical(other.actualCheckInTime, actualCheckInTime) || other.actualCheckInTime == actualCheckInTime)&&(identical(other.plannedCheckInTime, plannedCheckInTime) || other.plannedCheckInTime == plannedCheckInTime)&&(identical(other.checkInStatus, checkInStatus) || other.checkInStatus == checkInStatus)&&(identical(other.checkInExtra, checkInExtra) || other.checkInExtra == checkInExtra)&&(identical(other.actualCheckOutTime, actualCheckOutTime) || other.actualCheckOutTime == actualCheckOutTime)&&(identical(other.plannedCheckOutTime, plannedCheckOutTime) || other.plannedCheckOutTime == plannedCheckOutTime)&&(identical(other.checkOutStatus, checkOutStatus) || other.checkOutStatus == checkOutStatus)&&(identical(other.checkOutExtra, checkOutExtra) || other.checkOutExtra == checkOutExtra));
}


@override
int get hashCode => Object.hash(runtimeType,workedTime,plannedWorkedTime,overtime,actualCheckInTime,plannedCheckInTime,checkInStatus,checkInExtra,actualCheckOutTime,plannedCheckOutTime,checkOutStatus,checkOutExtra);

@override
String toString() {
  return 'AttendanceCardModel.afterCheckOut(workedTime: $workedTime, plannedWorkedTime: $plannedWorkedTime, overtime: $overtime, actualCheckInTime: $actualCheckInTime, plannedCheckInTime: $plannedCheckInTime, checkInStatus: $checkInStatus, checkInExtra: $checkInExtra, actualCheckOutTime: $actualCheckOutTime, plannedCheckOutTime: $plannedCheckOutTime, checkOutStatus: $checkOutStatus, checkOutExtra: $checkOutExtra)';
}


}

/// @nodoc
abstract mixin class _$AfterCheckOutCopyWith<$Res> implements $AttendanceCardModelCopyWith<$Res> {
  factory _$AfterCheckOutCopyWith(_AfterCheckOut value, $Res Function(_AfterCheckOut) _then) = __$AfterCheckOutCopyWithImpl;
@useResult
$Res call({
 String workedTime, String plannedWorkedTime, String overtime, String actualCheckInTime, String plannedCheckInTime, CheckInStatus checkInStatus, String checkInExtra, String actualCheckOutTime, String plannedCheckOutTime, CheckOutStatus checkOutStatus, String checkOutExtra
});




}
/// @nodoc
class __$AfterCheckOutCopyWithImpl<$Res>
    implements _$AfterCheckOutCopyWith<$Res> {
  __$AfterCheckOutCopyWithImpl(this._self, this._then);

  final _AfterCheckOut _self;
  final $Res Function(_AfterCheckOut) _then;

/// Create a copy of AttendanceCardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? workedTime = null,Object? plannedWorkedTime = null,Object? overtime = null,Object? actualCheckInTime = null,Object? plannedCheckInTime = null,Object? checkInStatus = null,Object? checkInExtra = null,Object? actualCheckOutTime = null,Object? plannedCheckOutTime = null,Object? checkOutStatus = null,Object? checkOutExtra = null,}) {
  return _then(_AfterCheckOut(
workedTime: null == workedTime ? _self.workedTime : workedTime // ignore: cast_nullable_to_non_nullable
as String,plannedWorkedTime: null == plannedWorkedTime ? _self.plannedWorkedTime : plannedWorkedTime // ignore: cast_nullable_to_non_nullable
as String,overtime: null == overtime ? _self.overtime : overtime // ignore: cast_nullable_to_non_nullable
as String,actualCheckInTime: null == actualCheckInTime ? _self.actualCheckInTime : actualCheckInTime // ignore: cast_nullable_to_non_nullable
as String,plannedCheckInTime: null == plannedCheckInTime ? _self.plannedCheckInTime : plannedCheckInTime // ignore: cast_nullable_to_non_nullable
as String,checkInStatus: null == checkInStatus ? _self.checkInStatus : checkInStatus // ignore: cast_nullable_to_non_nullable
as CheckInStatus,checkInExtra: null == checkInExtra ? _self.checkInExtra : checkInExtra // ignore: cast_nullable_to_non_nullable
as String,actualCheckOutTime: null == actualCheckOutTime ? _self.actualCheckOutTime : actualCheckOutTime // ignore: cast_nullable_to_non_nullable
as String,plannedCheckOutTime: null == plannedCheckOutTime ? _self.plannedCheckOutTime : plannedCheckOutTime // ignore: cast_nullable_to_non_nullable
as String,checkOutStatus: null == checkOutStatus ? _self.checkOutStatus : checkOutStatus // ignore: cast_nullable_to_non_nullable
as CheckOutStatus,checkOutExtra: null == checkOutExtra ? _self.checkOutExtra : checkOutExtra // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
