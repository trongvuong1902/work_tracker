// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bug_ai_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BugAiState {

 AiTarget get target; bool get isStreaming;// Raw model output — may include a leading `FRAMEWORK:` marker line while
// streaming. Use [displayText] for anything user-facing.
 String get text; String? get framework; bool get done; String? get errorMessage;
/// Create a copy of BugAiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BugAiStateCopyWith<BugAiState> get copyWith => _$BugAiStateCopyWithImpl<BugAiState>(this as BugAiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BugAiState&&(identical(other.target, target) || other.target == target)&&(identical(other.isStreaming, isStreaming) || other.isStreaming == isStreaming)&&(identical(other.text, text) || other.text == text)&&(identical(other.framework, framework) || other.framework == framework)&&(identical(other.done, done) || other.done == done)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,target,isStreaming,text,framework,done,errorMessage);

@override
String toString() {
  return 'BugAiState(target: $target, isStreaming: $isStreaming, text: $text, framework: $framework, done: $done, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $BugAiStateCopyWith<$Res>  {
  factory $BugAiStateCopyWith(BugAiState value, $Res Function(BugAiState) _then) = _$BugAiStateCopyWithImpl;
@useResult
$Res call({
 AiTarget target, bool isStreaming, String text, String? framework, bool done, String? errorMessage
});




}
/// @nodoc
class _$BugAiStateCopyWithImpl<$Res>
    implements $BugAiStateCopyWith<$Res> {
  _$BugAiStateCopyWithImpl(this._self, this._then);

  final BugAiState _self;
  final $Res Function(BugAiState) _then;

/// Create a copy of BugAiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? target = null,Object? isStreaming = null,Object? text = null,Object? framework = freezed,Object? done = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as AiTarget,isStreaming: null == isStreaming ? _self.isStreaming : isStreaming // ignore: cast_nullable_to_non_nullable
as bool,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,framework: freezed == framework ? _self.framework : framework // ignore: cast_nullable_to_non_nullable
as String?,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BugAiState].
extension BugAiStatePatterns on BugAiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BugAiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BugAiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BugAiState value)  $default,){
final _that = this;
switch (_that) {
case _BugAiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BugAiState value)?  $default,){
final _that = this;
switch (_that) {
case _BugAiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AiTarget target,  bool isStreaming,  String text,  String? framework,  bool done,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BugAiState() when $default != null:
return $default(_that.target,_that.isStreaming,_that.text,_that.framework,_that.done,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AiTarget target,  bool isStreaming,  String text,  String? framework,  bool done,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _BugAiState():
return $default(_that.target,_that.isStreaming,_that.text,_that.framework,_that.done,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AiTarget target,  bool isStreaming,  String text,  String? framework,  bool done,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _BugAiState() when $default != null:
return $default(_that.target,_that.isStreaming,_that.text,_that.framework,_that.done,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _BugAiState implements BugAiState {
  const _BugAiState({this.target = AiTarget.claude, this.isStreaming = false, this.text = '', this.framework, this.done = false, this.errorMessage});
  

@override@JsonKey() final  AiTarget target;
@override@JsonKey() final  bool isStreaming;
// Raw model output — may include a leading `FRAMEWORK:` marker line while
// streaming. Use [displayText] for anything user-facing.
@override@JsonKey() final  String text;
@override final  String? framework;
@override@JsonKey() final  bool done;
@override final  String? errorMessage;

/// Create a copy of BugAiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BugAiStateCopyWith<_BugAiState> get copyWith => __$BugAiStateCopyWithImpl<_BugAiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BugAiState&&(identical(other.target, target) || other.target == target)&&(identical(other.isStreaming, isStreaming) || other.isStreaming == isStreaming)&&(identical(other.text, text) || other.text == text)&&(identical(other.framework, framework) || other.framework == framework)&&(identical(other.done, done) || other.done == done)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,target,isStreaming,text,framework,done,errorMessage);

@override
String toString() {
  return 'BugAiState(target: $target, isStreaming: $isStreaming, text: $text, framework: $framework, done: $done, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$BugAiStateCopyWith<$Res> implements $BugAiStateCopyWith<$Res> {
  factory _$BugAiStateCopyWith(_BugAiState value, $Res Function(_BugAiState) _then) = __$BugAiStateCopyWithImpl;
@override @useResult
$Res call({
 AiTarget target, bool isStreaming, String text, String? framework, bool done, String? errorMessage
});




}
/// @nodoc
class __$BugAiStateCopyWithImpl<$Res>
    implements _$BugAiStateCopyWith<$Res> {
  __$BugAiStateCopyWithImpl(this._self, this._then);

  final _BugAiState _self;
  final $Res Function(_BugAiState) _then;

/// Create a copy of BugAiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? target = null,Object? isStreaming = null,Object? text = null,Object? framework = freezed,Object? done = null,Object? errorMessage = freezed,}) {
  return _then(_BugAiState(
target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as AiTarget,isStreaming: null == isStreaming ? _self.isStreaming : isStreaming // ignore: cast_nullable_to_non_nullable
as bool,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,framework: freezed == framework ? _self.framework : framework // ignore: cast_nullable_to_non_nullable
as String?,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
