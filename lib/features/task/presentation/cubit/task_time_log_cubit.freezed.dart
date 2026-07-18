// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_time_log_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskTimeLogState implements DiagnosticableTreeMixin {

 bool get isLoading; List<TaskTimeDayGroup> get groups; List<Task> get tasks; String? get errorMessage;
/// Create a copy of TaskTimeLogState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskTimeLogStateCopyWith<TaskTimeLogState> get copyWith => _$TaskTimeLogStateCopyWithImpl<TaskTimeLogState>(this as TaskTimeLogState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TaskTimeLogState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('groups', groups))..add(DiagnosticsProperty('tasks', tasks))..add(DiagnosticsProperty('errorMessage', errorMessage));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskTimeLogState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.groups, groups)&&const DeepCollectionEquality().equals(other.tasks, tasks)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(groups),const DeepCollectionEquality().hash(tasks),errorMessage);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TaskTimeLogState(isLoading: $isLoading, groups: $groups, tasks: $tasks, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $TaskTimeLogStateCopyWith<$Res>  {
  factory $TaskTimeLogStateCopyWith(TaskTimeLogState value, $Res Function(TaskTimeLogState) _then) = _$TaskTimeLogStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<TaskTimeDayGroup> groups, List<Task> tasks, String? errorMessage
});




}
/// @nodoc
class _$TaskTimeLogStateCopyWithImpl<$Res>
    implements $TaskTimeLogStateCopyWith<$Res> {
  _$TaskTimeLogStateCopyWithImpl(this._self, this._then);

  final TaskTimeLogState _self;
  final $Res Function(TaskTimeLogState) _then;

/// Create a copy of TaskTimeLogState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? groups = null,Object? tasks = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<TaskTimeDayGroup>,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskTimeLogState].
extension TaskTimeLogStatePatterns on TaskTimeLogState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskTimeLogState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskTimeLogState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskTimeLogState value)  $default,){
final _that = this;
switch (_that) {
case _TaskTimeLogState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskTimeLogState value)?  $default,){
final _that = this;
switch (_that) {
case _TaskTimeLogState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<TaskTimeDayGroup> groups,  List<Task> tasks,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskTimeLogState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<TaskTimeDayGroup> groups,  List<Task> tasks,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TaskTimeLogState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<TaskTimeDayGroup> groups,  List<Task> tasks,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TaskTimeLogState() when $default != null:
return $default(_that.isLoading,_that.groups,_that.tasks,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TaskTimeLogState with DiagnosticableTreeMixin implements TaskTimeLogState {
  const _TaskTimeLogState({this.isLoading = true, final  List<TaskTimeDayGroup> groups = const <TaskTimeDayGroup>[], final  List<Task> tasks = const <Task>[], this.errorMessage}): _groups = groups,_tasks = tasks;
  

@override@JsonKey() final  bool isLoading;
 final  List<TaskTimeDayGroup> _groups;
@override@JsonKey() List<TaskTimeDayGroup> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}

 final  List<Task> _tasks;
@override@JsonKey() List<Task> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}

@override final  String? errorMessage;

/// Create a copy of TaskTimeLogState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskTimeLogStateCopyWith<_TaskTimeLogState> get copyWith => __$TaskTimeLogStateCopyWithImpl<_TaskTimeLogState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TaskTimeLogState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('groups', groups))..add(DiagnosticsProperty('tasks', tasks))..add(DiagnosticsProperty('errorMessage', errorMessage));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskTimeLogState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._groups, _groups)&&const DeepCollectionEquality().equals(other._tasks, _tasks)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_groups),const DeepCollectionEquality().hash(_tasks),errorMessage);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TaskTimeLogState(isLoading: $isLoading, groups: $groups, tasks: $tasks, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TaskTimeLogStateCopyWith<$Res> implements $TaskTimeLogStateCopyWith<$Res> {
  factory _$TaskTimeLogStateCopyWith(_TaskTimeLogState value, $Res Function(_TaskTimeLogState) _then) = __$TaskTimeLogStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<TaskTimeDayGroup> groups, List<Task> tasks, String? errorMessage
});




}
/// @nodoc
class __$TaskTimeLogStateCopyWithImpl<$Res>
    implements _$TaskTimeLogStateCopyWith<$Res> {
  __$TaskTimeLogStateCopyWithImpl(this._self, this._then);

  final _TaskTimeLogState _self;
  final $Res Function(_TaskTimeLogState) _then;

/// Create a copy of TaskTimeLogState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? groups = null,Object? tasks = null,Object? errorMessage = freezed,}) {
  return _then(_TaskTimeLogState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<TaskTimeDayGroup>,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
