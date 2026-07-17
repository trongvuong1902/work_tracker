// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zentao_bug_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ZentaoBugDetail {

 ZentaoBug get bug; List<ZentaoBugComment> get comments; List<ZentaoBugAttachment> get attachments;
/// Create a copy of ZentaoBugDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZentaoBugDetailCopyWith<ZentaoBugDetail> get copyWith => _$ZentaoBugDetailCopyWithImpl<ZentaoBugDetail>(this as ZentaoBugDetail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZentaoBugDetail&&(identical(other.bug, bug) || other.bug == bug)&&const DeepCollectionEquality().equals(other.comments, comments)&&const DeepCollectionEquality().equals(other.attachments, attachments));
}


@override
int get hashCode => Object.hash(runtimeType,bug,const DeepCollectionEquality().hash(comments),const DeepCollectionEquality().hash(attachments));

@override
String toString() {
  return 'ZentaoBugDetail(bug: $bug, comments: $comments, attachments: $attachments)';
}


}

/// @nodoc
abstract mixin class $ZentaoBugDetailCopyWith<$Res>  {
  factory $ZentaoBugDetailCopyWith(ZentaoBugDetail value, $Res Function(ZentaoBugDetail) _then) = _$ZentaoBugDetailCopyWithImpl;
@useResult
$Res call({
 ZentaoBug bug, List<ZentaoBugComment> comments, List<ZentaoBugAttachment> attachments
});


$ZentaoBugCopyWith<$Res> get bug;

}
/// @nodoc
class _$ZentaoBugDetailCopyWithImpl<$Res>
    implements $ZentaoBugDetailCopyWith<$Res> {
  _$ZentaoBugDetailCopyWithImpl(this._self, this._then);

  final ZentaoBugDetail _self;
  final $Res Function(ZentaoBugDetail) _then;

/// Create a copy of ZentaoBugDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bug = null,Object? comments = null,Object? attachments = null,}) {
  return _then(_self.copyWith(
bug: null == bug ? _self.bug : bug // ignore: cast_nullable_to_non_nullable
as ZentaoBug,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<ZentaoBugComment>,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<ZentaoBugAttachment>,
  ));
}
/// Create a copy of ZentaoBugDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZentaoBugCopyWith<$Res> get bug {
  
  return $ZentaoBugCopyWith<$Res>(_self.bug, (value) {
    return _then(_self.copyWith(bug: value));
  });
}
}


/// Adds pattern-matching-related methods to [ZentaoBugDetail].
extension ZentaoBugDetailPatterns on ZentaoBugDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ZentaoBugDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ZentaoBugDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ZentaoBugDetail value)  $default,){
final _that = this;
switch (_that) {
case _ZentaoBugDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ZentaoBugDetail value)?  $default,){
final _that = this;
switch (_that) {
case _ZentaoBugDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ZentaoBug bug,  List<ZentaoBugComment> comments,  List<ZentaoBugAttachment> attachments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ZentaoBugDetail() when $default != null:
return $default(_that.bug,_that.comments,_that.attachments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ZentaoBug bug,  List<ZentaoBugComment> comments,  List<ZentaoBugAttachment> attachments)  $default,) {final _that = this;
switch (_that) {
case _ZentaoBugDetail():
return $default(_that.bug,_that.comments,_that.attachments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ZentaoBug bug,  List<ZentaoBugComment> comments,  List<ZentaoBugAttachment> attachments)?  $default,) {final _that = this;
switch (_that) {
case _ZentaoBugDetail() when $default != null:
return $default(_that.bug,_that.comments,_that.attachments);case _:
  return null;

}
}

}

/// @nodoc


class _ZentaoBugDetail implements ZentaoBugDetail {
  const _ZentaoBugDetail({required this.bug, final  List<ZentaoBugComment> comments = const <ZentaoBugComment>[], final  List<ZentaoBugAttachment> attachments = const <ZentaoBugAttachment>[]}): _comments = comments,_attachments = attachments;
  

@override final  ZentaoBug bug;
 final  List<ZentaoBugComment> _comments;
@override@JsonKey() List<ZentaoBugComment> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

 final  List<ZentaoBugAttachment> _attachments;
@override@JsonKey() List<ZentaoBugAttachment> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}


/// Create a copy of ZentaoBugDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZentaoBugDetailCopyWith<_ZentaoBugDetail> get copyWith => __$ZentaoBugDetailCopyWithImpl<_ZentaoBugDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZentaoBugDetail&&(identical(other.bug, bug) || other.bug == bug)&&const DeepCollectionEquality().equals(other._comments, _comments)&&const DeepCollectionEquality().equals(other._attachments, _attachments));
}


@override
int get hashCode => Object.hash(runtimeType,bug,const DeepCollectionEquality().hash(_comments),const DeepCollectionEquality().hash(_attachments));

@override
String toString() {
  return 'ZentaoBugDetail(bug: $bug, comments: $comments, attachments: $attachments)';
}


}

/// @nodoc
abstract mixin class _$ZentaoBugDetailCopyWith<$Res> implements $ZentaoBugDetailCopyWith<$Res> {
  factory _$ZentaoBugDetailCopyWith(_ZentaoBugDetail value, $Res Function(_ZentaoBugDetail) _then) = __$ZentaoBugDetailCopyWithImpl;
@override @useResult
$Res call({
 ZentaoBug bug, List<ZentaoBugComment> comments, List<ZentaoBugAttachment> attachments
});


@override $ZentaoBugCopyWith<$Res> get bug;

}
/// @nodoc
class __$ZentaoBugDetailCopyWithImpl<$Res>
    implements _$ZentaoBugDetailCopyWith<$Res> {
  __$ZentaoBugDetailCopyWithImpl(this._self, this._then);

  final _ZentaoBugDetail _self;
  final $Res Function(_ZentaoBugDetail) _then;

/// Create a copy of ZentaoBugDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bug = null,Object? comments = null,Object? attachments = null,}) {
  return _then(_ZentaoBugDetail(
bug: null == bug ? _self.bug : bug // ignore: cast_nullable_to_non_nullable
as ZentaoBug,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<ZentaoBugComment>,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<ZentaoBugAttachment>,
  ));
}

/// Create a copy of ZentaoBugDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZentaoBugCopyWith<$Res> get bug {
  
  return $ZentaoBugCopyWith<$Res>(_self.bug, (value) {
    return _then(_self.copyWith(bug: value));
  });
}
}

// dart format on
