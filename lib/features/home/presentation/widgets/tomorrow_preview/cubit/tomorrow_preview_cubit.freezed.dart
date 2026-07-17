// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tomorrow_preview_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TomorrowPreviewState {

 TomorrowPreview? get preview;
/// Create a copy of TomorrowPreviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TomorrowPreviewStateCopyWith<TomorrowPreviewState> get copyWith => _$TomorrowPreviewStateCopyWithImpl<TomorrowPreviewState>(this as TomorrowPreviewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TomorrowPreviewState&&(identical(other.preview, preview) || other.preview == preview));
}


@override
int get hashCode => Object.hash(runtimeType,preview);

@override
String toString() {
  return 'TomorrowPreviewState(preview: $preview)';
}


}

/// @nodoc
abstract mixin class $TomorrowPreviewStateCopyWith<$Res>  {
  factory $TomorrowPreviewStateCopyWith(TomorrowPreviewState value, $Res Function(TomorrowPreviewState) _then) = _$TomorrowPreviewStateCopyWithImpl;
@useResult
$Res call({
 TomorrowPreview? preview
});


$TomorrowPreviewCopyWith<$Res>? get preview;

}
/// @nodoc
class _$TomorrowPreviewStateCopyWithImpl<$Res>
    implements $TomorrowPreviewStateCopyWith<$Res> {
  _$TomorrowPreviewStateCopyWithImpl(this._self, this._then);

  final TomorrowPreviewState _self;
  final $Res Function(TomorrowPreviewState) _then;

/// Create a copy of TomorrowPreviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? preview = freezed,}) {
  return _then(_self.copyWith(
preview: freezed == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as TomorrowPreview?,
  ));
}
/// Create a copy of TomorrowPreviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TomorrowPreviewCopyWith<$Res>? get preview {
    if (_self.preview == null) {
    return null;
  }

  return $TomorrowPreviewCopyWith<$Res>(_self.preview!, (value) {
    return _then(_self.copyWith(preview: value));
  });
}
}


/// Adds pattern-matching-related methods to [TomorrowPreviewState].
extension TomorrowPreviewStatePatterns on TomorrowPreviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TomorrowPreviewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TomorrowPreviewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TomorrowPreviewState value)  $default,){
final _that = this;
switch (_that) {
case _TomorrowPreviewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TomorrowPreviewState value)?  $default,){
final _that = this;
switch (_that) {
case _TomorrowPreviewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TomorrowPreview? preview)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TomorrowPreviewState() when $default != null:
return $default(_that.preview);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TomorrowPreview? preview)  $default,) {final _that = this;
switch (_that) {
case _TomorrowPreviewState():
return $default(_that.preview);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TomorrowPreview? preview)?  $default,) {final _that = this;
switch (_that) {
case _TomorrowPreviewState() when $default != null:
return $default(_that.preview);case _:
  return null;

}
}

}

/// @nodoc


class _TomorrowPreviewState implements TomorrowPreviewState {
  const _TomorrowPreviewState({this.preview});
  

@override final  TomorrowPreview? preview;

/// Create a copy of TomorrowPreviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TomorrowPreviewStateCopyWith<_TomorrowPreviewState> get copyWith => __$TomorrowPreviewStateCopyWithImpl<_TomorrowPreviewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TomorrowPreviewState&&(identical(other.preview, preview) || other.preview == preview));
}


@override
int get hashCode => Object.hash(runtimeType,preview);

@override
String toString() {
  return 'TomorrowPreviewState(preview: $preview)';
}


}

/// @nodoc
abstract mixin class _$TomorrowPreviewStateCopyWith<$Res> implements $TomorrowPreviewStateCopyWith<$Res> {
  factory _$TomorrowPreviewStateCopyWith(_TomorrowPreviewState value, $Res Function(_TomorrowPreviewState) _then) = __$TomorrowPreviewStateCopyWithImpl;
@override @useResult
$Res call({
 TomorrowPreview? preview
});


@override $TomorrowPreviewCopyWith<$Res>? get preview;

}
/// @nodoc
class __$TomorrowPreviewStateCopyWithImpl<$Res>
    implements _$TomorrowPreviewStateCopyWith<$Res> {
  __$TomorrowPreviewStateCopyWithImpl(this._self, this._then);

  final _TomorrowPreviewState _self;
  final $Res Function(_TomorrowPreviewState) _then;

/// Create a copy of TomorrowPreviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? preview = freezed,}) {
  return _then(_TomorrowPreviewState(
preview: freezed == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as TomorrowPreview?,
  ));
}

/// Create a copy of TomorrowPreviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TomorrowPreviewCopyWith<$Res>? get preview {
    if (_self.preview == null) {
    return null;
  }

  return $TomorrowPreviewCopyWith<$Res>(_self.preview!, (value) {
    return _then(_self.copyWith(preview: value));
  });
}
}

// dart format on
