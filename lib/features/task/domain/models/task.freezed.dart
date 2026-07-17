// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Task {

 int get id; String get title; String? get description; bool get done; DateTime get createdAt; int? get zentaoTaskId; int? get zentaoBugId; String? get zentaoStatus; int? get priority; String? get notes; List<ZentaoBugAttachment> get attachments; int? get zentaoPriority; int? get zentaoSeverity; int? get zentaoProductId; String? get zentaoProductName; int? get zentaoProductPriority; DateTime? get zentaoLastSyncedAt; DateTime? get zentaoDetailSyncedAt; int get elapsedSeconds; DateTime? get timerStartedAt;
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCopyWith<Task> get copyWith => _$TaskCopyWithImpl<Task>(this as Task, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Task&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.done, done) || other.done == done)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.zentaoTaskId, zentaoTaskId) || other.zentaoTaskId == zentaoTaskId)&&(identical(other.zentaoBugId, zentaoBugId) || other.zentaoBugId == zentaoBugId)&&(identical(other.zentaoStatus, zentaoStatus) || other.zentaoStatus == zentaoStatus)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.attachments, attachments)&&(identical(other.zentaoPriority, zentaoPriority) || other.zentaoPriority == zentaoPriority)&&(identical(other.zentaoSeverity, zentaoSeverity) || other.zentaoSeverity == zentaoSeverity)&&(identical(other.zentaoProductId, zentaoProductId) || other.zentaoProductId == zentaoProductId)&&(identical(other.zentaoProductName, zentaoProductName) || other.zentaoProductName == zentaoProductName)&&(identical(other.zentaoProductPriority, zentaoProductPriority) || other.zentaoProductPriority == zentaoProductPriority)&&(identical(other.zentaoLastSyncedAt, zentaoLastSyncedAt) || other.zentaoLastSyncedAt == zentaoLastSyncedAt)&&(identical(other.zentaoDetailSyncedAt, zentaoDetailSyncedAt) || other.zentaoDetailSyncedAt == zentaoDetailSyncedAt)&&(identical(other.elapsedSeconds, elapsedSeconds) || other.elapsedSeconds == elapsedSeconds)&&(identical(other.timerStartedAt, timerStartedAt) || other.timerStartedAt == timerStartedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,done,createdAt,zentaoTaskId,zentaoBugId,zentaoStatus,priority,notes,const DeepCollectionEquality().hash(attachments),zentaoPriority,zentaoSeverity,zentaoProductId,zentaoProductName,zentaoProductPriority,zentaoLastSyncedAt,zentaoDetailSyncedAt,elapsedSeconds,timerStartedAt]);

@override
String toString() {
  return 'Task(id: $id, title: $title, description: $description, done: $done, createdAt: $createdAt, zentaoTaskId: $zentaoTaskId, zentaoBugId: $zentaoBugId, zentaoStatus: $zentaoStatus, priority: $priority, notes: $notes, attachments: $attachments, zentaoPriority: $zentaoPriority, zentaoSeverity: $zentaoSeverity, zentaoProductId: $zentaoProductId, zentaoProductName: $zentaoProductName, zentaoProductPriority: $zentaoProductPriority, zentaoLastSyncedAt: $zentaoLastSyncedAt, zentaoDetailSyncedAt: $zentaoDetailSyncedAt, elapsedSeconds: $elapsedSeconds, timerStartedAt: $timerStartedAt)';
}


}

/// @nodoc
abstract mixin class $TaskCopyWith<$Res>  {
  factory $TaskCopyWith(Task value, $Res Function(Task) _then) = _$TaskCopyWithImpl;
@useResult
$Res call({
 int id, String title, String? description, bool done, DateTime createdAt, int? zentaoTaskId, int? zentaoBugId, String? zentaoStatus, int? priority, String? notes, List<ZentaoBugAttachment> attachments, int? zentaoPriority, int? zentaoSeverity, int? zentaoProductId, String? zentaoProductName, int? zentaoProductPriority, DateTime? zentaoLastSyncedAt, DateTime? zentaoDetailSyncedAt, int elapsedSeconds, DateTime? timerStartedAt
});




}
/// @nodoc
class _$TaskCopyWithImpl<$Res>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._self, this._then);

  final Task _self;
  final $Res Function(Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? done = null,Object? createdAt = null,Object? zentaoTaskId = freezed,Object? zentaoBugId = freezed,Object? zentaoStatus = freezed,Object? priority = freezed,Object? notes = freezed,Object? attachments = null,Object? zentaoPriority = freezed,Object? zentaoSeverity = freezed,Object? zentaoProductId = freezed,Object? zentaoProductName = freezed,Object? zentaoProductPriority = freezed,Object? zentaoLastSyncedAt = freezed,Object? zentaoDetailSyncedAt = freezed,Object? elapsedSeconds = null,Object? timerStartedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,zentaoTaskId: freezed == zentaoTaskId ? _self.zentaoTaskId : zentaoTaskId // ignore: cast_nullable_to_non_nullable
as int?,zentaoBugId: freezed == zentaoBugId ? _self.zentaoBugId : zentaoBugId // ignore: cast_nullable_to_non_nullable
as int?,zentaoStatus: freezed == zentaoStatus ? _self.zentaoStatus : zentaoStatus // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<ZentaoBugAttachment>,zentaoPriority: freezed == zentaoPriority ? _self.zentaoPriority : zentaoPriority // ignore: cast_nullable_to_non_nullable
as int?,zentaoSeverity: freezed == zentaoSeverity ? _self.zentaoSeverity : zentaoSeverity // ignore: cast_nullable_to_non_nullable
as int?,zentaoProductId: freezed == zentaoProductId ? _self.zentaoProductId : zentaoProductId // ignore: cast_nullable_to_non_nullable
as int?,zentaoProductName: freezed == zentaoProductName ? _self.zentaoProductName : zentaoProductName // ignore: cast_nullable_to_non_nullable
as String?,zentaoProductPriority: freezed == zentaoProductPriority ? _self.zentaoProductPriority : zentaoProductPriority // ignore: cast_nullable_to_non_nullable
as int?,zentaoLastSyncedAt: freezed == zentaoLastSyncedAt ? _self.zentaoLastSyncedAt : zentaoLastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,zentaoDetailSyncedAt: freezed == zentaoDetailSyncedAt ? _self.zentaoDetailSyncedAt : zentaoDetailSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,elapsedSeconds: null == elapsedSeconds ? _self.elapsedSeconds : elapsedSeconds // ignore: cast_nullable_to_non_nullable
as int,timerStartedAt: freezed == timerStartedAt ? _self.timerStartedAt : timerStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Task].
extension TaskPatterns on Task {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Task value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Task value)  $default,){
final _that = this;
switch (_that) {
case _Task():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Task value)?  $default,){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String? description,  bool done,  DateTime createdAt,  int? zentaoTaskId,  int? zentaoBugId,  String? zentaoStatus,  int? priority,  String? notes,  List<ZentaoBugAttachment> attachments,  int? zentaoPriority,  int? zentaoSeverity,  int? zentaoProductId,  String? zentaoProductName,  int? zentaoProductPriority,  DateTime? zentaoLastSyncedAt,  DateTime? zentaoDetailSyncedAt,  int elapsedSeconds,  DateTime? timerStartedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.done,_that.createdAt,_that.zentaoTaskId,_that.zentaoBugId,_that.zentaoStatus,_that.priority,_that.notes,_that.attachments,_that.zentaoPriority,_that.zentaoSeverity,_that.zentaoProductId,_that.zentaoProductName,_that.zentaoProductPriority,_that.zentaoLastSyncedAt,_that.zentaoDetailSyncedAt,_that.elapsedSeconds,_that.timerStartedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String? description,  bool done,  DateTime createdAt,  int? zentaoTaskId,  int? zentaoBugId,  String? zentaoStatus,  int? priority,  String? notes,  List<ZentaoBugAttachment> attachments,  int? zentaoPriority,  int? zentaoSeverity,  int? zentaoProductId,  String? zentaoProductName,  int? zentaoProductPriority,  DateTime? zentaoLastSyncedAt,  DateTime? zentaoDetailSyncedAt,  int elapsedSeconds,  DateTime? timerStartedAt)  $default,) {final _that = this;
switch (_that) {
case _Task():
return $default(_that.id,_that.title,_that.description,_that.done,_that.createdAt,_that.zentaoTaskId,_that.zentaoBugId,_that.zentaoStatus,_that.priority,_that.notes,_that.attachments,_that.zentaoPriority,_that.zentaoSeverity,_that.zentaoProductId,_that.zentaoProductName,_that.zentaoProductPriority,_that.zentaoLastSyncedAt,_that.zentaoDetailSyncedAt,_that.elapsedSeconds,_that.timerStartedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String? description,  bool done,  DateTime createdAt,  int? zentaoTaskId,  int? zentaoBugId,  String? zentaoStatus,  int? priority,  String? notes,  List<ZentaoBugAttachment> attachments,  int? zentaoPriority,  int? zentaoSeverity,  int? zentaoProductId,  String? zentaoProductName,  int? zentaoProductPriority,  DateTime? zentaoLastSyncedAt,  DateTime? zentaoDetailSyncedAt,  int elapsedSeconds,  DateTime? timerStartedAt)?  $default,) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.done,_that.createdAt,_that.zentaoTaskId,_that.zentaoBugId,_that.zentaoStatus,_that.priority,_that.notes,_that.attachments,_that.zentaoPriority,_that.zentaoSeverity,_that.zentaoProductId,_that.zentaoProductName,_that.zentaoProductPriority,_that.zentaoLastSyncedAt,_that.zentaoDetailSyncedAt,_that.elapsedSeconds,_that.timerStartedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Task implements Task {
  const _Task({required this.id, required this.title, this.description, required this.done, required this.createdAt, this.zentaoTaskId, this.zentaoBugId, this.zentaoStatus, this.priority, this.notes, final  List<ZentaoBugAttachment> attachments = const <ZentaoBugAttachment>[], this.zentaoPriority, this.zentaoSeverity, this.zentaoProductId, this.zentaoProductName, this.zentaoProductPriority, this.zentaoLastSyncedAt, this.zentaoDetailSyncedAt, required this.elapsedSeconds, this.timerStartedAt}): _attachments = attachments;
  

@override final  int id;
@override final  String title;
@override final  String? description;
@override final  bool done;
@override final  DateTime createdAt;
@override final  int? zentaoTaskId;
@override final  int? zentaoBugId;
@override final  String? zentaoStatus;
@override final  int? priority;
@override final  String? notes;
 final  List<ZentaoBugAttachment> _attachments;
@override@JsonKey() List<ZentaoBugAttachment> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}

@override final  int? zentaoPriority;
@override final  int? zentaoSeverity;
@override final  int? zentaoProductId;
@override final  String? zentaoProductName;
@override final  int? zentaoProductPriority;
@override final  DateTime? zentaoLastSyncedAt;
@override final  DateTime? zentaoDetailSyncedAt;
@override final  int elapsedSeconds;
@override final  DateTime? timerStartedAt;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCopyWith<_Task> get copyWith => __$TaskCopyWithImpl<_Task>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Task&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.done, done) || other.done == done)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.zentaoTaskId, zentaoTaskId) || other.zentaoTaskId == zentaoTaskId)&&(identical(other.zentaoBugId, zentaoBugId) || other.zentaoBugId == zentaoBugId)&&(identical(other.zentaoStatus, zentaoStatus) || other.zentaoStatus == zentaoStatus)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._attachments, _attachments)&&(identical(other.zentaoPriority, zentaoPriority) || other.zentaoPriority == zentaoPriority)&&(identical(other.zentaoSeverity, zentaoSeverity) || other.zentaoSeverity == zentaoSeverity)&&(identical(other.zentaoProductId, zentaoProductId) || other.zentaoProductId == zentaoProductId)&&(identical(other.zentaoProductName, zentaoProductName) || other.zentaoProductName == zentaoProductName)&&(identical(other.zentaoProductPriority, zentaoProductPriority) || other.zentaoProductPriority == zentaoProductPriority)&&(identical(other.zentaoLastSyncedAt, zentaoLastSyncedAt) || other.zentaoLastSyncedAt == zentaoLastSyncedAt)&&(identical(other.zentaoDetailSyncedAt, zentaoDetailSyncedAt) || other.zentaoDetailSyncedAt == zentaoDetailSyncedAt)&&(identical(other.elapsedSeconds, elapsedSeconds) || other.elapsedSeconds == elapsedSeconds)&&(identical(other.timerStartedAt, timerStartedAt) || other.timerStartedAt == timerStartedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,done,createdAt,zentaoTaskId,zentaoBugId,zentaoStatus,priority,notes,const DeepCollectionEquality().hash(_attachments),zentaoPriority,zentaoSeverity,zentaoProductId,zentaoProductName,zentaoProductPriority,zentaoLastSyncedAt,zentaoDetailSyncedAt,elapsedSeconds,timerStartedAt]);

@override
String toString() {
  return 'Task(id: $id, title: $title, description: $description, done: $done, createdAt: $createdAt, zentaoTaskId: $zentaoTaskId, zentaoBugId: $zentaoBugId, zentaoStatus: $zentaoStatus, priority: $priority, notes: $notes, attachments: $attachments, zentaoPriority: $zentaoPriority, zentaoSeverity: $zentaoSeverity, zentaoProductId: $zentaoProductId, zentaoProductName: $zentaoProductName, zentaoProductPriority: $zentaoProductPriority, zentaoLastSyncedAt: $zentaoLastSyncedAt, zentaoDetailSyncedAt: $zentaoDetailSyncedAt, elapsedSeconds: $elapsedSeconds, timerStartedAt: $timerStartedAt)';
}


}

/// @nodoc
abstract mixin class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) _then) = __$TaskCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String? description, bool done, DateTime createdAt, int? zentaoTaskId, int? zentaoBugId, String? zentaoStatus, int? priority, String? notes, List<ZentaoBugAttachment> attachments, int? zentaoPriority, int? zentaoSeverity, int? zentaoProductId, String? zentaoProductName, int? zentaoProductPriority, DateTime? zentaoLastSyncedAt, DateTime? zentaoDetailSyncedAt, int elapsedSeconds, DateTime? timerStartedAt
});




}
/// @nodoc
class __$TaskCopyWithImpl<$Res>
    implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(this._self, this._then);

  final _Task _self;
  final $Res Function(_Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? done = null,Object? createdAt = null,Object? zentaoTaskId = freezed,Object? zentaoBugId = freezed,Object? zentaoStatus = freezed,Object? priority = freezed,Object? notes = freezed,Object? attachments = null,Object? zentaoPriority = freezed,Object? zentaoSeverity = freezed,Object? zentaoProductId = freezed,Object? zentaoProductName = freezed,Object? zentaoProductPriority = freezed,Object? zentaoLastSyncedAt = freezed,Object? zentaoDetailSyncedAt = freezed,Object? elapsedSeconds = null,Object? timerStartedAt = freezed,}) {
  return _then(_Task(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,zentaoTaskId: freezed == zentaoTaskId ? _self.zentaoTaskId : zentaoTaskId // ignore: cast_nullable_to_non_nullable
as int?,zentaoBugId: freezed == zentaoBugId ? _self.zentaoBugId : zentaoBugId // ignore: cast_nullable_to_non_nullable
as int?,zentaoStatus: freezed == zentaoStatus ? _self.zentaoStatus : zentaoStatus // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<ZentaoBugAttachment>,zentaoPriority: freezed == zentaoPriority ? _self.zentaoPriority : zentaoPriority // ignore: cast_nullable_to_non_nullable
as int?,zentaoSeverity: freezed == zentaoSeverity ? _self.zentaoSeverity : zentaoSeverity // ignore: cast_nullable_to_non_nullable
as int?,zentaoProductId: freezed == zentaoProductId ? _self.zentaoProductId : zentaoProductId // ignore: cast_nullable_to_non_nullable
as int?,zentaoProductName: freezed == zentaoProductName ? _self.zentaoProductName : zentaoProductName // ignore: cast_nullable_to_non_nullable
as String?,zentaoProductPriority: freezed == zentaoProductPriority ? _self.zentaoProductPriority : zentaoProductPriority // ignore: cast_nullable_to_non_nullable
as int?,zentaoLastSyncedAt: freezed == zentaoLastSyncedAt ? _self.zentaoLastSyncedAt : zentaoLastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,zentaoDetailSyncedAt: freezed == zentaoDetailSyncedAt ? _self.zentaoDetailSyncedAt : zentaoDetailSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,elapsedSeconds: null == elapsedSeconds ? _self.elapsedSeconds : elapsedSeconds // ignore: cast_nullable_to_non_nullable
as int,timerStartedAt: freezed == timerStartedAt ? _self.timerStartedAt : timerStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
