// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_reminder_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutReminderSettings {

 bool get enabled; int get leadMinutes;
/// Create a copy of CheckoutReminderSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutReminderSettingsCopyWith<CheckoutReminderSettings> get copyWith => _$CheckoutReminderSettingsCopyWithImpl<CheckoutReminderSettings>(this as CheckoutReminderSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutReminderSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.leadMinutes, leadMinutes) || other.leadMinutes == leadMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,enabled,leadMinutes);

@override
String toString() {
  return 'CheckoutReminderSettings(enabled: $enabled, leadMinutes: $leadMinutes)';
}


}

/// @nodoc
abstract mixin class $CheckoutReminderSettingsCopyWith<$Res>  {
  factory $CheckoutReminderSettingsCopyWith(CheckoutReminderSettings value, $Res Function(CheckoutReminderSettings) _then) = _$CheckoutReminderSettingsCopyWithImpl;
@useResult
$Res call({
 bool enabled, int leadMinutes
});




}
/// @nodoc
class _$CheckoutReminderSettingsCopyWithImpl<$Res>
    implements $CheckoutReminderSettingsCopyWith<$Res> {
  _$CheckoutReminderSettingsCopyWithImpl(this._self, this._then);

  final CheckoutReminderSettings _self;
  final $Res Function(CheckoutReminderSettings) _then;

/// Create a copy of CheckoutReminderSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? leadMinutes = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,leadMinutes: null == leadMinutes ? _self.leadMinutes : leadMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutReminderSettings].
extension CheckoutReminderSettingsPatterns on CheckoutReminderSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutReminderSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutReminderSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutReminderSettings value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutReminderSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutReminderSettings value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutReminderSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  int leadMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutReminderSettings() when $default != null:
return $default(_that.enabled,_that.leadMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  int leadMinutes)  $default,) {final _that = this;
switch (_that) {
case _CheckoutReminderSettings():
return $default(_that.enabled,_that.leadMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  int leadMinutes)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutReminderSettings() when $default != null:
return $default(_that.enabled,_that.leadMinutes);case _:
  return null;

}
}

}

/// @nodoc


class _CheckoutReminderSettings implements CheckoutReminderSettings {
  const _CheckoutReminderSettings({this.enabled = false, this.leadMinutes = kDefaultCheckoutReminderLeadMinutes});
  

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  int leadMinutes;

/// Create a copy of CheckoutReminderSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutReminderSettingsCopyWith<_CheckoutReminderSettings> get copyWith => __$CheckoutReminderSettingsCopyWithImpl<_CheckoutReminderSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutReminderSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.leadMinutes, leadMinutes) || other.leadMinutes == leadMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,enabled,leadMinutes);

@override
String toString() {
  return 'CheckoutReminderSettings(enabled: $enabled, leadMinutes: $leadMinutes)';
}


}

/// @nodoc
abstract mixin class _$CheckoutReminderSettingsCopyWith<$Res> implements $CheckoutReminderSettingsCopyWith<$Res> {
  factory _$CheckoutReminderSettingsCopyWith(_CheckoutReminderSettings value, $Res Function(_CheckoutReminderSettings) _then) = __$CheckoutReminderSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, int leadMinutes
});




}
/// @nodoc
class __$CheckoutReminderSettingsCopyWithImpl<$Res>
    implements _$CheckoutReminderSettingsCopyWith<$Res> {
  __$CheckoutReminderSettingsCopyWithImpl(this._self, this._then);

  final _CheckoutReminderSettings _self;
  final $Res Function(_CheckoutReminderSettings) _then;

/// Create a copy of CheckoutReminderSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? leadMinutes = null,}) {
  return _then(_CheckoutReminderSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,leadMinutes: null == leadMinutes ? _self.leadMinutes : leadMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
