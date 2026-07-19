// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bug_sync_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BugSyncState {

 bool get isSyncing; bool get done; int get added; int get updated; int get failedProducts; String? get progressText; String? get errorMessage;
/// Create a copy of BugSyncState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BugSyncStateCopyWith<BugSyncState> get copyWith => _$BugSyncStateCopyWithImpl<BugSyncState>(this as BugSyncState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BugSyncState&&(identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing)&&(identical(other.done, done) || other.done == done)&&(identical(other.added, added) || other.added == added)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.failedProducts, failedProducts) || other.failedProducts == failedProducts)&&(identical(other.progressText, progressText) || other.progressText == progressText)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isSyncing,done,added,updated,failedProducts,progressText,errorMessage);

@override
String toString() {
  return 'BugSyncState(isSyncing: $isSyncing, done: $done, added: $added, updated: $updated, failedProducts: $failedProducts, progressText: $progressText, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $BugSyncStateCopyWith<$Res>  {
  factory $BugSyncStateCopyWith(BugSyncState value, $Res Function(BugSyncState) _then) = _$BugSyncStateCopyWithImpl;
@useResult
$Res call({
 bool isSyncing, bool done, int added, int updated, int failedProducts, String? progressText, String? errorMessage
});




}
/// @nodoc
class _$BugSyncStateCopyWithImpl<$Res>
    implements $BugSyncStateCopyWith<$Res> {
  _$BugSyncStateCopyWithImpl(this._self, this._then);

  final BugSyncState _self;
  final $Res Function(BugSyncState) _then;

/// Create a copy of BugSyncState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSyncing = null,Object? done = null,Object? added = null,Object? updated = null,Object? failedProducts = null,Object? progressText = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,added: null == added ? _self.added : added // ignore: cast_nullable_to_non_nullable
as int,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as int,failedProducts: null == failedProducts ? _self.failedProducts : failedProducts // ignore: cast_nullable_to_non_nullable
as int,progressText: freezed == progressText ? _self.progressText : progressText // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BugSyncState].
extension BugSyncStatePatterns on BugSyncState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BugSyncState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BugSyncState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BugSyncState value)  $default,){
final _that = this;
switch (_that) {
case _BugSyncState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BugSyncState value)?  $default,){
final _that = this;
switch (_that) {
case _BugSyncState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSyncing,  bool done,  int added,  int updated,  int failedProducts,  String? progressText,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BugSyncState() when $default != null:
return $default(_that.isSyncing,_that.done,_that.added,_that.updated,_that.failedProducts,_that.progressText,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSyncing,  bool done,  int added,  int updated,  int failedProducts,  String? progressText,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _BugSyncState():
return $default(_that.isSyncing,_that.done,_that.added,_that.updated,_that.failedProducts,_that.progressText,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSyncing,  bool done,  int added,  int updated,  int failedProducts,  String? progressText,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _BugSyncState() when $default != null:
return $default(_that.isSyncing,_that.done,_that.added,_that.updated,_that.failedProducts,_that.progressText,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _BugSyncState implements BugSyncState {
  const _BugSyncState({this.isSyncing = false, this.done = false, this.added = 0, this.updated = 0, this.failedProducts = 0, this.progressText, this.errorMessage});
  

@override@JsonKey() final  bool isSyncing;
@override@JsonKey() final  bool done;
@override@JsonKey() final  int added;
@override@JsonKey() final  int updated;
@override@JsonKey() final  int failedProducts;
@override final  String? progressText;
@override final  String? errorMessage;

/// Create a copy of BugSyncState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BugSyncStateCopyWith<_BugSyncState> get copyWith => __$BugSyncStateCopyWithImpl<_BugSyncState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BugSyncState&&(identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing)&&(identical(other.done, done) || other.done == done)&&(identical(other.added, added) || other.added == added)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.failedProducts, failedProducts) || other.failedProducts == failedProducts)&&(identical(other.progressText, progressText) || other.progressText == progressText)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isSyncing,done,added,updated,failedProducts,progressText,errorMessage);

@override
String toString() {
  return 'BugSyncState(isSyncing: $isSyncing, done: $done, added: $added, updated: $updated, failedProducts: $failedProducts, progressText: $progressText, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$BugSyncStateCopyWith<$Res> implements $BugSyncStateCopyWith<$Res> {
  factory _$BugSyncStateCopyWith(_BugSyncState value, $Res Function(_BugSyncState) _then) = __$BugSyncStateCopyWithImpl;
@override @useResult
$Res call({
 bool isSyncing, bool done, int added, int updated, int failedProducts, String? progressText, String? errorMessage
});




}
/// @nodoc
class __$BugSyncStateCopyWithImpl<$Res>
    implements _$BugSyncStateCopyWith<$Res> {
  __$BugSyncStateCopyWithImpl(this._self, this._then);

  final _BugSyncState _self;
  final $Res Function(_BugSyncState) _then;

/// Create a copy of BugSyncState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSyncing = null,Object? done = null,Object? added = null,Object? updated = null,Object? failedProducts = null,Object? progressText = freezed,Object? errorMessage = freezed,}) {
  return _then(_BugSyncState(
isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,added: null == added ? _self.added : added // ignore: cast_nullable_to_non_nullable
as int,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as int,failedProducts: null == failedProducts ? _self.failedProducts : failedProducts // ignore: cast_nullable_to_non_nullable
as int,progressText: freezed == progressText ? _self.progressText : progressText // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
