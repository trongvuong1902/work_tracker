// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_time_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskTimeLog {

 int get id; int get taskId; DateTime get day; int get seconds;
/// Create a copy of TaskTimeLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskTimeLogCopyWith<TaskTimeLog> get copyWith => _$TaskTimeLogCopyWithImpl<TaskTimeLog>(this as TaskTimeLog, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskTimeLog&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.day, day) || other.day == day)&&(identical(other.seconds, seconds) || other.seconds == seconds));
}


@override
int get hashCode => Object.hash(runtimeType,id,taskId,day,seconds);

@override
String toString() {
  return 'TaskTimeLog(id: $id, taskId: $taskId, day: $day, seconds: $seconds)';
}


}

/// @nodoc
abstract mixin class $TaskTimeLogCopyWith<$Res>  {
  factory $TaskTimeLogCopyWith(TaskTimeLog value, $Res Function(TaskTimeLog) _then) = _$TaskTimeLogCopyWithImpl;
@useResult
$Res call({
 int id, int taskId, DateTime day, int seconds
});




}
/// @nodoc
class _$TaskTimeLogCopyWithImpl<$Res>
    implements $TaskTimeLogCopyWith<$Res> {
  _$TaskTimeLogCopyWithImpl(this._self, this._then);

  final TaskTimeLog _self;
  final $Res Function(TaskTimeLog) _then;

/// Create a copy of TaskTimeLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? taskId = null,Object? day = null,Object? seconds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,seconds: null == seconds ? _self.seconds : seconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskTimeLog].
extension TaskTimeLogPatterns on TaskTimeLog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskTimeLog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskTimeLog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskTimeLog value)  $default,){
final _that = this;
switch (_that) {
case _TaskTimeLog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskTimeLog value)?  $default,){
final _that = this;
switch (_that) {
case _TaskTimeLog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int taskId,  DateTime day,  int seconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskTimeLog() when $default != null:
return $default(_that.id,_that.taskId,_that.day,_that.seconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int taskId,  DateTime day,  int seconds)  $default,) {final _that = this;
switch (_that) {
case _TaskTimeLog():
return $default(_that.id,_that.taskId,_that.day,_that.seconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int taskId,  DateTime day,  int seconds)?  $default,) {final _that = this;
switch (_that) {
case _TaskTimeLog() when $default != null:
return $default(_that.id,_that.taskId,_that.day,_that.seconds);case _:
  return null;

}
}

}

/// @nodoc


class _TaskTimeLog implements TaskTimeLog {
  const _TaskTimeLog({required this.id, required this.taskId, required this.day, required this.seconds});
  

@override final  int id;
@override final  int taskId;
@override final  DateTime day;
@override final  int seconds;

/// Create a copy of TaskTimeLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskTimeLogCopyWith<_TaskTimeLog> get copyWith => __$TaskTimeLogCopyWithImpl<_TaskTimeLog>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskTimeLog&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.day, day) || other.day == day)&&(identical(other.seconds, seconds) || other.seconds == seconds));
}


@override
int get hashCode => Object.hash(runtimeType,id,taskId,day,seconds);

@override
String toString() {
  return 'TaskTimeLog(id: $id, taskId: $taskId, day: $day, seconds: $seconds)';
}


}

/// @nodoc
abstract mixin class _$TaskTimeLogCopyWith<$Res> implements $TaskTimeLogCopyWith<$Res> {
  factory _$TaskTimeLogCopyWith(_TaskTimeLog value, $Res Function(_TaskTimeLog) _then) = __$TaskTimeLogCopyWithImpl;
@override @useResult
$Res call({
 int id, int taskId, DateTime day, int seconds
});




}
/// @nodoc
class __$TaskTimeLogCopyWithImpl<$Res>
    implements _$TaskTimeLogCopyWith<$Res> {
  __$TaskTimeLogCopyWithImpl(this._self, this._then);

  final _TaskTimeLog _self;
  final $Res Function(_TaskTimeLog) _then;

/// Create a copy of TaskTimeLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? taskId = null,Object? day = null,Object? seconds = null,}) {
  return _then(_TaskTimeLog(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,seconds: null == seconds ? _self.seconds : seconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
