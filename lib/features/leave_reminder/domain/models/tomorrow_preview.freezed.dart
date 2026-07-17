// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tomorrow_preview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TomorrowPreview {

 DateTime get leaveTime; int get averageCommuteMinutes; int? get weatherCode; double? get temperature; String get bodyText;
/// Create a copy of TomorrowPreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TomorrowPreviewCopyWith<TomorrowPreview> get copyWith => _$TomorrowPreviewCopyWithImpl<TomorrowPreview>(this as TomorrowPreview, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TomorrowPreview&&(identical(other.leaveTime, leaveTime) || other.leaveTime == leaveTime)&&(identical(other.averageCommuteMinutes, averageCommuteMinutes) || other.averageCommuteMinutes == averageCommuteMinutes)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.bodyText, bodyText) || other.bodyText == bodyText));
}


@override
int get hashCode => Object.hash(runtimeType,leaveTime,averageCommuteMinutes,weatherCode,temperature,bodyText);

@override
String toString() {
  return 'TomorrowPreview(leaveTime: $leaveTime, averageCommuteMinutes: $averageCommuteMinutes, weatherCode: $weatherCode, temperature: $temperature, bodyText: $bodyText)';
}


}

/// @nodoc
abstract mixin class $TomorrowPreviewCopyWith<$Res>  {
  factory $TomorrowPreviewCopyWith(TomorrowPreview value, $Res Function(TomorrowPreview) _then) = _$TomorrowPreviewCopyWithImpl;
@useResult
$Res call({
 DateTime leaveTime, int averageCommuteMinutes, int? weatherCode, double? temperature, String bodyText
});




}
/// @nodoc
class _$TomorrowPreviewCopyWithImpl<$Res>
    implements $TomorrowPreviewCopyWith<$Res> {
  _$TomorrowPreviewCopyWithImpl(this._self, this._then);

  final TomorrowPreview _self;
  final $Res Function(TomorrowPreview) _then;

/// Create a copy of TomorrowPreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leaveTime = null,Object? averageCommuteMinutes = null,Object? weatherCode = freezed,Object? temperature = freezed,Object? bodyText = null,}) {
  return _then(_self.copyWith(
leaveTime: null == leaveTime ? _self.leaveTime : leaveTime // ignore: cast_nullable_to_non_nullable
as DateTime,averageCommuteMinutes: null == averageCommuteMinutes ? _self.averageCommuteMinutes : averageCommuteMinutes // ignore: cast_nullable_to_non_nullable
as int,weatherCode: freezed == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,bodyText: null == bodyText ? _self.bodyText : bodyText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TomorrowPreview].
extension TomorrowPreviewPatterns on TomorrowPreview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TomorrowPreview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TomorrowPreview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TomorrowPreview value)  $default,){
final _that = this;
switch (_that) {
case _TomorrowPreview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TomorrowPreview value)?  $default,){
final _that = this;
switch (_that) {
case _TomorrowPreview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime leaveTime,  int averageCommuteMinutes,  int? weatherCode,  double? temperature,  String bodyText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TomorrowPreview() when $default != null:
return $default(_that.leaveTime,_that.averageCommuteMinutes,_that.weatherCode,_that.temperature,_that.bodyText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime leaveTime,  int averageCommuteMinutes,  int? weatherCode,  double? temperature,  String bodyText)  $default,) {final _that = this;
switch (_that) {
case _TomorrowPreview():
return $default(_that.leaveTime,_that.averageCommuteMinutes,_that.weatherCode,_that.temperature,_that.bodyText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime leaveTime,  int averageCommuteMinutes,  int? weatherCode,  double? temperature,  String bodyText)?  $default,) {final _that = this;
switch (_that) {
case _TomorrowPreview() when $default != null:
return $default(_that.leaveTime,_that.averageCommuteMinutes,_that.weatherCode,_that.temperature,_that.bodyText);case _:
  return null;

}
}

}

/// @nodoc


class _TomorrowPreview implements TomorrowPreview {
  const _TomorrowPreview({required this.leaveTime, required this.averageCommuteMinutes, this.weatherCode, this.temperature, required this.bodyText});
  

@override final  DateTime leaveTime;
@override final  int averageCommuteMinutes;
@override final  int? weatherCode;
@override final  double? temperature;
@override final  String bodyText;

/// Create a copy of TomorrowPreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TomorrowPreviewCopyWith<_TomorrowPreview> get copyWith => __$TomorrowPreviewCopyWithImpl<_TomorrowPreview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TomorrowPreview&&(identical(other.leaveTime, leaveTime) || other.leaveTime == leaveTime)&&(identical(other.averageCommuteMinutes, averageCommuteMinutes) || other.averageCommuteMinutes == averageCommuteMinutes)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.bodyText, bodyText) || other.bodyText == bodyText));
}


@override
int get hashCode => Object.hash(runtimeType,leaveTime,averageCommuteMinutes,weatherCode,temperature,bodyText);

@override
String toString() {
  return 'TomorrowPreview(leaveTime: $leaveTime, averageCommuteMinutes: $averageCommuteMinutes, weatherCode: $weatherCode, temperature: $temperature, bodyText: $bodyText)';
}


}

/// @nodoc
abstract mixin class _$TomorrowPreviewCopyWith<$Res> implements $TomorrowPreviewCopyWith<$Res> {
  factory _$TomorrowPreviewCopyWith(_TomorrowPreview value, $Res Function(_TomorrowPreview) _then) = __$TomorrowPreviewCopyWithImpl;
@override @useResult
$Res call({
 DateTime leaveTime, int averageCommuteMinutes, int? weatherCode, double? temperature, String bodyText
});




}
/// @nodoc
class __$TomorrowPreviewCopyWithImpl<$Res>
    implements _$TomorrowPreviewCopyWith<$Res> {
  __$TomorrowPreviewCopyWithImpl(this._self, this._then);

  final _TomorrowPreview _self;
  final $Res Function(_TomorrowPreview) _then;

/// Create a copy of TomorrowPreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leaveTime = null,Object? averageCommuteMinutes = null,Object? weatherCode = freezed,Object? temperature = freezed,Object? bodyText = null,}) {
  return _then(_TomorrowPreview(
leaveTime: null == leaveTime ? _self.leaveTime : leaveTime // ignore: cast_nullable_to_non_nullable
as DateTime,averageCommuteMinutes: null == averageCommuteMinutes ? _self.averageCommuteMinutes : averageCommuteMinutes // ignore: cast_nullable_to_non_nullable
as int,weatherCode: freezed == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,bodyText: null == bodyText ? _self.bodyText : bodyText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
