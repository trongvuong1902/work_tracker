// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_log_setup_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationLogSetupState {

 bool get isLoading; bool get enabled; bool get isTogglingEnabled; bool get hasWorkLocation; String? get errorMessage;
/// Create a copy of LocationLogSetupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationLogSetupStateCopyWith<LocationLogSetupState> get copyWith => _$LocationLogSetupStateCopyWithImpl<LocationLogSetupState>(this as LocationLogSetupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationLogSetupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.isTogglingEnabled, isTogglingEnabled) || other.isTogglingEnabled == isTogglingEnabled)&&(identical(other.hasWorkLocation, hasWorkLocation) || other.hasWorkLocation == hasWorkLocation)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,enabled,isTogglingEnabled,hasWorkLocation,errorMessage);

@override
String toString() {
  return 'LocationLogSetupState(isLoading: $isLoading, enabled: $enabled, isTogglingEnabled: $isTogglingEnabled, hasWorkLocation: $hasWorkLocation, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $LocationLogSetupStateCopyWith<$Res>  {
  factory $LocationLogSetupStateCopyWith(LocationLogSetupState value, $Res Function(LocationLogSetupState) _then) = _$LocationLogSetupStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool enabled, bool isTogglingEnabled, bool hasWorkLocation, String? errorMessage
});




}
/// @nodoc
class _$LocationLogSetupStateCopyWithImpl<$Res>
    implements $LocationLogSetupStateCopyWith<$Res> {
  _$LocationLogSetupStateCopyWithImpl(this._self, this._then);

  final LocationLogSetupState _self;
  final $Res Function(LocationLogSetupState) _then;

/// Create a copy of LocationLogSetupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? enabled = null,Object? isTogglingEnabled = null,Object? hasWorkLocation = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,isTogglingEnabled: null == isTogglingEnabled ? _self.isTogglingEnabled : isTogglingEnabled // ignore: cast_nullable_to_non_nullable
as bool,hasWorkLocation: null == hasWorkLocation ? _self.hasWorkLocation : hasWorkLocation // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationLogSetupState].
extension LocationLogSetupStatePatterns on LocationLogSetupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationLogSetupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationLogSetupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationLogSetupState value)  $default,){
final _that = this;
switch (_that) {
case _LocationLogSetupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationLogSetupState value)?  $default,){
final _that = this;
switch (_that) {
case _LocationLogSetupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool enabled,  bool isTogglingEnabled,  bool hasWorkLocation,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationLogSetupState() when $default != null:
return $default(_that.isLoading,_that.enabled,_that.isTogglingEnabled,_that.hasWorkLocation,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool enabled,  bool isTogglingEnabled,  bool hasWorkLocation,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _LocationLogSetupState():
return $default(_that.isLoading,_that.enabled,_that.isTogglingEnabled,_that.hasWorkLocation,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool enabled,  bool isTogglingEnabled,  bool hasWorkLocation,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _LocationLogSetupState() when $default != null:
return $default(_that.isLoading,_that.enabled,_that.isTogglingEnabled,_that.hasWorkLocation,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _LocationLogSetupState implements LocationLogSetupState {
  const _LocationLogSetupState({this.isLoading = true, this.enabled = false, this.isTogglingEnabled = false, this.hasWorkLocation = false, this.errorMessage});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool enabled;
@override@JsonKey() final  bool isTogglingEnabled;
@override@JsonKey() final  bool hasWorkLocation;
@override final  String? errorMessage;

/// Create a copy of LocationLogSetupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationLogSetupStateCopyWith<_LocationLogSetupState> get copyWith => __$LocationLogSetupStateCopyWithImpl<_LocationLogSetupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationLogSetupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.isTogglingEnabled, isTogglingEnabled) || other.isTogglingEnabled == isTogglingEnabled)&&(identical(other.hasWorkLocation, hasWorkLocation) || other.hasWorkLocation == hasWorkLocation)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,enabled,isTogglingEnabled,hasWorkLocation,errorMessage);

@override
String toString() {
  return 'LocationLogSetupState(isLoading: $isLoading, enabled: $enabled, isTogglingEnabled: $isTogglingEnabled, hasWorkLocation: $hasWorkLocation, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$LocationLogSetupStateCopyWith<$Res> implements $LocationLogSetupStateCopyWith<$Res> {
  factory _$LocationLogSetupStateCopyWith(_LocationLogSetupState value, $Res Function(_LocationLogSetupState) _then) = __$LocationLogSetupStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool enabled, bool isTogglingEnabled, bool hasWorkLocation, String? errorMessage
});




}
/// @nodoc
class __$LocationLogSetupStateCopyWithImpl<$Res>
    implements _$LocationLogSetupStateCopyWith<$Res> {
  __$LocationLogSetupStateCopyWithImpl(this._self, this._then);

  final _LocationLogSetupState _self;
  final $Res Function(_LocationLogSetupState) _then;

/// Create a copy of LocationLogSetupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? enabled = null,Object? isTogglingEnabled = null,Object? hasWorkLocation = null,Object? errorMessage = freezed,}) {
  return _then(_LocationLogSetupState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,isTogglingEnabled: null == isTogglingEnabled ? _self.isTogglingEnabled : isTogglingEnabled // ignore: cast_nullable_to_non_nullable
as bool,hasWorkLocation: null == hasWorkLocation ? _self.hasWorkLocation : hasWorkLocation // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
