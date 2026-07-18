// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zentao_bug.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ZentaoBug {

 int get id; String get title; String get status; String? get description; int? get priority; String? get assignedToAccount; String? get assignedToRealName; int? get severity; DateTime? get deadline; String? get openedByAccount; bool get confirmed;
/// Create a copy of ZentaoBug
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZentaoBugCopyWith<ZentaoBug> get copyWith => _$ZentaoBugCopyWithImpl<ZentaoBug>(this as ZentaoBug, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZentaoBug&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.assignedToAccount, assignedToAccount) || other.assignedToAccount == assignedToAccount)&&(identical(other.assignedToRealName, assignedToRealName) || other.assignedToRealName == assignedToRealName)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.openedByAccount, openedByAccount) || other.openedByAccount == openedByAccount)&&(identical(other.confirmed, confirmed) || other.confirmed == confirmed));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,status,description,priority,assignedToAccount,assignedToRealName,severity,deadline,openedByAccount,confirmed);

@override
String toString() {
  return 'ZentaoBug(id: $id, title: $title, status: $status, description: $description, priority: $priority, assignedToAccount: $assignedToAccount, assignedToRealName: $assignedToRealName, severity: $severity, deadline: $deadline, openedByAccount: $openedByAccount, confirmed: $confirmed)';
}


}

/// @nodoc
abstract mixin class $ZentaoBugCopyWith<$Res>  {
  factory $ZentaoBugCopyWith(ZentaoBug value, $Res Function(ZentaoBug) _then) = _$ZentaoBugCopyWithImpl;
@useResult
$Res call({
 int id, String title, String status, String? description, int? priority, String? assignedToAccount, String? assignedToRealName, int? severity, DateTime? deadline, String? openedByAccount, bool confirmed
});




}
/// @nodoc
class _$ZentaoBugCopyWithImpl<$Res>
    implements $ZentaoBugCopyWith<$Res> {
  _$ZentaoBugCopyWithImpl(this._self, this._then);

  final ZentaoBug _self;
  final $Res Function(ZentaoBug) _then;

/// Create a copy of ZentaoBug
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? status = null,Object? description = freezed,Object? priority = freezed,Object? assignedToAccount = freezed,Object? assignedToRealName = freezed,Object? severity = freezed,Object? deadline = freezed,Object? openedByAccount = freezed,Object? confirmed = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int?,assignedToAccount: freezed == assignedToAccount ? _self.assignedToAccount : assignedToAccount // ignore: cast_nullable_to_non_nullable
as String?,assignedToRealName: freezed == assignedToRealName ? _self.assignedToRealName : assignedToRealName // ignore: cast_nullable_to_non_nullable
as String?,severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as int?,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime?,openedByAccount: freezed == openedByAccount ? _self.openedByAccount : openedByAccount // ignore: cast_nullable_to_non_nullable
as String?,confirmed: null == confirmed ? _self.confirmed : confirmed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ZentaoBug].
extension ZentaoBugPatterns on ZentaoBug {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ZentaoBug value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ZentaoBug() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ZentaoBug value)  $default,){
final _that = this;
switch (_that) {
case _ZentaoBug():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ZentaoBug value)?  $default,){
final _that = this;
switch (_that) {
case _ZentaoBug() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String status,  String? description,  int? priority,  String? assignedToAccount,  String? assignedToRealName,  int? severity,  DateTime? deadline,  String? openedByAccount,  bool confirmed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ZentaoBug() when $default != null:
return $default(_that.id,_that.title,_that.status,_that.description,_that.priority,_that.assignedToAccount,_that.assignedToRealName,_that.severity,_that.deadline,_that.openedByAccount,_that.confirmed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String status,  String? description,  int? priority,  String? assignedToAccount,  String? assignedToRealName,  int? severity,  DateTime? deadline,  String? openedByAccount,  bool confirmed)  $default,) {final _that = this;
switch (_that) {
case _ZentaoBug():
return $default(_that.id,_that.title,_that.status,_that.description,_that.priority,_that.assignedToAccount,_that.assignedToRealName,_that.severity,_that.deadline,_that.openedByAccount,_that.confirmed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String status,  String? description,  int? priority,  String? assignedToAccount,  String? assignedToRealName,  int? severity,  DateTime? deadline,  String? openedByAccount,  bool confirmed)?  $default,) {final _that = this;
switch (_that) {
case _ZentaoBug() when $default != null:
return $default(_that.id,_that.title,_that.status,_that.description,_that.priority,_that.assignedToAccount,_that.assignedToRealName,_that.severity,_that.deadline,_that.openedByAccount,_that.confirmed);case _:
  return null;

}
}

}

/// @nodoc


class _ZentaoBug implements ZentaoBug {
  const _ZentaoBug({required this.id, required this.title, required this.status, this.description, this.priority, this.assignedToAccount, this.assignedToRealName, this.severity, this.deadline, this.openedByAccount, this.confirmed = false});
  

@override final  int id;
@override final  String title;
@override final  String status;
@override final  String? description;
@override final  int? priority;
@override final  String? assignedToAccount;
@override final  String? assignedToRealName;
@override final  int? severity;
@override final  DateTime? deadline;
@override final  String? openedByAccount;
@override@JsonKey() final  bool confirmed;

/// Create a copy of ZentaoBug
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZentaoBugCopyWith<_ZentaoBug> get copyWith => __$ZentaoBugCopyWithImpl<_ZentaoBug>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZentaoBug&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.assignedToAccount, assignedToAccount) || other.assignedToAccount == assignedToAccount)&&(identical(other.assignedToRealName, assignedToRealName) || other.assignedToRealName == assignedToRealName)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.openedByAccount, openedByAccount) || other.openedByAccount == openedByAccount)&&(identical(other.confirmed, confirmed) || other.confirmed == confirmed));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,status,description,priority,assignedToAccount,assignedToRealName,severity,deadline,openedByAccount,confirmed);

@override
String toString() {
  return 'ZentaoBug(id: $id, title: $title, status: $status, description: $description, priority: $priority, assignedToAccount: $assignedToAccount, assignedToRealName: $assignedToRealName, severity: $severity, deadline: $deadline, openedByAccount: $openedByAccount, confirmed: $confirmed)';
}


}

/// @nodoc
abstract mixin class _$ZentaoBugCopyWith<$Res> implements $ZentaoBugCopyWith<$Res> {
  factory _$ZentaoBugCopyWith(_ZentaoBug value, $Res Function(_ZentaoBug) _then) = __$ZentaoBugCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String status, String? description, int? priority, String? assignedToAccount, String? assignedToRealName, int? severity, DateTime? deadline, String? openedByAccount, bool confirmed
});




}
/// @nodoc
class __$ZentaoBugCopyWithImpl<$Res>
    implements _$ZentaoBugCopyWith<$Res> {
  __$ZentaoBugCopyWithImpl(this._self, this._then);

  final _ZentaoBug _self;
  final $Res Function(_ZentaoBug) _then;

/// Create a copy of ZentaoBug
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? status = null,Object? description = freezed,Object? priority = freezed,Object? assignedToAccount = freezed,Object? assignedToRealName = freezed,Object? severity = freezed,Object? deadline = freezed,Object? openedByAccount = freezed,Object? confirmed = null,}) {
  return _then(_ZentaoBug(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int?,assignedToAccount: freezed == assignedToAccount ? _self.assignedToAccount : assignedToAccount // ignore: cast_nullable_to_non_nullable
as String?,assignedToRealName: freezed == assignedToRealName ? _self.assignedToRealName : assignedToRealName // ignore: cast_nullable_to_non_nullable
as String?,severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as int?,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime?,openedByAccount: freezed == openedByAccount ? _self.openedByAccount : openedByAccount // ignore: cast_nullable_to_non_nullable
as String?,confirmed: null == confirmed ? _self.confirmed : confirmed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
