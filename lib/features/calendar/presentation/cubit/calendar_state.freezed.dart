// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarState {

 bool get isLoading; int get year; int get month; DateTime get selectedDate; List<CalendarDayModel> get days; MonthSummary get summary; WorkSchedule? get schedule; bool get isSelectedDateWorkingDay; List<WorkItem> get plannedTasksForSelectedDay; List<DayWorkedTask> get workedTasksForSelectedDay; DaySummaryDisplayState get displayState; String? get editErrorMessage; String? get errorMessage;
/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarStateCopyWith<CalendarState> get copyWith => _$CalendarStateCopyWithImpl<CalendarState>(this as CalendarState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&const DeepCollectionEquality().equals(other.days, days)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.schedule, schedule) || other.schedule == schedule)&&(identical(other.isSelectedDateWorkingDay, isSelectedDateWorkingDay) || other.isSelectedDateWorkingDay == isSelectedDateWorkingDay)&&const DeepCollectionEquality().equals(other.plannedTasksForSelectedDay, plannedTasksForSelectedDay)&&const DeepCollectionEquality().equals(other.workedTasksForSelectedDay, workedTasksForSelectedDay)&&(identical(other.displayState, displayState) || other.displayState == displayState)&&(identical(other.editErrorMessage, editErrorMessage) || other.editErrorMessage == editErrorMessage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,year,month,selectedDate,const DeepCollectionEquality().hash(days),summary,schedule,isSelectedDateWorkingDay,const DeepCollectionEquality().hash(plannedTasksForSelectedDay),const DeepCollectionEquality().hash(workedTasksForSelectedDay),displayState,editErrorMessage,errorMessage);

@override
String toString() {
  return 'CalendarState(isLoading: $isLoading, year: $year, month: $month, selectedDate: $selectedDate, days: $days, summary: $summary, schedule: $schedule, isSelectedDateWorkingDay: $isSelectedDateWorkingDay, plannedTasksForSelectedDay: $plannedTasksForSelectedDay, workedTasksForSelectedDay: $workedTasksForSelectedDay, displayState: $displayState, editErrorMessage: $editErrorMessage, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CalendarStateCopyWith<$Res>  {
  factory $CalendarStateCopyWith(CalendarState value, $Res Function(CalendarState) _then) = _$CalendarStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, int year, int month, DateTime selectedDate, List<CalendarDayModel> days, MonthSummary summary, WorkSchedule? schedule, bool isSelectedDateWorkingDay, List<WorkItem> plannedTasksForSelectedDay, List<DayWorkedTask> workedTasksForSelectedDay, DaySummaryDisplayState displayState, String? editErrorMessage, String? errorMessage
});


$MonthSummaryCopyWith<$Res> get summary;$WorkScheduleCopyWith<$Res>? get schedule;

}
/// @nodoc
class _$CalendarStateCopyWithImpl<$Res>
    implements $CalendarStateCopyWith<$Res> {
  _$CalendarStateCopyWithImpl(this._self, this._then);

  final CalendarState _self;
  final $Res Function(CalendarState) _then;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? year = null,Object? month = null,Object? selectedDate = null,Object? days = null,Object? summary = null,Object? schedule = freezed,Object? isSelectedDateWorkingDay = null,Object? plannedTasksForSelectedDay = null,Object? workedTasksForSelectedDay = null,Object? displayState = null,Object? editErrorMessage = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,selectedDate: null == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<CalendarDayModel>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as MonthSummary,schedule: freezed == schedule ? _self.schedule : schedule // ignore: cast_nullable_to_non_nullable
as WorkSchedule?,isSelectedDateWorkingDay: null == isSelectedDateWorkingDay ? _self.isSelectedDateWorkingDay : isSelectedDateWorkingDay // ignore: cast_nullable_to_non_nullable
as bool,plannedTasksForSelectedDay: null == plannedTasksForSelectedDay ? _self.plannedTasksForSelectedDay : plannedTasksForSelectedDay // ignore: cast_nullable_to_non_nullable
as List<WorkItem>,workedTasksForSelectedDay: null == workedTasksForSelectedDay ? _self.workedTasksForSelectedDay : workedTasksForSelectedDay // ignore: cast_nullable_to_non_nullable
as List<DayWorkedTask>,displayState: null == displayState ? _self.displayState : displayState // ignore: cast_nullable_to_non_nullable
as DaySummaryDisplayState,editErrorMessage: freezed == editErrorMessage ? _self.editErrorMessage : editErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MonthSummaryCopyWith<$Res> get summary {
  
  return $MonthSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of CalendarState
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


/// Adds pattern-matching-related methods to [CalendarState].
extension CalendarStatePatterns on CalendarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarState value)  $default,){
final _that = this;
switch (_that) {
case _CalendarState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarState value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  int year,  int month,  DateTime selectedDate,  List<CalendarDayModel> days,  MonthSummary summary,  WorkSchedule? schedule,  bool isSelectedDateWorkingDay,  List<WorkItem> plannedTasksForSelectedDay,  List<DayWorkedTask> workedTasksForSelectedDay,  DaySummaryDisplayState displayState,  String? editErrorMessage,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
return $default(_that.isLoading,_that.year,_that.month,_that.selectedDate,_that.days,_that.summary,_that.schedule,_that.isSelectedDateWorkingDay,_that.plannedTasksForSelectedDay,_that.workedTasksForSelectedDay,_that.displayState,_that.editErrorMessage,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  int year,  int month,  DateTime selectedDate,  List<CalendarDayModel> days,  MonthSummary summary,  WorkSchedule? schedule,  bool isSelectedDateWorkingDay,  List<WorkItem> plannedTasksForSelectedDay,  List<DayWorkedTask> workedTasksForSelectedDay,  DaySummaryDisplayState displayState,  String? editErrorMessage,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CalendarState():
return $default(_that.isLoading,_that.year,_that.month,_that.selectedDate,_that.days,_that.summary,_that.schedule,_that.isSelectedDateWorkingDay,_that.plannedTasksForSelectedDay,_that.workedTasksForSelectedDay,_that.displayState,_that.editErrorMessage,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  int year,  int month,  DateTime selectedDate,  List<CalendarDayModel> days,  MonthSummary summary,  WorkSchedule? schedule,  bool isSelectedDateWorkingDay,  List<WorkItem> plannedTasksForSelectedDay,  List<DayWorkedTask> workedTasksForSelectedDay,  DaySummaryDisplayState displayState,  String? editErrorMessage,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
return $default(_that.isLoading,_that.year,_that.month,_that.selectedDate,_that.days,_that.summary,_that.schedule,_that.isSelectedDateWorkingDay,_that.plannedTasksForSelectedDay,_that.workedTasksForSelectedDay,_that.displayState,_that.editErrorMessage,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CalendarState implements CalendarState {
  const _CalendarState({this.isLoading = true, required this.year, required this.month, required this.selectedDate, final  List<CalendarDayModel> days = const <CalendarDayModel>[], this.summary = const MonthSummary(), this.schedule, this.isSelectedDateWorkingDay = false, final  List<WorkItem> plannedTasksForSelectedDay = const <WorkItem>[], final  List<DayWorkedTask> workedTasksForSelectedDay = const <DayWorkedTask>[], this.displayState = DaySummaryDisplayState.noScheduleSetUp, this.editErrorMessage, this.errorMessage}): _days = days,_plannedTasksForSelectedDay = plannedTasksForSelectedDay,_workedTasksForSelectedDay = workedTasksForSelectedDay;
  

@override@JsonKey() final  bool isLoading;
@override final  int year;
@override final  int month;
@override final  DateTime selectedDate;
 final  List<CalendarDayModel> _days;
@override@JsonKey() List<CalendarDayModel> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}

@override@JsonKey() final  MonthSummary summary;
@override final  WorkSchedule? schedule;
@override@JsonKey() final  bool isSelectedDateWorkingDay;
 final  List<WorkItem> _plannedTasksForSelectedDay;
@override@JsonKey() List<WorkItem> get plannedTasksForSelectedDay {
  if (_plannedTasksForSelectedDay is EqualUnmodifiableListView) return _plannedTasksForSelectedDay;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_plannedTasksForSelectedDay);
}

 final  List<DayWorkedTask> _workedTasksForSelectedDay;
@override@JsonKey() List<DayWorkedTask> get workedTasksForSelectedDay {
  if (_workedTasksForSelectedDay is EqualUnmodifiableListView) return _workedTasksForSelectedDay;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workedTasksForSelectedDay);
}

@override@JsonKey() final  DaySummaryDisplayState displayState;
@override final  String? editErrorMessage;
@override final  String? errorMessage;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarStateCopyWith<_CalendarState> get copyWith => __$CalendarStateCopyWithImpl<_CalendarState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&const DeepCollectionEquality().equals(other._days, _days)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.schedule, schedule) || other.schedule == schedule)&&(identical(other.isSelectedDateWorkingDay, isSelectedDateWorkingDay) || other.isSelectedDateWorkingDay == isSelectedDateWorkingDay)&&const DeepCollectionEquality().equals(other._plannedTasksForSelectedDay, _plannedTasksForSelectedDay)&&const DeepCollectionEquality().equals(other._workedTasksForSelectedDay, _workedTasksForSelectedDay)&&(identical(other.displayState, displayState) || other.displayState == displayState)&&(identical(other.editErrorMessage, editErrorMessage) || other.editErrorMessage == editErrorMessage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,year,month,selectedDate,const DeepCollectionEquality().hash(_days),summary,schedule,isSelectedDateWorkingDay,const DeepCollectionEquality().hash(_plannedTasksForSelectedDay),const DeepCollectionEquality().hash(_workedTasksForSelectedDay),displayState,editErrorMessage,errorMessage);

@override
String toString() {
  return 'CalendarState(isLoading: $isLoading, year: $year, month: $month, selectedDate: $selectedDate, days: $days, summary: $summary, schedule: $schedule, isSelectedDateWorkingDay: $isSelectedDateWorkingDay, plannedTasksForSelectedDay: $plannedTasksForSelectedDay, workedTasksForSelectedDay: $workedTasksForSelectedDay, displayState: $displayState, editErrorMessage: $editErrorMessage, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CalendarStateCopyWith<$Res> implements $CalendarStateCopyWith<$Res> {
  factory _$CalendarStateCopyWith(_CalendarState value, $Res Function(_CalendarState) _then) = __$CalendarStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, int year, int month, DateTime selectedDate, List<CalendarDayModel> days, MonthSummary summary, WorkSchedule? schedule, bool isSelectedDateWorkingDay, List<WorkItem> plannedTasksForSelectedDay, List<DayWorkedTask> workedTasksForSelectedDay, DaySummaryDisplayState displayState, String? editErrorMessage, String? errorMessage
});


@override $MonthSummaryCopyWith<$Res> get summary;@override $WorkScheduleCopyWith<$Res>? get schedule;

}
/// @nodoc
class __$CalendarStateCopyWithImpl<$Res>
    implements _$CalendarStateCopyWith<$Res> {
  __$CalendarStateCopyWithImpl(this._self, this._then);

  final _CalendarState _self;
  final $Res Function(_CalendarState) _then;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? year = null,Object? month = null,Object? selectedDate = null,Object? days = null,Object? summary = null,Object? schedule = freezed,Object? isSelectedDateWorkingDay = null,Object? plannedTasksForSelectedDay = null,Object? workedTasksForSelectedDay = null,Object? displayState = null,Object? editErrorMessage = freezed,Object? errorMessage = freezed,}) {
  return _then(_CalendarState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,selectedDate: null == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<CalendarDayModel>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as MonthSummary,schedule: freezed == schedule ? _self.schedule : schedule // ignore: cast_nullable_to_non_nullable
as WorkSchedule?,isSelectedDateWorkingDay: null == isSelectedDateWorkingDay ? _self.isSelectedDateWorkingDay : isSelectedDateWorkingDay // ignore: cast_nullable_to_non_nullable
as bool,plannedTasksForSelectedDay: null == plannedTasksForSelectedDay ? _self._plannedTasksForSelectedDay : plannedTasksForSelectedDay // ignore: cast_nullable_to_non_nullable
as List<WorkItem>,workedTasksForSelectedDay: null == workedTasksForSelectedDay ? _self._workedTasksForSelectedDay : workedTasksForSelectedDay // ignore: cast_nullable_to_non_nullable
as List<DayWorkedTask>,displayState: null == displayState ? _self.displayState : displayState // ignore: cast_nullable_to_non_nullable
as DaySummaryDisplayState,editErrorMessage: freezed == editErrorMessage ? _self.editErrorMessage : editErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MonthSummaryCopyWith<$Res> get summary {
  
  return $MonthSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of CalendarState
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
