// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zentao_bug_comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ZentaoBugComment {

 int? get id; String? get actor; DateTime? get date; String get comment;
/// Create a copy of ZentaoBugComment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZentaoBugCommentCopyWith<ZentaoBugComment> get copyWith => _$ZentaoBugCommentCopyWithImpl<ZentaoBugComment>(this as ZentaoBugComment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZentaoBugComment&&(identical(other.id, id) || other.id == id)&&(identical(other.actor, actor) || other.actor == actor)&&(identical(other.date, date) || other.date == date)&&(identical(other.comment, comment) || other.comment == comment));
}


@override
int get hashCode => Object.hash(runtimeType,id,actor,date,comment);

@override
String toString() {
  return 'ZentaoBugComment(id: $id, actor: $actor, date: $date, comment: $comment)';
}


}

/// @nodoc
abstract mixin class $ZentaoBugCommentCopyWith<$Res>  {
  factory $ZentaoBugCommentCopyWith(ZentaoBugComment value, $Res Function(ZentaoBugComment) _then) = _$ZentaoBugCommentCopyWithImpl;
@useResult
$Res call({
 int? id, String? actor, DateTime? date, String comment
});




}
/// @nodoc
class _$ZentaoBugCommentCopyWithImpl<$Res>
    implements $ZentaoBugCommentCopyWith<$Res> {
  _$ZentaoBugCommentCopyWithImpl(this._self, this._then);

  final ZentaoBugComment _self;
  final $Res Function(ZentaoBugComment) _then;

/// Create a copy of ZentaoBugComment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? actor = freezed,Object? date = freezed,Object? comment = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,actor: freezed == actor ? _self.actor : actor // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ZentaoBugComment].
extension ZentaoBugCommentPatterns on ZentaoBugComment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ZentaoBugComment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ZentaoBugComment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ZentaoBugComment value)  $default,){
final _that = this;
switch (_that) {
case _ZentaoBugComment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ZentaoBugComment value)?  $default,){
final _that = this;
switch (_that) {
case _ZentaoBugComment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? actor,  DateTime? date,  String comment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ZentaoBugComment() when $default != null:
return $default(_that.id,_that.actor,_that.date,_that.comment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? actor,  DateTime? date,  String comment)  $default,) {final _that = this;
switch (_that) {
case _ZentaoBugComment():
return $default(_that.id,_that.actor,_that.date,_that.comment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? actor,  DateTime? date,  String comment)?  $default,) {final _that = this;
switch (_that) {
case _ZentaoBugComment() when $default != null:
return $default(_that.id,_that.actor,_that.date,_that.comment);case _:
  return null;

}
}

}

/// @nodoc


class _ZentaoBugComment implements ZentaoBugComment {
  const _ZentaoBugComment({this.id, this.actor, this.date, required this.comment});
  

@override final  int? id;
@override final  String? actor;
@override final  DateTime? date;
@override final  String comment;

/// Create a copy of ZentaoBugComment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZentaoBugCommentCopyWith<_ZentaoBugComment> get copyWith => __$ZentaoBugCommentCopyWithImpl<_ZentaoBugComment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZentaoBugComment&&(identical(other.id, id) || other.id == id)&&(identical(other.actor, actor) || other.actor == actor)&&(identical(other.date, date) || other.date == date)&&(identical(other.comment, comment) || other.comment == comment));
}


@override
int get hashCode => Object.hash(runtimeType,id,actor,date,comment);

@override
String toString() {
  return 'ZentaoBugComment(id: $id, actor: $actor, date: $date, comment: $comment)';
}


}

/// @nodoc
abstract mixin class _$ZentaoBugCommentCopyWith<$Res> implements $ZentaoBugCommentCopyWith<$Res> {
  factory _$ZentaoBugCommentCopyWith(_ZentaoBugComment value, $Res Function(_ZentaoBugComment) _then) = __$ZentaoBugCommentCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? actor, DateTime? date, String comment
});




}
/// @nodoc
class __$ZentaoBugCommentCopyWithImpl<$Res>
    implements _$ZentaoBugCommentCopyWith<$Res> {
  __$ZentaoBugCommentCopyWithImpl(this._self, this._then);

  final _ZentaoBugComment _self;
  final $Res Function(_ZentaoBugComment) _then;

/// Create a copy of ZentaoBugComment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? actor = freezed,Object? date = freezed,Object? comment = null,}) {
  return _then(_ZentaoBugComment(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,actor: freezed == actor ? _self.actor : actor // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
