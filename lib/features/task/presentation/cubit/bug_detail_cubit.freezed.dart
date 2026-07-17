// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bug_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BugDetailState {

 bool get isLoading; ZentaoBugDetail? get detail; String? get errorMessage;
/// Create a copy of BugDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BugDetailStateCopyWith<BugDetailState> get copyWith => _$BugDetailStateCopyWithImpl<BugDetailState>(this as BugDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BugDetailState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,detail,errorMessage);

@override
String toString() {
  return 'BugDetailState(isLoading: $isLoading, detail: $detail, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $BugDetailStateCopyWith<$Res>  {
  factory $BugDetailStateCopyWith(BugDetailState value, $Res Function(BugDetailState) _then) = _$BugDetailStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, ZentaoBugDetail? detail, String? errorMessage
});


$ZentaoBugDetailCopyWith<$Res>? get detail;

}
/// @nodoc
class _$BugDetailStateCopyWithImpl<$Res>
    implements $BugDetailStateCopyWith<$Res> {
  _$BugDetailStateCopyWithImpl(this._self, this._then);

  final BugDetailState _self;
  final $Res Function(BugDetailState) _then;

/// Create a copy of BugDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? detail = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as ZentaoBugDetail?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of BugDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZentaoBugDetailCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $ZentaoBugDetailCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}
}


/// Adds pattern-matching-related methods to [BugDetailState].
extension BugDetailStatePatterns on BugDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BugDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BugDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BugDetailState value)  $default,){
final _that = this;
switch (_that) {
case _BugDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BugDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _BugDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  ZentaoBugDetail? detail,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BugDetailState() when $default != null:
return $default(_that.isLoading,_that.detail,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  ZentaoBugDetail? detail,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _BugDetailState():
return $default(_that.isLoading,_that.detail,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  ZentaoBugDetail? detail,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _BugDetailState() when $default != null:
return $default(_that.isLoading,_that.detail,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _BugDetailState implements BugDetailState {
  const _BugDetailState({this.isLoading = false, this.detail, this.errorMessage});
  

@override@JsonKey() final  bool isLoading;
@override final  ZentaoBugDetail? detail;
@override final  String? errorMessage;

/// Create a copy of BugDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BugDetailStateCopyWith<_BugDetailState> get copyWith => __$BugDetailStateCopyWithImpl<_BugDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BugDetailState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,detail,errorMessage);

@override
String toString() {
  return 'BugDetailState(isLoading: $isLoading, detail: $detail, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$BugDetailStateCopyWith<$Res> implements $BugDetailStateCopyWith<$Res> {
  factory _$BugDetailStateCopyWith(_BugDetailState value, $Res Function(_BugDetailState) _then) = __$BugDetailStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, ZentaoBugDetail? detail, String? errorMessage
});


@override $ZentaoBugDetailCopyWith<$Res>? get detail;

}
/// @nodoc
class __$BugDetailStateCopyWithImpl<$Res>
    implements _$BugDetailStateCopyWith<$Res> {
  __$BugDetailStateCopyWithImpl(this._self, this._then);

  final _BugDetailState _self;
  final $Res Function(_BugDetailState) _then;

/// Create a copy of BugDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? detail = freezed,Object? errorMessage = freezed,}) {
  return _then(_BugDetailState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as ZentaoBugDetail?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of BugDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZentaoBugDetailCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $ZentaoBugDetailCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}
}

// dart format on
