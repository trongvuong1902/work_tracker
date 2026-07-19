// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_item_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkItemDetailState {

 bool get isLoading; WorkItem? get task; bool get isTogglingDone; bool get isTogglingTimer; bool get isRefreshing;// True while a Zentao bug status change (resolve/close/reopen) is in flight.
 bool get isChangingStatus;// True while the bug's full detail (description/notes/attachments) is being
// fetched and persisted on first open.
 bool get isEnriching; String? get errorMessage;// Bumped every second while the timer runs purely to force a rebuild —
// not read by anything, the live elapsed time itself is recomputed via
// `WorkItem.currentElapsedSeconds()` in the widget.
 int get tick;
/// Create a copy of WorkItemDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkItemDetailStateCopyWith<WorkItemDetailState> get copyWith => _$WorkItemDetailStateCopyWithImpl<WorkItemDetailState>(this as WorkItemDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkItemDetailState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.task, task) || other.task == task)&&(identical(other.isTogglingDone, isTogglingDone) || other.isTogglingDone == isTogglingDone)&&(identical(other.isTogglingTimer, isTogglingTimer) || other.isTogglingTimer == isTogglingTimer)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isChangingStatus, isChangingStatus) || other.isChangingStatus == isChangingStatus)&&(identical(other.isEnriching, isEnriching) || other.isEnriching == isEnriching)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.tick, tick) || other.tick == tick));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,task,isTogglingDone,isTogglingTimer,isRefreshing,isChangingStatus,isEnriching,errorMessage,tick);

@override
String toString() {
  return 'WorkItemDetailState(isLoading: $isLoading, task: $task, isTogglingDone: $isTogglingDone, isTogglingTimer: $isTogglingTimer, isRefreshing: $isRefreshing, isChangingStatus: $isChangingStatus, isEnriching: $isEnriching, errorMessage: $errorMessage, tick: $tick)';
}


}

/// @nodoc
abstract mixin class $WorkItemDetailStateCopyWith<$Res>  {
  factory $WorkItemDetailStateCopyWith(WorkItemDetailState value, $Res Function(WorkItemDetailState) _then) = _$WorkItemDetailStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, WorkItem? task, bool isTogglingDone, bool isTogglingTimer, bool isRefreshing, bool isChangingStatus, bool isEnriching, String? errorMessage, int tick
});


$WorkItemCopyWith<$Res>? get task;

}
/// @nodoc
class _$WorkItemDetailStateCopyWithImpl<$Res>
    implements $WorkItemDetailStateCopyWith<$Res> {
  _$WorkItemDetailStateCopyWithImpl(this._self, this._then);

  final WorkItemDetailState _self;
  final $Res Function(WorkItemDetailState) _then;

/// Create a copy of WorkItemDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? task = freezed,Object? isTogglingDone = null,Object? isTogglingTimer = null,Object? isRefreshing = null,Object? isChangingStatus = null,Object? isEnriching = null,Object? errorMessage = freezed,Object? tick = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,task: freezed == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as WorkItem?,isTogglingDone: null == isTogglingDone ? _self.isTogglingDone : isTogglingDone // ignore: cast_nullable_to_non_nullable
as bool,isTogglingTimer: null == isTogglingTimer ? _self.isTogglingTimer : isTogglingTimer // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isChangingStatus: null == isChangingStatus ? _self.isChangingStatus : isChangingStatus // ignore: cast_nullable_to_non_nullable
as bool,isEnriching: null == isEnriching ? _self.isEnriching : isEnriching // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,tick: null == tick ? _self.tick : tick // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of WorkItemDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkItemCopyWith<$Res>? get task {
    if (_self.task == null) {
    return null;
  }

  return $WorkItemCopyWith<$Res>(_self.task!, (value) {
    return _then(_self.copyWith(task: value));
  });
}
}


/// Adds pattern-matching-related methods to [WorkItemDetailState].
extension WorkItemDetailStatePatterns on WorkItemDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkItemDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkItemDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkItemDetailState value)  $default,){
final _that = this;
switch (_that) {
case _WorkItemDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkItemDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _WorkItemDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  WorkItem? task,  bool isTogglingDone,  bool isTogglingTimer,  bool isRefreshing,  bool isChangingStatus,  bool isEnriching,  String? errorMessage,  int tick)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkItemDetailState() when $default != null:
return $default(_that.isLoading,_that.task,_that.isTogglingDone,_that.isTogglingTimer,_that.isRefreshing,_that.isChangingStatus,_that.isEnriching,_that.errorMessage,_that.tick);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  WorkItem? task,  bool isTogglingDone,  bool isTogglingTimer,  bool isRefreshing,  bool isChangingStatus,  bool isEnriching,  String? errorMessage,  int tick)  $default,) {final _that = this;
switch (_that) {
case _WorkItemDetailState():
return $default(_that.isLoading,_that.task,_that.isTogglingDone,_that.isTogglingTimer,_that.isRefreshing,_that.isChangingStatus,_that.isEnriching,_that.errorMessage,_that.tick);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  WorkItem? task,  bool isTogglingDone,  bool isTogglingTimer,  bool isRefreshing,  bool isChangingStatus,  bool isEnriching,  String? errorMessage,  int tick)?  $default,) {final _that = this;
switch (_that) {
case _WorkItemDetailState() when $default != null:
return $default(_that.isLoading,_that.task,_that.isTogglingDone,_that.isTogglingTimer,_that.isRefreshing,_that.isChangingStatus,_that.isEnriching,_that.errorMessage,_that.tick);case _:
  return null;

}
}

}

/// @nodoc


class _WorkItemDetailState implements WorkItemDetailState {
  const _WorkItemDetailState({this.isLoading = true, this.task, this.isTogglingDone = false, this.isTogglingTimer = false, this.isRefreshing = false, this.isChangingStatus = false, this.isEnriching = false, this.errorMessage, this.tick = 0});
  

@override@JsonKey() final  bool isLoading;
@override final  WorkItem? task;
@override@JsonKey() final  bool isTogglingDone;
@override@JsonKey() final  bool isTogglingTimer;
@override@JsonKey() final  bool isRefreshing;
// True while a Zentao bug status change (resolve/close/reopen) is in flight.
@override@JsonKey() final  bool isChangingStatus;
// True while the bug's full detail (description/notes/attachments) is being
// fetched and persisted on first open.
@override@JsonKey() final  bool isEnriching;
@override final  String? errorMessage;
// Bumped every second while the timer runs purely to force a rebuild —
// not read by anything, the live elapsed time itself is recomputed via
// `WorkItem.currentElapsedSeconds()` in the widget.
@override@JsonKey() final  int tick;

/// Create a copy of WorkItemDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkItemDetailStateCopyWith<_WorkItemDetailState> get copyWith => __$WorkItemDetailStateCopyWithImpl<_WorkItemDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkItemDetailState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.task, task) || other.task == task)&&(identical(other.isTogglingDone, isTogglingDone) || other.isTogglingDone == isTogglingDone)&&(identical(other.isTogglingTimer, isTogglingTimer) || other.isTogglingTimer == isTogglingTimer)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isChangingStatus, isChangingStatus) || other.isChangingStatus == isChangingStatus)&&(identical(other.isEnriching, isEnriching) || other.isEnriching == isEnriching)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.tick, tick) || other.tick == tick));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,task,isTogglingDone,isTogglingTimer,isRefreshing,isChangingStatus,isEnriching,errorMessage,tick);

@override
String toString() {
  return 'WorkItemDetailState(isLoading: $isLoading, task: $task, isTogglingDone: $isTogglingDone, isTogglingTimer: $isTogglingTimer, isRefreshing: $isRefreshing, isChangingStatus: $isChangingStatus, isEnriching: $isEnriching, errorMessage: $errorMessage, tick: $tick)';
}


}

/// @nodoc
abstract mixin class _$WorkItemDetailStateCopyWith<$Res> implements $WorkItemDetailStateCopyWith<$Res> {
  factory _$WorkItemDetailStateCopyWith(_WorkItemDetailState value, $Res Function(_WorkItemDetailState) _then) = __$WorkItemDetailStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, WorkItem? task, bool isTogglingDone, bool isTogglingTimer, bool isRefreshing, bool isChangingStatus, bool isEnriching, String? errorMessage, int tick
});


@override $WorkItemCopyWith<$Res>? get task;

}
/// @nodoc
class __$WorkItemDetailStateCopyWithImpl<$Res>
    implements _$WorkItemDetailStateCopyWith<$Res> {
  __$WorkItemDetailStateCopyWithImpl(this._self, this._then);

  final _WorkItemDetailState _self;
  final $Res Function(_WorkItemDetailState) _then;

/// Create a copy of WorkItemDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? task = freezed,Object? isTogglingDone = null,Object? isTogglingTimer = null,Object? isRefreshing = null,Object? isChangingStatus = null,Object? isEnriching = null,Object? errorMessage = freezed,Object? tick = null,}) {
  return _then(_WorkItemDetailState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,task: freezed == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as WorkItem?,isTogglingDone: null == isTogglingDone ? _self.isTogglingDone : isTogglingDone // ignore: cast_nullable_to_non_nullable
as bool,isTogglingTimer: null == isTogglingTimer ? _self.isTogglingTimer : isTogglingTimer // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isChangingStatus: null == isChangingStatus ? _self.isChangingStatus : isChangingStatus // ignore: cast_nullable_to_non_nullable
as bool,isEnriching: null == isEnriching ? _self.isEnriching : isEnriching // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,tick: null == tick ? _self.tick : tick // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of WorkItemDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkItemCopyWith<$Res>? get task {
    if (_self.task == null) {
    return null;
  }

  return $WorkItemCopyWith<$Res>(_self.task!, (value) {
    return _then(_self.copyWith(task: value));
  });
}
}

// dart format on
