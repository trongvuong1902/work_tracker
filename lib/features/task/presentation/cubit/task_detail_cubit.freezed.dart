// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskDetailState {

 bool get isLoading; Task? get task; bool get isTogglingDone; bool get isTogglingTimer; bool get isRefreshing; String? get errorMessage;// Bumped every second while the timer runs purely to force a rebuild —
// not read by anything, the live elapsed time itself is recomputed via
// `Task.currentElapsedSeconds()` in the widget.
 int get tick;
/// Create a copy of TaskDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskDetailStateCopyWith<TaskDetailState> get copyWith => _$TaskDetailStateCopyWithImpl<TaskDetailState>(this as TaskDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskDetailState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.task, task) || other.task == task)&&(identical(other.isTogglingDone, isTogglingDone) || other.isTogglingDone == isTogglingDone)&&(identical(other.isTogglingTimer, isTogglingTimer) || other.isTogglingTimer == isTogglingTimer)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.tick, tick) || other.tick == tick));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,task,isTogglingDone,isTogglingTimer,isRefreshing,errorMessage,tick);

@override
String toString() {
  return 'TaskDetailState(isLoading: $isLoading, task: $task, isTogglingDone: $isTogglingDone, isTogglingTimer: $isTogglingTimer, isRefreshing: $isRefreshing, errorMessage: $errorMessage, tick: $tick)';
}


}

/// @nodoc
abstract mixin class $TaskDetailStateCopyWith<$Res>  {
  factory $TaskDetailStateCopyWith(TaskDetailState value, $Res Function(TaskDetailState) _then) = _$TaskDetailStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, Task? task, bool isTogglingDone, bool isTogglingTimer, bool isRefreshing, String? errorMessage, int tick
});


$TaskCopyWith<$Res>? get task;

}
/// @nodoc
class _$TaskDetailStateCopyWithImpl<$Res>
    implements $TaskDetailStateCopyWith<$Res> {
  _$TaskDetailStateCopyWithImpl(this._self, this._then);

  final TaskDetailState _self;
  final $Res Function(TaskDetailState) _then;

/// Create a copy of TaskDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? task = freezed,Object? isTogglingDone = null,Object? isTogglingTimer = null,Object? isRefreshing = null,Object? errorMessage = freezed,Object? tick = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,task: freezed == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as Task?,isTogglingDone: null == isTogglingDone ? _self.isTogglingDone : isTogglingDone // ignore: cast_nullable_to_non_nullable
as bool,isTogglingTimer: null == isTogglingTimer ? _self.isTogglingTimer : isTogglingTimer // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,tick: null == tick ? _self.tick : tick // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of TaskDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskCopyWith<$Res>? get task {
    if (_self.task == null) {
    return null;
  }

  return $TaskCopyWith<$Res>(_self.task!, (value) {
    return _then(_self.copyWith(task: value));
  });
}
}


/// Adds pattern-matching-related methods to [TaskDetailState].
extension TaskDetailStatePatterns on TaskDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskDetailState value)  $default,){
final _that = this;
switch (_that) {
case _TaskDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _TaskDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  Task? task,  bool isTogglingDone,  bool isTogglingTimer,  bool isRefreshing,  String? errorMessage,  int tick)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskDetailState() when $default != null:
return $default(_that.isLoading,_that.task,_that.isTogglingDone,_that.isTogglingTimer,_that.isRefreshing,_that.errorMessage,_that.tick);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  Task? task,  bool isTogglingDone,  bool isTogglingTimer,  bool isRefreshing,  String? errorMessage,  int tick)  $default,) {final _that = this;
switch (_that) {
case _TaskDetailState():
return $default(_that.isLoading,_that.task,_that.isTogglingDone,_that.isTogglingTimer,_that.isRefreshing,_that.errorMessage,_that.tick);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  Task? task,  bool isTogglingDone,  bool isTogglingTimer,  bool isRefreshing,  String? errorMessage,  int tick)?  $default,) {final _that = this;
switch (_that) {
case _TaskDetailState() when $default != null:
return $default(_that.isLoading,_that.task,_that.isTogglingDone,_that.isTogglingTimer,_that.isRefreshing,_that.errorMessage,_that.tick);case _:
  return null;

}
}

}

/// @nodoc


class _TaskDetailState implements TaskDetailState {
  const _TaskDetailState({this.isLoading = true, this.task, this.isTogglingDone = false, this.isTogglingTimer = false, this.isRefreshing = false, this.errorMessage, this.tick = 0});
  

@override@JsonKey() final  bool isLoading;
@override final  Task? task;
@override@JsonKey() final  bool isTogglingDone;
@override@JsonKey() final  bool isTogglingTimer;
@override@JsonKey() final  bool isRefreshing;
@override final  String? errorMessage;
// Bumped every second while the timer runs purely to force a rebuild —
// not read by anything, the live elapsed time itself is recomputed via
// `Task.currentElapsedSeconds()` in the widget.
@override@JsonKey() final  int tick;

/// Create a copy of TaskDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskDetailStateCopyWith<_TaskDetailState> get copyWith => __$TaskDetailStateCopyWithImpl<_TaskDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskDetailState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.task, task) || other.task == task)&&(identical(other.isTogglingDone, isTogglingDone) || other.isTogglingDone == isTogglingDone)&&(identical(other.isTogglingTimer, isTogglingTimer) || other.isTogglingTimer == isTogglingTimer)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.tick, tick) || other.tick == tick));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,task,isTogglingDone,isTogglingTimer,isRefreshing,errorMessage,tick);

@override
String toString() {
  return 'TaskDetailState(isLoading: $isLoading, task: $task, isTogglingDone: $isTogglingDone, isTogglingTimer: $isTogglingTimer, isRefreshing: $isRefreshing, errorMessage: $errorMessage, tick: $tick)';
}


}

/// @nodoc
abstract mixin class _$TaskDetailStateCopyWith<$Res> implements $TaskDetailStateCopyWith<$Res> {
  factory _$TaskDetailStateCopyWith(_TaskDetailState value, $Res Function(_TaskDetailState) _then) = __$TaskDetailStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, Task? task, bool isTogglingDone, bool isTogglingTimer, bool isRefreshing, String? errorMessage, int tick
});


@override $TaskCopyWith<$Res>? get task;

}
/// @nodoc
class __$TaskDetailStateCopyWithImpl<$Res>
    implements _$TaskDetailStateCopyWith<$Res> {
  __$TaskDetailStateCopyWithImpl(this._self, this._then);

  final _TaskDetailState _self;
  final $Res Function(_TaskDetailState) _then;

/// Create a copy of TaskDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? task = freezed,Object? isTogglingDone = null,Object? isTogglingTimer = null,Object? isRefreshing = null,Object? errorMessage = freezed,Object? tick = null,}) {
  return _then(_TaskDetailState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,task: freezed == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as Task?,isTogglingDone: null == isTogglingDone ? _self.isTogglingDone : isTogglingDone // ignore: cast_nullable_to_non_nullable
as bool,isTogglingTimer: null == isTogglingTimer ? _self.isTogglingTimer : isTogglingTimer // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,tick: null == tick ? _self.tick : tick // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of TaskDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskCopyWith<$Res>? get task {
    if (_self.task == null) {
    return null;
  }

  return $TaskCopyWith<$Res>(_self.task!, (value) {
    return _then(_self.copyWith(task: value));
  });
}
}

// dart format on
