// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarDayModel {

 DateTime get date; bool get isCurrentMonth; bool get isToday; bool get isSelected; DayStatus get status; String? get timeLabel; Attendance? get attendance;// Whether the user has planned any task for this day (drives a marker).
 bool get hasPlannedTasks;
/// Create a copy of CalendarDayModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarDayModelCopyWith<CalendarDayModel> get copyWith => _$CalendarDayModelCopyWithImpl<CalendarDayModel>(this as CalendarDayModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarDayModel&&(identical(other.date, date) || other.date == date)&&(identical(other.isCurrentMonth, isCurrentMonth) || other.isCurrentMonth == isCurrentMonth)&&(identical(other.isToday, isToday) || other.isToday == isToday)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected)&&(identical(other.status, status) || other.status == status)&&(identical(other.timeLabel, timeLabel) || other.timeLabel == timeLabel)&&(identical(other.attendance, attendance) || other.attendance == attendance)&&(identical(other.hasPlannedTasks, hasPlannedTasks) || other.hasPlannedTasks == hasPlannedTasks));
}


@override
int get hashCode => Object.hash(runtimeType,date,isCurrentMonth,isToday,isSelected,status,timeLabel,attendance,hasPlannedTasks);

@override
String toString() {
  return 'CalendarDayModel(date: $date, isCurrentMonth: $isCurrentMonth, isToday: $isToday, isSelected: $isSelected, status: $status, timeLabel: $timeLabel, attendance: $attendance, hasPlannedTasks: $hasPlannedTasks)';
}


}

/// @nodoc
abstract mixin class $CalendarDayModelCopyWith<$Res>  {
  factory $CalendarDayModelCopyWith(CalendarDayModel value, $Res Function(CalendarDayModel) _then) = _$CalendarDayModelCopyWithImpl;
@useResult
$Res call({
 DateTime date, bool isCurrentMonth, bool isToday, bool isSelected, DayStatus status, String? timeLabel, Attendance? attendance, bool hasPlannedTasks
});


$AttendanceCopyWith<$Res>? get attendance;

}
/// @nodoc
class _$CalendarDayModelCopyWithImpl<$Res>
    implements $CalendarDayModelCopyWith<$Res> {
  _$CalendarDayModelCopyWithImpl(this._self, this._then);

  final CalendarDayModel _self;
  final $Res Function(CalendarDayModel) _then;

/// Create a copy of CalendarDayModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? isCurrentMonth = null,Object? isToday = null,Object? isSelected = null,Object? status = null,Object? timeLabel = freezed,Object? attendance = freezed,Object? hasPlannedTasks = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,isCurrentMonth: null == isCurrentMonth ? _self.isCurrentMonth : isCurrentMonth // ignore: cast_nullable_to_non_nullable
as bool,isToday: null == isToday ? _self.isToday : isToday // ignore: cast_nullable_to_non_nullable
as bool,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DayStatus,timeLabel: freezed == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String?,attendance: freezed == attendance ? _self.attendance : attendance // ignore: cast_nullable_to_non_nullable
as Attendance?,hasPlannedTasks: null == hasPlannedTasks ? _self.hasPlannedTasks : hasPlannedTasks // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of CalendarDayModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceCopyWith<$Res>? get attendance {
    if (_self.attendance == null) {
    return null;
  }

  return $AttendanceCopyWith<$Res>(_self.attendance!, (value) {
    return _then(_self.copyWith(attendance: value));
  });
}
}


/// Adds pattern-matching-related methods to [CalendarDayModel].
extension CalendarDayModelPatterns on CalendarDayModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarDayModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarDayModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarDayModel value)  $default,){
final _that = this;
switch (_that) {
case _CalendarDayModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarDayModel value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarDayModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  bool isCurrentMonth,  bool isToday,  bool isSelected,  DayStatus status,  String? timeLabel,  Attendance? attendance,  bool hasPlannedTasks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarDayModel() when $default != null:
return $default(_that.date,_that.isCurrentMonth,_that.isToday,_that.isSelected,_that.status,_that.timeLabel,_that.attendance,_that.hasPlannedTasks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  bool isCurrentMonth,  bool isToday,  bool isSelected,  DayStatus status,  String? timeLabel,  Attendance? attendance,  bool hasPlannedTasks)  $default,) {final _that = this;
switch (_that) {
case _CalendarDayModel():
return $default(_that.date,_that.isCurrentMonth,_that.isToday,_that.isSelected,_that.status,_that.timeLabel,_that.attendance,_that.hasPlannedTasks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  bool isCurrentMonth,  bool isToday,  bool isSelected,  DayStatus status,  String? timeLabel,  Attendance? attendance,  bool hasPlannedTasks)?  $default,) {final _that = this;
switch (_that) {
case _CalendarDayModel() when $default != null:
return $default(_that.date,_that.isCurrentMonth,_that.isToday,_that.isSelected,_that.status,_that.timeLabel,_that.attendance,_that.hasPlannedTasks);case _:
  return null;

}
}

}

/// @nodoc


class _CalendarDayModel implements CalendarDayModel {
  const _CalendarDayModel({required this.date, required this.isCurrentMonth, required this.isToday, required this.isSelected, required this.status, this.timeLabel, this.attendance, this.hasPlannedTasks = false});
  

@override final  DateTime date;
@override final  bool isCurrentMonth;
@override final  bool isToday;
@override final  bool isSelected;
@override final  DayStatus status;
@override final  String? timeLabel;
@override final  Attendance? attendance;
// Whether the user has planned any task for this day (drives a marker).
@override@JsonKey() final  bool hasPlannedTasks;

/// Create a copy of CalendarDayModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarDayModelCopyWith<_CalendarDayModel> get copyWith => __$CalendarDayModelCopyWithImpl<_CalendarDayModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarDayModel&&(identical(other.date, date) || other.date == date)&&(identical(other.isCurrentMonth, isCurrentMonth) || other.isCurrentMonth == isCurrentMonth)&&(identical(other.isToday, isToday) || other.isToday == isToday)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected)&&(identical(other.status, status) || other.status == status)&&(identical(other.timeLabel, timeLabel) || other.timeLabel == timeLabel)&&(identical(other.attendance, attendance) || other.attendance == attendance)&&(identical(other.hasPlannedTasks, hasPlannedTasks) || other.hasPlannedTasks == hasPlannedTasks));
}


@override
int get hashCode => Object.hash(runtimeType,date,isCurrentMonth,isToday,isSelected,status,timeLabel,attendance,hasPlannedTasks);

@override
String toString() {
  return 'CalendarDayModel(date: $date, isCurrentMonth: $isCurrentMonth, isToday: $isToday, isSelected: $isSelected, status: $status, timeLabel: $timeLabel, attendance: $attendance, hasPlannedTasks: $hasPlannedTasks)';
}


}

/// @nodoc
abstract mixin class _$CalendarDayModelCopyWith<$Res> implements $CalendarDayModelCopyWith<$Res> {
  factory _$CalendarDayModelCopyWith(_CalendarDayModel value, $Res Function(_CalendarDayModel) _then) = __$CalendarDayModelCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, bool isCurrentMonth, bool isToday, bool isSelected, DayStatus status, String? timeLabel, Attendance? attendance, bool hasPlannedTasks
});


@override $AttendanceCopyWith<$Res>? get attendance;

}
/// @nodoc
class __$CalendarDayModelCopyWithImpl<$Res>
    implements _$CalendarDayModelCopyWith<$Res> {
  __$CalendarDayModelCopyWithImpl(this._self, this._then);

  final _CalendarDayModel _self;
  final $Res Function(_CalendarDayModel) _then;

/// Create a copy of CalendarDayModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? isCurrentMonth = null,Object? isToday = null,Object? isSelected = null,Object? status = null,Object? timeLabel = freezed,Object? attendance = freezed,Object? hasPlannedTasks = null,}) {
  return _then(_CalendarDayModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,isCurrentMonth: null == isCurrentMonth ? _self.isCurrentMonth : isCurrentMonth // ignore: cast_nullable_to_non_nullable
as bool,isToday: null == isToday ? _self.isToday : isToday // ignore: cast_nullable_to_non_nullable
as bool,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DayStatus,timeLabel: freezed == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String?,attendance: freezed == attendance ? _self.attendance : attendance // ignore: cast_nullable_to_non_nullable
as Attendance?,hasPlannedTasks: null == hasPlannedTasks ? _self.hasPlannedTasks : hasPlannedTasks // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of CalendarDayModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceCopyWith<$Res>? get attendance {
    if (_self.attendance == null) {
    return null;
  }

  return $AttendanceCopyWith<$Res>(_self.attendance!, (value) {
    return _then(_self.copyWith(attendance: value));
  });
}
}

// dart format on
