// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zentao_bug_attachment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ZentaoBugAttachment {

 int get id; String get title; String? get fileExtension; int? get sizeBytes;
/// Create a copy of ZentaoBugAttachment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZentaoBugAttachmentCopyWith<ZentaoBugAttachment> get copyWith => _$ZentaoBugAttachmentCopyWithImpl<ZentaoBugAttachment>(this as ZentaoBugAttachment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZentaoBugAttachment&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.fileExtension, fileExtension) || other.fileExtension == fileExtension)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,fileExtension,sizeBytes);

@override
String toString() {
  return 'ZentaoBugAttachment(id: $id, title: $title, fileExtension: $fileExtension, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class $ZentaoBugAttachmentCopyWith<$Res>  {
  factory $ZentaoBugAttachmentCopyWith(ZentaoBugAttachment value, $Res Function(ZentaoBugAttachment) _then) = _$ZentaoBugAttachmentCopyWithImpl;
@useResult
$Res call({
 int id, String title, String? fileExtension, int? sizeBytes
});




}
/// @nodoc
class _$ZentaoBugAttachmentCopyWithImpl<$Res>
    implements $ZentaoBugAttachmentCopyWith<$Res> {
  _$ZentaoBugAttachmentCopyWithImpl(this._self, this._then);

  final ZentaoBugAttachment _self;
  final $Res Function(ZentaoBugAttachment) _then;

/// Create a copy of ZentaoBugAttachment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? fileExtension = freezed,Object? sizeBytes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,fileExtension: freezed == fileExtension ? _self.fileExtension : fileExtension // ignore: cast_nullable_to_non_nullable
as String?,sizeBytes: freezed == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ZentaoBugAttachment].
extension ZentaoBugAttachmentPatterns on ZentaoBugAttachment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ZentaoBugAttachment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ZentaoBugAttachment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ZentaoBugAttachment value)  $default,){
final _that = this;
switch (_that) {
case _ZentaoBugAttachment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ZentaoBugAttachment value)?  $default,){
final _that = this;
switch (_that) {
case _ZentaoBugAttachment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String? fileExtension,  int? sizeBytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ZentaoBugAttachment() when $default != null:
return $default(_that.id,_that.title,_that.fileExtension,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String? fileExtension,  int? sizeBytes)  $default,) {final _that = this;
switch (_that) {
case _ZentaoBugAttachment():
return $default(_that.id,_that.title,_that.fileExtension,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String? fileExtension,  int? sizeBytes)?  $default,) {final _that = this;
switch (_that) {
case _ZentaoBugAttachment() when $default != null:
return $default(_that.id,_that.title,_that.fileExtension,_that.sizeBytes);case _:
  return null;

}
}

}

/// @nodoc


class _ZentaoBugAttachment implements ZentaoBugAttachment {
  const _ZentaoBugAttachment({required this.id, required this.title, this.fileExtension, this.sizeBytes});
  

@override final  int id;
@override final  String title;
@override final  String? fileExtension;
@override final  int? sizeBytes;

/// Create a copy of ZentaoBugAttachment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZentaoBugAttachmentCopyWith<_ZentaoBugAttachment> get copyWith => __$ZentaoBugAttachmentCopyWithImpl<_ZentaoBugAttachment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZentaoBugAttachment&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.fileExtension, fileExtension) || other.fileExtension == fileExtension)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,fileExtension,sizeBytes);

@override
String toString() {
  return 'ZentaoBugAttachment(id: $id, title: $title, fileExtension: $fileExtension, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class _$ZentaoBugAttachmentCopyWith<$Res> implements $ZentaoBugAttachmentCopyWith<$Res> {
  factory _$ZentaoBugAttachmentCopyWith(_ZentaoBugAttachment value, $Res Function(_ZentaoBugAttachment) _then) = __$ZentaoBugAttachmentCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String? fileExtension, int? sizeBytes
});




}
/// @nodoc
class __$ZentaoBugAttachmentCopyWithImpl<$Res>
    implements _$ZentaoBugAttachmentCopyWith<$Res> {
  __$ZentaoBugAttachmentCopyWithImpl(this._self, this._then);

  final _ZentaoBugAttachment _self;
  final $Res Function(_ZentaoBugAttachment) _then;

/// Create a copy of ZentaoBugAttachment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? fileExtension = freezed,Object? sizeBytes = freezed,}) {
  return _then(_ZentaoBugAttachment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,fileExtension: freezed == fileExtension ? _self.fileExtension : fileExtension // ignore: cast_nullable_to_non_nullable
as String?,sizeBytes: freezed == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
