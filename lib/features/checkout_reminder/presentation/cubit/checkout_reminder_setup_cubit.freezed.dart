// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_reminder_setup_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutReminderSetupState {

 bool get isLoading; bool get enabled; bool get isTogglingEnabled; int get leadMinutes; DateTime? get scheduledFireTime; String? get errorMessage;
/// Create a copy of CheckoutReminderSetupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutReminderSetupStateCopyWith<CheckoutReminderSetupState> get copyWith => _$CheckoutReminderSetupStateCopyWithImpl<CheckoutReminderSetupState>(this as CheckoutReminderSetupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutReminderSetupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.isTogglingEnabled, isTogglingEnabled) || other.isTogglingEnabled == isTogglingEnabled)&&(identical(other.leadMinutes, leadMinutes) || other.leadMinutes == leadMinutes)&&(identical(other.scheduledFireTime, scheduledFireTime) || other.scheduledFireTime == scheduledFireTime)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,enabled,isTogglingEnabled,leadMinutes,scheduledFireTime,errorMessage);

@override
String toString() {
  return 'CheckoutReminderSetupState(isLoading: $isLoading, enabled: $enabled, isTogglingEnabled: $isTogglingEnabled, leadMinutes: $leadMinutes, scheduledFireTime: $scheduledFireTime, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CheckoutReminderSetupStateCopyWith<$Res>  {
  factory $CheckoutReminderSetupStateCopyWith(CheckoutReminderSetupState value, $Res Function(CheckoutReminderSetupState) _then) = _$CheckoutReminderSetupStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool enabled, bool isTogglingEnabled, int leadMinutes, DateTime? scheduledFireTime, String? errorMessage
});




}
/// @nodoc
class _$CheckoutReminderSetupStateCopyWithImpl<$Res>
    implements $CheckoutReminderSetupStateCopyWith<$Res> {
  _$CheckoutReminderSetupStateCopyWithImpl(this._self, this._then);

  final CheckoutReminderSetupState _self;
  final $Res Function(CheckoutReminderSetupState) _then;

/// Create a copy of CheckoutReminderSetupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? enabled = null,Object? isTogglingEnabled = null,Object? leadMinutes = null,Object? scheduledFireTime = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,isTogglingEnabled: null == isTogglingEnabled ? _self.isTogglingEnabled : isTogglingEnabled // ignore: cast_nullable_to_non_nullable
as bool,leadMinutes: null == leadMinutes ? _self.leadMinutes : leadMinutes // ignore: cast_nullable_to_non_nullable
as int,scheduledFireTime: freezed == scheduledFireTime ? _self.scheduledFireTime : scheduledFireTime // ignore: cast_nullable_to_non_nullable
as DateTime?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutReminderSetupState].
extension CheckoutReminderSetupStatePatterns on CheckoutReminderSetupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutReminderSetupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutReminderSetupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutReminderSetupState value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutReminderSetupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutReminderSetupState value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutReminderSetupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool enabled,  bool isTogglingEnabled,  int leadMinutes,  DateTime? scheduledFireTime,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutReminderSetupState() when $default != null:
return $default(_that.isLoading,_that.enabled,_that.isTogglingEnabled,_that.leadMinutes,_that.scheduledFireTime,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool enabled,  bool isTogglingEnabled,  int leadMinutes,  DateTime? scheduledFireTime,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CheckoutReminderSetupState():
return $default(_that.isLoading,_that.enabled,_that.isTogglingEnabled,_that.leadMinutes,_that.scheduledFireTime,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool enabled,  bool isTogglingEnabled,  int leadMinutes,  DateTime? scheduledFireTime,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutReminderSetupState() when $default != null:
return $default(_that.isLoading,_that.enabled,_that.isTogglingEnabled,_that.leadMinutes,_that.scheduledFireTime,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CheckoutReminderSetupState implements CheckoutReminderSetupState {
  const _CheckoutReminderSetupState({this.isLoading = true, this.enabled = false, this.isTogglingEnabled = false, this.leadMinutes = kDefaultCheckoutReminderLeadMinutes, this.scheduledFireTime, this.errorMessage});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool enabled;
@override@JsonKey() final  bool isTogglingEnabled;
@override@JsonKey() final  int leadMinutes;
@override final  DateTime? scheduledFireTime;
@override final  String? errorMessage;

/// Create a copy of CheckoutReminderSetupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutReminderSetupStateCopyWith<_CheckoutReminderSetupState> get copyWith => __$CheckoutReminderSetupStateCopyWithImpl<_CheckoutReminderSetupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutReminderSetupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.isTogglingEnabled, isTogglingEnabled) || other.isTogglingEnabled == isTogglingEnabled)&&(identical(other.leadMinutes, leadMinutes) || other.leadMinutes == leadMinutes)&&(identical(other.scheduledFireTime, scheduledFireTime) || other.scheduledFireTime == scheduledFireTime)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,enabled,isTogglingEnabled,leadMinutes,scheduledFireTime,errorMessage);

@override
String toString() {
  return 'CheckoutReminderSetupState(isLoading: $isLoading, enabled: $enabled, isTogglingEnabled: $isTogglingEnabled, leadMinutes: $leadMinutes, scheduledFireTime: $scheduledFireTime, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CheckoutReminderSetupStateCopyWith<$Res> implements $CheckoutReminderSetupStateCopyWith<$Res> {
  factory _$CheckoutReminderSetupStateCopyWith(_CheckoutReminderSetupState value, $Res Function(_CheckoutReminderSetupState) _then) = __$CheckoutReminderSetupStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool enabled, bool isTogglingEnabled, int leadMinutes, DateTime? scheduledFireTime, String? errorMessage
});




}
/// @nodoc
class __$CheckoutReminderSetupStateCopyWithImpl<$Res>
    implements _$CheckoutReminderSetupStateCopyWith<$Res> {
  __$CheckoutReminderSetupStateCopyWithImpl(this._self, this._then);

  final _CheckoutReminderSetupState _self;
  final $Res Function(_CheckoutReminderSetupState) _then;

/// Create a copy of CheckoutReminderSetupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? enabled = null,Object? isTogglingEnabled = null,Object? leadMinutes = null,Object? scheduledFireTime = freezed,Object? errorMessage = freezed,}) {
  return _then(_CheckoutReminderSetupState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,isTogglingEnabled: null == isTogglingEnabled ? _self.isTogglingEnabled : isTogglingEnabled // ignore: cast_nullable_to_non_nullable
as bool,leadMinutes: null == leadMinutes ? _self.leadMinutes : leadMinutes // ignore: cast_nullable_to_non_nullable
as int,scheduledFireTime: freezed == scheduledFireTime ? _self.scheduledFireTime : scheduledFireTime // ignore: cast_nullable_to_non_nullable
as DateTime?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
