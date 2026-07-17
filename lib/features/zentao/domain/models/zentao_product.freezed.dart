// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zentao_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ZentaoProduct {

 int get id; String get name; int? get priority;
/// Create a copy of ZentaoProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZentaoProductCopyWith<ZentaoProduct> get copyWith => _$ZentaoProductCopyWithImpl<ZentaoProduct>(this as ZentaoProduct, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZentaoProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.priority, priority) || other.priority == priority));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,priority);

@override
String toString() {
  return 'ZentaoProduct(id: $id, name: $name, priority: $priority)';
}


}

/// @nodoc
abstract mixin class $ZentaoProductCopyWith<$Res>  {
  factory $ZentaoProductCopyWith(ZentaoProduct value, $Res Function(ZentaoProduct) _then) = _$ZentaoProductCopyWithImpl;
@useResult
$Res call({
 int id, String name, int? priority
});




}
/// @nodoc
class _$ZentaoProductCopyWithImpl<$Res>
    implements $ZentaoProductCopyWith<$Res> {
  _$ZentaoProductCopyWithImpl(this._self, this._then);

  final ZentaoProduct _self;
  final $Res Function(ZentaoProduct) _then;

/// Create a copy of ZentaoProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? priority = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ZentaoProduct].
extension ZentaoProductPatterns on ZentaoProduct {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ZentaoProduct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ZentaoProduct() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ZentaoProduct value)  $default,){
final _that = this;
switch (_that) {
case _ZentaoProduct():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ZentaoProduct value)?  $default,){
final _that = this;
switch (_that) {
case _ZentaoProduct() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  int? priority)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ZentaoProduct() when $default != null:
return $default(_that.id,_that.name,_that.priority);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  int? priority)  $default,) {final _that = this;
switch (_that) {
case _ZentaoProduct():
return $default(_that.id,_that.name,_that.priority);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  int? priority)?  $default,) {final _that = this;
switch (_that) {
case _ZentaoProduct() when $default != null:
return $default(_that.id,_that.name,_that.priority);case _:
  return null;

}
}

}

/// @nodoc


class _ZentaoProduct implements ZentaoProduct {
  const _ZentaoProduct({required this.id, required this.name, this.priority});
  

@override final  int id;
@override final  String name;
@override final  int? priority;

/// Create a copy of ZentaoProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZentaoProductCopyWith<_ZentaoProduct> get copyWith => __$ZentaoProductCopyWithImpl<_ZentaoProduct>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZentaoProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.priority, priority) || other.priority == priority));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,priority);

@override
String toString() {
  return 'ZentaoProduct(id: $id, name: $name, priority: $priority)';
}


}

/// @nodoc
abstract mixin class _$ZentaoProductCopyWith<$Res> implements $ZentaoProductCopyWith<$Res> {
  factory _$ZentaoProductCopyWith(_ZentaoProduct value, $Res Function(_ZentaoProduct) _then) = __$ZentaoProductCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int? priority
});




}
/// @nodoc
class __$ZentaoProductCopyWithImpl<$Res>
    implements _$ZentaoProductCopyWith<$Res> {
  __$ZentaoProductCopyWithImpl(this._self, this._then);

  final _ZentaoProduct _self;
  final $Res Function(_ZentaoProduct) _then;

/// Create a copy of ZentaoProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? priority = freezed,}) {
  return _then(_ZentaoProduct(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
