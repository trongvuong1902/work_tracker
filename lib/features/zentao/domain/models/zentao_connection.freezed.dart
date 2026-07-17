// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zentao_connection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ZentaoConnection {

 String get domain; String get account;
/// Create a copy of ZentaoConnection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZentaoConnectionCopyWith<ZentaoConnection> get copyWith => _$ZentaoConnectionCopyWithImpl<ZentaoConnection>(this as ZentaoConnection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZentaoConnection&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.account, account) || other.account == account));
}


@override
int get hashCode => Object.hash(runtimeType,domain,account);

@override
String toString() {
  return 'ZentaoConnection(domain: $domain, account: $account)';
}


}

/// @nodoc
abstract mixin class $ZentaoConnectionCopyWith<$Res>  {
  factory $ZentaoConnectionCopyWith(ZentaoConnection value, $Res Function(ZentaoConnection) _then) = _$ZentaoConnectionCopyWithImpl;
@useResult
$Res call({
 String domain, String account
});




}
/// @nodoc
class _$ZentaoConnectionCopyWithImpl<$Res>
    implements $ZentaoConnectionCopyWith<$Res> {
  _$ZentaoConnectionCopyWithImpl(this._self, this._then);

  final ZentaoConnection _self;
  final $Res Function(ZentaoConnection) _then;

/// Create a copy of ZentaoConnection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? domain = null,Object? account = null,}) {
  return _then(_self.copyWith(
domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ZentaoConnection].
extension ZentaoConnectionPatterns on ZentaoConnection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ZentaoConnection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ZentaoConnection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ZentaoConnection value)  $default,){
final _that = this;
switch (_that) {
case _ZentaoConnection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ZentaoConnection value)?  $default,){
final _that = this;
switch (_that) {
case _ZentaoConnection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String domain,  String account)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ZentaoConnection() when $default != null:
return $default(_that.domain,_that.account);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String domain,  String account)  $default,) {final _that = this;
switch (_that) {
case _ZentaoConnection():
return $default(_that.domain,_that.account);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String domain,  String account)?  $default,) {final _that = this;
switch (_that) {
case _ZentaoConnection() when $default != null:
return $default(_that.domain,_that.account);case _:
  return null;

}
}

}

/// @nodoc


class _ZentaoConnection implements ZentaoConnection {
  const _ZentaoConnection({required this.domain, required this.account});
  

@override final  String domain;
@override final  String account;

/// Create a copy of ZentaoConnection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZentaoConnectionCopyWith<_ZentaoConnection> get copyWith => __$ZentaoConnectionCopyWithImpl<_ZentaoConnection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZentaoConnection&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.account, account) || other.account == account));
}


@override
int get hashCode => Object.hash(runtimeType,domain,account);

@override
String toString() {
  return 'ZentaoConnection(domain: $domain, account: $account)';
}


}

/// @nodoc
abstract mixin class _$ZentaoConnectionCopyWith<$Res> implements $ZentaoConnectionCopyWith<$Res> {
  factory _$ZentaoConnectionCopyWith(_ZentaoConnection value, $Res Function(_ZentaoConnection) _then) = __$ZentaoConnectionCopyWithImpl;
@override @useResult
$Res call({
 String domain, String account
});




}
/// @nodoc
class __$ZentaoConnectionCopyWithImpl<$Res>
    implements _$ZentaoConnectionCopyWith<$Res> {
  __$ZentaoConnectionCopyWithImpl(this._self, this._then);

  final _ZentaoConnection _self;
  final $Res Function(_ZentaoConnection) _then;

/// Create a copy of ZentaoConnection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? domain = null,Object? account = null,}) {
  return _then(_ZentaoConnection(
domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
