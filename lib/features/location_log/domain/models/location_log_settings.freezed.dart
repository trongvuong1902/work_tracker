// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_log_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationLogSettings {

 bool get enabled;
/// Create a copy of LocationLogSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationLogSettingsCopyWith<LocationLogSettings> get copyWith => _$LocationLogSettingsCopyWithImpl<LocationLogSettings>(this as LocationLogSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationLogSettings&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'LocationLogSettings(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $LocationLogSettingsCopyWith<$Res>  {
  factory $LocationLogSettingsCopyWith(LocationLogSettings value, $Res Function(LocationLogSettings) _then) = _$LocationLogSettingsCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class _$LocationLogSettingsCopyWithImpl<$Res>
    implements $LocationLogSettingsCopyWith<$Res> {
  _$LocationLogSettingsCopyWithImpl(this._self, this._then);

  final LocationLogSettings _self;
  final $Res Function(LocationLogSettings) _then;

/// Create a copy of LocationLogSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationLogSettings].
extension LocationLogSettingsPatterns on LocationLogSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationLogSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationLogSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationLogSettings value)  $default,){
final _that = this;
switch (_that) {
case _LocationLogSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationLogSettings value)?  $default,){
final _that = this;
switch (_that) {
case _LocationLogSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationLogSettings() when $default != null:
return $default(_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled)  $default,) {final _that = this;
switch (_that) {
case _LocationLogSettings():
return $default(_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled)?  $default,) {final _that = this;
switch (_that) {
case _LocationLogSettings() when $default != null:
return $default(_that.enabled);case _:
  return null;

}
}

}

/// @nodoc


class _LocationLogSettings implements LocationLogSettings {
  const _LocationLogSettings({this.enabled = false});
  

@override@JsonKey() final  bool enabled;

/// Create a copy of LocationLogSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationLogSettingsCopyWith<_LocationLogSettings> get copyWith => __$LocationLogSettingsCopyWithImpl<_LocationLogSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationLogSettings&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'LocationLogSettings(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$LocationLogSettingsCopyWith<$Res> implements $LocationLogSettingsCopyWith<$Res> {
  factory _$LocationLogSettingsCopyWith(_LocationLogSettings value, $Res Function(_LocationLogSettings) _then) = __$LocationLogSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class __$LocationLogSettingsCopyWithImpl<$Res>
    implements _$LocationLogSettingsCopyWith<$Res> {
  __$LocationLogSettingsCopyWithImpl(this._self, this._then);

  final _LocationLogSettings _self;
  final $Res Function(_LocationLogSettings) _then;

/// Create a copy of LocationLogSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(_LocationLogSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
