// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hero_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HeroCardModel {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeroCardModel);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HeroCardModel()';
}


}

/// @nodoc
class $HeroCardModelCopyWith<$Res>  {
$HeroCardModelCopyWith(HeroCardModel _, $Res Function(HeroCardModel) __);
}


/// Adds pattern-matching-related methods to [HeroCardModel].
extension HeroCardModelPatterns on HeroCardModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _BeforeCheckIn value)?  beforeCheckIn,TResult Function( _Working value)?  working,TResult Function( _AfterCheckOut value)?  afterCheckOut,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BeforeCheckIn() when beforeCheckIn != null:
return beforeCheckIn(_that);case _Working() when working != null:
return working(_that);case _AfterCheckOut() when afterCheckOut != null:
return afterCheckOut(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _BeforeCheckIn value)  beforeCheckIn,required TResult Function( _Working value)  working,required TResult Function( _AfterCheckOut value)  afterCheckOut,}){
final _that = this;
switch (_that) {
case _BeforeCheckIn():
return beforeCheckIn(_that);case _Working():
return working(_that);case _AfterCheckOut():
return afterCheckOut(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _BeforeCheckIn value)?  beforeCheckIn,TResult? Function( _Working value)?  working,TResult? Function( _AfterCheckOut value)?  afterCheckOut,}){
final _that = this;
switch (_that) {
case _BeforeCheckIn() when beforeCheckIn != null:
return beforeCheckIn(_that);case _Working() when working != null:
return working(_that);case _AfterCheckOut() when afterCheckOut != null:
return afterCheckOut(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( DateTime? leaveHomeAt,  DateTime? arriveAtWorkAt)?  beforeCheckIn,TResult Function( DateTime checkIn,  DateTime leaveAt,  DateTime breakStart,  DateTime breakEnd)?  working,TResult Function()?  afterCheckOut,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BeforeCheckIn() when beforeCheckIn != null:
return beforeCheckIn(_that.leaveHomeAt,_that.arriveAtWorkAt);case _Working() when working != null:
return working(_that.checkIn,_that.leaveAt,_that.breakStart,_that.breakEnd);case _AfterCheckOut() when afterCheckOut != null:
return afterCheckOut();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( DateTime? leaveHomeAt,  DateTime? arriveAtWorkAt)  beforeCheckIn,required TResult Function( DateTime checkIn,  DateTime leaveAt,  DateTime breakStart,  DateTime breakEnd)  working,required TResult Function()  afterCheckOut,}) {final _that = this;
switch (_that) {
case _BeforeCheckIn():
return beforeCheckIn(_that.leaveHomeAt,_that.arriveAtWorkAt);case _Working():
return working(_that.checkIn,_that.leaveAt,_that.breakStart,_that.breakEnd);case _AfterCheckOut():
return afterCheckOut();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( DateTime? leaveHomeAt,  DateTime? arriveAtWorkAt)?  beforeCheckIn,TResult? Function( DateTime checkIn,  DateTime leaveAt,  DateTime breakStart,  DateTime breakEnd)?  working,TResult? Function()?  afterCheckOut,}) {final _that = this;
switch (_that) {
case _BeforeCheckIn() when beforeCheckIn != null:
return beforeCheckIn(_that.leaveHomeAt,_that.arriveAtWorkAt);case _Working() when working != null:
return working(_that.checkIn,_that.leaveAt,_that.breakStart,_that.breakEnd);case _AfterCheckOut() when afterCheckOut != null:
return afterCheckOut();case _:
  return null;

}
}

}

/// @nodoc


class _BeforeCheckIn implements HeroCardModel {
  const _BeforeCheckIn({this.leaveHomeAt, this.arriveAtWorkAt});
  

 final  DateTime? leaveHomeAt;
 final  DateTime? arriveAtWorkAt;

/// Create a copy of HeroCardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BeforeCheckInCopyWith<_BeforeCheckIn> get copyWith => __$BeforeCheckInCopyWithImpl<_BeforeCheckIn>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BeforeCheckIn&&(identical(other.leaveHomeAt, leaveHomeAt) || other.leaveHomeAt == leaveHomeAt)&&(identical(other.arriveAtWorkAt, arriveAtWorkAt) || other.arriveAtWorkAt == arriveAtWorkAt));
}


@override
int get hashCode => Object.hash(runtimeType,leaveHomeAt,arriveAtWorkAt);

@override
String toString() {
  return 'HeroCardModel.beforeCheckIn(leaveHomeAt: $leaveHomeAt, arriveAtWorkAt: $arriveAtWorkAt)';
}


}

/// @nodoc
abstract mixin class _$BeforeCheckInCopyWith<$Res> implements $HeroCardModelCopyWith<$Res> {
  factory _$BeforeCheckInCopyWith(_BeforeCheckIn value, $Res Function(_BeforeCheckIn) _then) = __$BeforeCheckInCopyWithImpl;
@useResult
$Res call({
 DateTime? leaveHomeAt, DateTime? arriveAtWorkAt
});




}
/// @nodoc
class __$BeforeCheckInCopyWithImpl<$Res>
    implements _$BeforeCheckInCopyWith<$Res> {
  __$BeforeCheckInCopyWithImpl(this._self, this._then);

  final _BeforeCheckIn _self;
  final $Res Function(_BeforeCheckIn) _then;

/// Create a copy of HeroCardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? leaveHomeAt = freezed,Object? arriveAtWorkAt = freezed,}) {
  return _then(_BeforeCheckIn(
leaveHomeAt: freezed == leaveHomeAt ? _self.leaveHomeAt : leaveHomeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,arriveAtWorkAt: freezed == arriveAtWorkAt ? _self.arriveAtWorkAt : arriveAtWorkAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class _Working implements HeroCardModel {
  const _Working({required this.checkIn, required this.leaveAt, required this.breakStart, required this.breakEnd});
  

 final  DateTime checkIn;
 final  DateTime leaveAt;
 final  DateTime breakStart;
 final  DateTime breakEnd;

/// Create a copy of HeroCardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkingCopyWith<_Working> get copyWith => __$WorkingCopyWithImpl<_Working>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Working&&(identical(other.checkIn, checkIn) || other.checkIn == checkIn)&&(identical(other.leaveAt, leaveAt) || other.leaveAt == leaveAt)&&(identical(other.breakStart, breakStart) || other.breakStart == breakStart)&&(identical(other.breakEnd, breakEnd) || other.breakEnd == breakEnd));
}


@override
int get hashCode => Object.hash(runtimeType,checkIn,leaveAt,breakStart,breakEnd);

@override
String toString() {
  return 'HeroCardModel.working(checkIn: $checkIn, leaveAt: $leaveAt, breakStart: $breakStart, breakEnd: $breakEnd)';
}


}

/// @nodoc
abstract mixin class _$WorkingCopyWith<$Res> implements $HeroCardModelCopyWith<$Res> {
  factory _$WorkingCopyWith(_Working value, $Res Function(_Working) _then) = __$WorkingCopyWithImpl;
@useResult
$Res call({
 DateTime checkIn, DateTime leaveAt, DateTime breakStart, DateTime breakEnd
});




}
/// @nodoc
class __$WorkingCopyWithImpl<$Res>
    implements _$WorkingCopyWith<$Res> {
  __$WorkingCopyWithImpl(this._self, this._then);

  final _Working _self;
  final $Res Function(_Working) _then;

/// Create a copy of HeroCardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? checkIn = null,Object? leaveAt = null,Object? breakStart = null,Object? breakEnd = null,}) {
  return _then(_Working(
checkIn: null == checkIn ? _self.checkIn : checkIn // ignore: cast_nullable_to_non_nullable
as DateTime,leaveAt: null == leaveAt ? _self.leaveAt : leaveAt // ignore: cast_nullable_to_non_nullable
as DateTime,breakStart: null == breakStart ? _self.breakStart : breakStart // ignore: cast_nullable_to_non_nullable
as DateTime,breakEnd: null == breakEnd ? _self.breakEnd : breakEnd // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class _AfterCheckOut implements HeroCardModel {
  const _AfterCheckOut();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AfterCheckOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HeroCardModel.afterCheckOut()';
}


}




// dart format on
