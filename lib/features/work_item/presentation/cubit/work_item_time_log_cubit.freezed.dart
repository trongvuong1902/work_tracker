// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_item_time_log_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkItemTimeLogState implements DiagnosticableTreeMixin {

 bool get isLoading; List<TaskTimeDayGroup> get groups; List<WorkItem> get tasks; String? get errorMessage;
/// Create a copy of WorkItemTimeLogState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkItemTimeLogStateCopyWith<WorkItemTimeLogState> get copyWith => _$WorkItemTimeLogStateCopyWithImpl<WorkItemTimeLogState>(this as WorkItemTimeLogState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'WorkItemTimeLogState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('groups', groups))..add(DiagnosticsProperty('tasks', tasks))..add(DiagnosticsProperty('errorMessage', errorMessage));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkItemTimeLogState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.groups, groups)&&const DeepCollectionEquality().equals(other.tasks, tasks)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(groups),const DeepCollectionEquality().hash(tasks),errorMessage);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'WorkItemTimeLogState(isLoading: $isLoading, groups: $groups, tasks: $tasks, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $WorkItemTimeLogStateCopyWith<$Res>  {
  factory $WorkItemTimeLogStateCopyWith(WorkItemTimeLogState value, $Res Function(WorkItemTimeLogState) _then) = _$WorkItemTimeLogStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<TaskTimeDayGroup> groups, List<WorkItem> tasks, String? errorMessage
});




}
/// @nodoc
class _$WorkItemTimeLogStateCopyWithImpl<$Res>
    implements $WorkItemTimeLogStateCopyWith<$Res> {
  _$WorkItemTimeLogStateCopyWithImpl(this._self, this._then);

  final WorkItemTimeLogState _self;
  final $Res Function(WorkItemTimeLogState) _then;

/// Create a copy of WorkItemTimeLogState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? groups = null,Object? tasks = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<TaskTimeDayGroup>,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<WorkItem>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkItemTimeLogState].
extension WorkItemTimeLogStatePatterns on WorkItemTimeLogState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkItemTimeLogState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkItemTimeLogState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkItemTimeLogState value)  $default,){
final _that = this;
switch (_that) {
case _WorkItemTimeLogState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkItemTimeLogState value)?  $default,){
final _that = this;
switch (_that) {
case _WorkItemTimeLogState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<TaskTimeDayGroup> groups,  List<WorkItem> tasks,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkItemTimeLogState() when $default != null:
return $default(_that.isLoading,_that.groups,_that.tasks,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<TaskTimeDayGroup> groups,  List<WorkItem> tasks,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _WorkItemTimeLogState():
return $default(_that.isLoading,_that.groups,_that.tasks,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<TaskTimeDayGroup> groups,  List<WorkItem> tasks,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _WorkItemTimeLogState() when $default != null:
return $default(_that.isLoading,_that.groups,_that.tasks,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _WorkItemTimeLogState with DiagnosticableTreeMixin implements WorkItemTimeLogState {
  const _WorkItemTimeLogState({this.isLoading = true, final  List<TaskTimeDayGroup> groups = const <TaskTimeDayGroup>[], final  List<WorkItem> tasks = const <WorkItem>[], this.errorMessage}): _groups = groups,_tasks = tasks;
  

@override@JsonKey() final  bool isLoading;
 final  List<TaskTimeDayGroup> _groups;
@override@JsonKey() List<TaskTimeDayGroup> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}

 final  List<WorkItem> _tasks;
@override@JsonKey() List<WorkItem> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}

@override final  String? errorMessage;

/// Create a copy of WorkItemTimeLogState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkItemTimeLogStateCopyWith<_WorkItemTimeLogState> get copyWith => __$WorkItemTimeLogStateCopyWithImpl<_WorkItemTimeLogState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'WorkItemTimeLogState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('groups', groups))..add(DiagnosticsProperty('tasks', tasks))..add(DiagnosticsProperty('errorMessage', errorMessage));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkItemTimeLogState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._groups, _groups)&&const DeepCollectionEquality().equals(other._tasks, _tasks)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_groups),const DeepCollectionEquality().hash(_tasks),errorMessage);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'WorkItemTimeLogState(isLoading: $isLoading, groups: $groups, tasks: $tasks, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$WorkItemTimeLogStateCopyWith<$Res> implements $WorkItemTimeLogStateCopyWith<$Res> {
  factory _$WorkItemTimeLogStateCopyWith(_WorkItemTimeLogState value, $Res Function(_WorkItemTimeLogState) _then) = __$WorkItemTimeLogStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<TaskTimeDayGroup> groups, List<WorkItem> tasks, String? errorMessage
});




}
/// @nodoc
class __$WorkItemTimeLogStateCopyWithImpl<$Res>
    implements _$WorkItemTimeLogStateCopyWith<$Res> {
  __$WorkItemTimeLogStateCopyWithImpl(this._self, this._then);

  final _WorkItemTimeLogState _self;
  final $Res Function(_WorkItemTimeLogState) _then;

/// Create a copy of WorkItemTimeLogState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? groups = null,Object? tasks = null,Object? errorMessage = freezed,}) {
  return _then(_WorkItemTimeLogState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<TaskTimeDayGroup>,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<WorkItem>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
