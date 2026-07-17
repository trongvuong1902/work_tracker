// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zentao_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ZentaoTask {

 int get id; String get name; String get status; String? get assignedToAccount; String? get assignedToRealName; double? get estimate; double? get consumed; double? get left; DateTime? get deadline;
/// Create a copy of ZentaoTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZentaoTaskCopyWith<ZentaoTask> get copyWith => _$ZentaoTaskCopyWithImpl<ZentaoTask>(this as ZentaoTask, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZentaoTask&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.assignedToAccount, assignedToAccount) || other.assignedToAccount == assignedToAccount)&&(identical(other.assignedToRealName, assignedToRealName) || other.assignedToRealName == assignedToRealName)&&(identical(other.estimate, estimate) || other.estimate == estimate)&&(identical(other.consumed, consumed) || other.consumed == consumed)&&(identical(other.left, left) || other.left == left)&&(identical(other.deadline, deadline) || other.deadline == deadline));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,status,assignedToAccount,assignedToRealName,estimate,consumed,left,deadline);

@override
String toString() {
  return 'ZentaoTask(id: $id, name: $name, status: $status, assignedToAccount: $assignedToAccount, assignedToRealName: $assignedToRealName, estimate: $estimate, consumed: $consumed, left: $left, deadline: $deadline)';
}


}

/// @nodoc
abstract mixin class $ZentaoTaskCopyWith<$Res>  {
  factory $ZentaoTaskCopyWith(ZentaoTask value, $Res Function(ZentaoTask) _then) = _$ZentaoTaskCopyWithImpl;
@useResult
$Res call({
 int id, String name, String status, String? assignedToAccount, String? assignedToRealName, double? estimate, double? consumed, double? left, DateTime? deadline
});




}
/// @nodoc
class _$ZentaoTaskCopyWithImpl<$Res>
    implements $ZentaoTaskCopyWith<$Res> {
  _$ZentaoTaskCopyWithImpl(this._self, this._then);

  final ZentaoTask _self;
  final $Res Function(ZentaoTask) _then;

/// Create a copy of ZentaoTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? status = null,Object? assignedToAccount = freezed,Object? assignedToRealName = freezed,Object? estimate = freezed,Object? consumed = freezed,Object? left = freezed,Object? deadline = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,assignedToAccount: freezed == assignedToAccount ? _self.assignedToAccount : assignedToAccount // ignore: cast_nullable_to_non_nullable
as String?,assignedToRealName: freezed == assignedToRealName ? _self.assignedToRealName : assignedToRealName // ignore: cast_nullable_to_non_nullable
as String?,estimate: freezed == estimate ? _self.estimate : estimate // ignore: cast_nullable_to_non_nullable
as double?,consumed: freezed == consumed ? _self.consumed : consumed // ignore: cast_nullable_to_non_nullable
as double?,left: freezed == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as double?,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ZentaoTask].
extension ZentaoTaskPatterns on ZentaoTask {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ZentaoTask value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ZentaoTask() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ZentaoTask value)  $default,){
final _that = this;
switch (_that) {
case _ZentaoTask():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ZentaoTask value)?  $default,){
final _that = this;
switch (_that) {
case _ZentaoTask() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String status,  String? assignedToAccount,  String? assignedToRealName,  double? estimate,  double? consumed,  double? left,  DateTime? deadline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ZentaoTask() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.assignedToAccount,_that.assignedToRealName,_that.estimate,_that.consumed,_that.left,_that.deadline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String status,  String? assignedToAccount,  String? assignedToRealName,  double? estimate,  double? consumed,  double? left,  DateTime? deadline)  $default,) {final _that = this;
switch (_that) {
case _ZentaoTask():
return $default(_that.id,_that.name,_that.status,_that.assignedToAccount,_that.assignedToRealName,_that.estimate,_that.consumed,_that.left,_that.deadline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String status,  String? assignedToAccount,  String? assignedToRealName,  double? estimate,  double? consumed,  double? left,  DateTime? deadline)?  $default,) {final _that = this;
switch (_that) {
case _ZentaoTask() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.assignedToAccount,_that.assignedToRealName,_that.estimate,_that.consumed,_that.left,_that.deadline);case _:
  return null;

}
}

}

/// @nodoc


class _ZentaoTask implements ZentaoTask {
  const _ZentaoTask({required this.id, required this.name, required this.status, this.assignedToAccount, this.assignedToRealName, this.estimate, this.consumed, this.left, this.deadline});
  

@override final  int id;
@override final  String name;
@override final  String status;
@override final  String? assignedToAccount;
@override final  String? assignedToRealName;
@override final  double? estimate;
@override final  double? consumed;
@override final  double? left;
@override final  DateTime? deadline;

/// Create a copy of ZentaoTask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZentaoTaskCopyWith<_ZentaoTask> get copyWith => __$ZentaoTaskCopyWithImpl<_ZentaoTask>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZentaoTask&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.assignedToAccount, assignedToAccount) || other.assignedToAccount == assignedToAccount)&&(identical(other.assignedToRealName, assignedToRealName) || other.assignedToRealName == assignedToRealName)&&(identical(other.estimate, estimate) || other.estimate == estimate)&&(identical(other.consumed, consumed) || other.consumed == consumed)&&(identical(other.left, left) || other.left == left)&&(identical(other.deadline, deadline) || other.deadline == deadline));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,status,assignedToAccount,assignedToRealName,estimate,consumed,left,deadline);

@override
String toString() {
  return 'ZentaoTask(id: $id, name: $name, status: $status, assignedToAccount: $assignedToAccount, assignedToRealName: $assignedToRealName, estimate: $estimate, consumed: $consumed, left: $left, deadline: $deadline)';
}


}

/// @nodoc
abstract mixin class _$ZentaoTaskCopyWith<$Res> implements $ZentaoTaskCopyWith<$Res> {
  factory _$ZentaoTaskCopyWith(_ZentaoTask value, $Res Function(_ZentaoTask) _then) = __$ZentaoTaskCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String status, String? assignedToAccount, String? assignedToRealName, double? estimate, double? consumed, double? left, DateTime? deadline
});




}
/// @nodoc
class __$ZentaoTaskCopyWithImpl<$Res>
    implements _$ZentaoTaskCopyWith<$Res> {
  __$ZentaoTaskCopyWithImpl(this._self, this._then);

  final _ZentaoTask _self;
  final $Res Function(_ZentaoTask) _then;

/// Create a copy of ZentaoTask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? status = null,Object? assignedToAccount = freezed,Object? assignedToRealName = freezed,Object? estimate = freezed,Object? consumed = freezed,Object? left = freezed,Object? deadline = freezed,}) {
  return _then(_ZentaoTask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,assignedToAccount: freezed == assignedToAccount ? _self.assignedToAccount : assignedToAccount // ignore: cast_nullable_to_non_nullable
as String?,assignedToRealName: freezed == assignedToRealName ? _self.assignedToRealName : assignedToRealName // ignore: cast_nullable_to_non_nullable
as String?,estimate: freezed == estimate ? _self.estimate : estimate // ignore: cast_nullable_to_non_nullable
as double?,consumed: freezed == consumed ? _self.consumed : consumed // ignore: cast_nullable_to_non_nullable
as double?,left: freezed == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as double?,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
