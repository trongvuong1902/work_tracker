// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_time_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskTimeSession {

 int get id; int get taskId; DateTime get start; DateTime get end;
/// Create a copy of TaskTimeSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskTimeSessionCopyWith<TaskTimeSession> get copyWith => _$TaskTimeSessionCopyWithImpl<TaskTimeSession>(this as TaskTimeSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskTimeSession&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode => Object.hash(runtimeType,id,taskId,start,end);

@override
String toString() {
  return 'TaskTimeSession(id: $id, taskId: $taskId, start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $TaskTimeSessionCopyWith<$Res>  {
  factory $TaskTimeSessionCopyWith(TaskTimeSession value, $Res Function(TaskTimeSession) _then) = _$TaskTimeSessionCopyWithImpl;
@useResult
$Res call({
 int id, int taskId, DateTime start, DateTime end
});




}
/// @nodoc
class _$TaskTimeSessionCopyWithImpl<$Res>
    implements $TaskTimeSessionCopyWith<$Res> {
  _$TaskTimeSessionCopyWithImpl(this._self, this._then);

  final TaskTimeSession _self;
  final $Res Function(TaskTimeSession) _then;

/// Create a copy of TaskTimeSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? taskId = null,Object? start = null,Object? end = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as int,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskTimeSession].
extension TaskTimeSessionPatterns on TaskTimeSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskTimeSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskTimeSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskTimeSession value)  $default,){
final _that = this;
switch (_that) {
case _TaskTimeSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskTimeSession value)?  $default,){
final _that = this;
switch (_that) {
case _TaskTimeSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int taskId,  DateTime start,  DateTime end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskTimeSession() when $default != null:
return $default(_that.id,_that.taskId,_that.start,_that.end);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int taskId,  DateTime start,  DateTime end)  $default,) {final _that = this;
switch (_that) {
case _TaskTimeSession():
return $default(_that.id,_that.taskId,_that.start,_that.end);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int taskId,  DateTime start,  DateTime end)?  $default,) {final _that = this;
switch (_that) {
case _TaskTimeSession() when $default != null:
return $default(_that.id,_that.taskId,_that.start,_that.end);case _:
  return null;

}
}

}

/// @nodoc


class _TaskTimeSession extends TaskTimeSession {
  const _TaskTimeSession({required this.id, required this.taskId, required this.start, required this.end}): super._();
  

@override final  int id;
@override final  int taskId;
@override final  DateTime start;
@override final  DateTime end;

/// Create a copy of TaskTimeSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskTimeSessionCopyWith<_TaskTimeSession> get copyWith => __$TaskTimeSessionCopyWithImpl<_TaskTimeSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskTimeSession&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode => Object.hash(runtimeType,id,taskId,start,end);

@override
String toString() {
  return 'TaskTimeSession(id: $id, taskId: $taskId, start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$TaskTimeSessionCopyWith<$Res> implements $TaskTimeSessionCopyWith<$Res> {
  factory _$TaskTimeSessionCopyWith(_TaskTimeSession value, $Res Function(_TaskTimeSession) _then) = __$TaskTimeSessionCopyWithImpl;
@override @useResult
$Res call({
 int id, int taskId, DateTime start, DateTime end
});




}
/// @nodoc
class __$TaskTimeSessionCopyWithImpl<$Res>
    implements _$TaskTimeSessionCopyWith<$Res> {
  __$TaskTimeSessionCopyWithImpl(this._self, this._then);

  final _TaskTimeSession _self;
  final $Res Function(_TaskTimeSession) _then;

/// Create a copy of TaskTimeSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? taskId = null,Object? start = null,Object? end = null,}) {
  return _then(_TaskTimeSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as int,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
