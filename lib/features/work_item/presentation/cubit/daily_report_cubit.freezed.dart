// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_report_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailyReportState implements DiagnosticableTreeMixin {

 bool get isLoading; DailyReport? get report; Attendance? get attendance;
/// Create a copy of DailyReportState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyReportStateCopyWith<DailyReportState> get copyWith => _$DailyReportStateCopyWithImpl<DailyReportState>(this as DailyReportState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DailyReportState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('report', report))..add(DiagnosticsProperty('attendance', attendance));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyReportState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.report, report) || other.report == report)&&(identical(other.attendance, attendance) || other.attendance == attendance));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,report,attendance);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DailyReportState(isLoading: $isLoading, report: $report, attendance: $attendance)';
}


}

/// @nodoc
abstract mixin class $DailyReportStateCopyWith<$Res>  {
  factory $DailyReportStateCopyWith(DailyReportState value, $Res Function(DailyReportState) _then) = _$DailyReportStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, DailyReport? report, Attendance? attendance
});


$AttendanceCopyWith<$Res>? get attendance;

}
/// @nodoc
class _$DailyReportStateCopyWithImpl<$Res>
    implements $DailyReportStateCopyWith<$Res> {
  _$DailyReportStateCopyWithImpl(this._self, this._then);

  final DailyReportState _self;
  final $Res Function(DailyReportState) _then;

/// Create a copy of DailyReportState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? report = freezed,Object? attendance = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as DailyReport?,attendance: freezed == attendance ? _self.attendance : attendance // ignore: cast_nullable_to_non_nullable
as Attendance?,
  ));
}
/// Create a copy of DailyReportState
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


/// Adds pattern-matching-related methods to [DailyReportState].
extension DailyReportStatePatterns on DailyReportState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyReportState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyReportState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyReportState value)  $default,){
final _that = this;
switch (_that) {
case _DailyReportState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyReportState value)?  $default,){
final _that = this;
switch (_that) {
case _DailyReportState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  DailyReport? report,  Attendance? attendance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyReportState() when $default != null:
return $default(_that.isLoading,_that.report,_that.attendance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  DailyReport? report,  Attendance? attendance)  $default,) {final _that = this;
switch (_that) {
case _DailyReportState():
return $default(_that.isLoading,_that.report,_that.attendance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  DailyReport? report,  Attendance? attendance)?  $default,) {final _that = this;
switch (_that) {
case _DailyReportState() when $default != null:
return $default(_that.isLoading,_that.report,_that.attendance);case _:
  return null;

}
}

}

/// @nodoc


class _DailyReportState with DiagnosticableTreeMixin implements DailyReportState {
  const _DailyReportState({this.isLoading = true, this.report, this.attendance});
  

@override@JsonKey() final  bool isLoading;
@override final  DailyReport? report;
@override final  Attendance? attendance;

/// Create a copy of DailyReportState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyReportStateCopyWith<_DailyReportState> get copyWith => __$DailyReportStateCopyWithImpl<_DailyReportState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DailyReportState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('report', report))..add(DiagnosticsProperty('attendance', attendance));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyReportState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.report, report) || other.report == report)&&(identical(other.attendance, attendance) || other.attendance == attendance));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,report,attendance);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DailyReportState(isLoading: $isLoading, report: $report, attendance: $attendance)';
}


}

/// @nodoc
abstract mixin class _$DailyReportStateCopyWith<$Res> implements $DailyReportStateCopyWith<$Res> {
  factory _$DailyReportStateCopyWith(_DailyReportState value, $Res Function(_DailyReportState) _then) = __$DailyReportStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, DailyReport? report, Attendance? attendance
});


@override $AttendanceCopyWith<$Res>? get attendance;

}
/// @nodoc
class __$DailyReportStateCopyWithImpl<$Res>
    implements _$DailyReportStateCopyWith<$Res> {
  __$DailyReportStateCopyWithImpl(this._self, this._then);

  final _DailyReportState _self;
  final $Res Function(_DailyReportState) _then;

/// Create a copy of DailyReportState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? report = freezed,Object? attendance = freezed,}) {
  return _then(_DailyReportState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as DailyReport?,attendance: freezed == attendance ? _self.attendance : attendance // ignore: cast_nullable_to_non_nullable
as Attendance?,
  ));
}

/// Create a copy of DailyReportState
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
