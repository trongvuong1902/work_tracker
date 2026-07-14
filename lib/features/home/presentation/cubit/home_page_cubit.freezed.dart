// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_page_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomePageState {

 DateTime? get checkInTime; DateTime? get checkOutTime; WorkSchedule? get workSchedule; HeroCardModel? get heroCardModel; AttendanceCardModel? get attendanceCardModel;
/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomePageStateCopyWith<HomePageState> get copyWith => _$HomePageStateCopyWithImpl<HomePageState>(this as HomePageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomePageState&&(identical(other.checkInTime, checkInTime) || other.checkInTime == checkInTime)&&(identical(other.checkOutTime, checkOutTime) || other.checkOutTime == checkOutTime)&&(identical(other.workSchedule, workSchedule) || other.workSchedule == workSchedule)&&(identical(other.heroCardModel, heroCardModel) || other.heroCardModel == heroCardModel)&&(identical(other.attendanceCardModel, attendanceCardModel) || other.attendanceCardModel == attendanceCardModel));
}


@override
int get hashCode => Object.hash(runtimeType,checkInTime,checkOutTime,workSchedule,heroCardModel,attendanceCardModel);

@override
String toString() {
  return 'HomePageState(checkInTime: $checkInTime, checkOutTime: $checkOutTime, workSchedule: $workSchedule, heroCardModel: $heroCardModel, attendanceCardModel: $attendanceCardModel)';
}


}

/// @nodoc
abstract mixin class $HomePageStateCopyWith<$Res>  {
  factory $HomePageStateCopyWith(HomePageState value, $Res Function(HomePageState) _then) = _$HomePageStateCopyWithImpl;
@useResult
$Res call({
 DateTime? checkInTime, DateTime? checkOutTime, WorkSchedule? workSchedule, HeroCardModel? heroCardModel, AttendanceCardModel? attendanceCardModel
});


$WorkScheduleCopyWith<$Res>? get workSchedule;$HeroCardModelCopyWith<$Res>? get heroCardModel;$AttendanceCardModelCopyWith<$Res>? get attendanceCardModel;

}
/// @nodoc
class _$HomePageStateCopyWithImpl<$Res>
    implements $HomePageStateCopyWith<$Res> {
  _$HomePageStateCopyWithImpl(this._self, this._then);

  final HomePageState _self;
  final $Res Function(HomePageState) _then;

/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? checkInTime = freezed,Object? checkOutTime = freezed,Object? workSchedule = freezed,Object? heroCardModel = freezed,Object? attendanceCardModel = freezed,}) {
  return _then(_self.copyWith(
checkInTime: freezed == checkInTime ? _self.checkInTime : checkInTime // ignore: cast_nullable_to_non_nullable
as DateTime?,checkOutTime: freezed == checkOutTime ? _self.checkOutTime : checkOutTime // ignore: cast_nullable_to_non_nullable
as DateTime?,workSchedule: freezed == workSchedule ? _self.workSchedule : workSchedule // ignore: cast_nullable_to_non_nullable
as WorkSchedule?,heroCardModel: freezed == heroCardModel ? _self.heroCardModel : heroCardModel // ignore: cast_nullable_to_non_nullable
as HeroCardModel?,attendanceCardModel: freezed == attendanceCardModel ? _self.attendanceCardModel : attendanceCardModel // ignore: cast_nullable_to_non_nullable
as AttendanceCardModel?,
  ));
}
/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkScheduleCopyWith<$Res>? get workSchedule {
    if (_self.workSchedule == null) {
    return null;
  }

  return $WorkScheduleCopyWith<$Res>(_self.workSchedule!, (value) {
    return _then(_self.copyWith(workSchedule: value));
  });
}/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HeroCardModelCopyWith<$Res>? get heroCardModel {
    if (_self.heroCardModel == null) {
    return null;
  }

  return $HeroCardModelCopyWith<$Res>(_self.heroCardModel!, (value) {
    return _then(_self.copyWith(heroCardModel: value));
  });
}/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceCardModelCopyWith<$Res>? get attendanceCardModel {
    if (_self.attendanceCardModel == null) {
    return null;
  }

  return $AttendanceCardModelCopyWith<$Res>(_self.attendanceCardModel!, (value) {
    return _then(_self.copyWith(attendanceCardModel: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomePageState].
extension HomePageStatePatterns on HomePageState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomePageState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomePageState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomePageState value)  $default,){
final _that = this;
switch (_that) {
case _HomePageState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomePageState value)?  $default,){
final _that = this;
switch (_that) {
case _HomePageState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? checkInTime,  DateTime? checkOutTime,  WorkSchedule? workSchedule,  HeroCardModel? heroCardModel,  AttendanceCardModel? attendanceCardModel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomePageState() when $default != null:
return $default(_that.checkInTime,_that.checkOutTime,_that.workSchedule,_that.heroCardModel,_that.attendanceCardModel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? checkInTime,  DateTime? checkOutTime,  WorkSchedule? workSchedule,  HeroCardModel? heroCardModel,  AttendanceCardModel? attendanceCardModel)  $default,) {final _that = this;
switch (_that) {
case _HomePageState():
return $default(_that.checkInTime,_that.checkOutTime,_that.workSchedule,_that.heroCardModel,_that.attendanceCardModel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? checkInTime,  DateTime? checkOutTime,  WorkSchedule? workSchedule,  HeroCardModel? heroCardModel,  AttendanceCardModel? attendanceCardModel)?  $default,) {final _that = this;
switch (_that) {
case _HomePageState() when $default != null:
return $default(_that.checkInTime,_that.checkOutTime,_that.workSchedule,_that.heroCardModel,_that.attendanceCardModel);case _:
  return null;

}
}

}

/// @nodoc


class _HomePageState implements HomePageState {
  const _HomePageState({this.checkInTime, this.checkOutTime, this.workSchedule, this.heroCardModel, this.attendanceCardModel});
  

@override final  DateTime? checkInTime;
@override final  DateTime? checkOutTime;
@override final  WorkSchedule? workSchedule;
@override final  HeroCardModel? heroCardModel;
@override final  AttendanceCardModel? attendanceCardModel;

/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomePageStateCopyWith<_HomePageState> get copyWith => __$HomePageStateCopyWithImpl<_HomePageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomePageState&&(identical(other.checkInTime, checkInTime) || other.checkInTime == checkInTime)&&(identical(other.checkOutTime, checkOutTime) || other.checkOutTime == checkOutTime)&&(identical(other.workSchedule, workSchedule) || other.workSchedule == workSchedule)&&(identical(other.heroCardModel, heroCardModel) || other.heroCardModel == heroCardModel)&&(identical(other.attendanceCardModel, attendanceCardModel) || other.attendanceCardModel == attendanceCardModel));
}


@override
int get hashCode => Object.hash(runtimeType,checkInTime,checkOutTime,workSchedule,heroCardModel,attendanceCardModel);

@override
String toString() {
  return 'HomePageState(checkInTime: $checkInTime, checkOutTime: $checkOutTime, workSchedule: $workSchedule, heroCardModel: $heroCardModel, attendanceCardModel: $attendanceCardModel)';
}


}

/// @nodoc
abstract mixin class _$HomePageStateCopyWith<$Res> implements $HomePageStateCopyWith<$Res> {
  factory _$HomePageStateCopyWith(_HomePageState value, $Res Function(_HomePageState) _then) = __$HomePageStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime? checkInTime, DateTime? checkOutTime, WorkSchedule? workSchedule, HeroCardModel? heroCardModel, AttendanceCardModel? attendanceCardModel
});


@override $WorkScheduleCopyWith<$Res>? get workSchedule;@override $HeroCardModelCopyWith<$Res>? get heroCardModel;@override $AttendanceCardModelCopyWith<$Res>? get attendanceCardModel;

}
/// @nodoc
class __$HomePageStateCopyWithImpl<$Res>
    implements _$HomePageStateCopyWith<$Res> {
  __$HomePageStateCopyWithImpl(this._self, this._then);

  final _HomePageState _self;
  final $Res Function(_HomePageState) _then;

/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? checkInTime = freezed,Object? checkOutTime = freezed,Object? workSchedule = freezed,Object? heroCardModel = freezed,Object? attendanceCardModel = freezed,}) {
  return _then(_HomePageState(
checkInTime: freezed == checkInTime ? _self.checkInTime : checkInTime // ignore: cast_nullable_to_non_nullable
as DateTime?,checkOutTime: freezed == checkOutTime ? _self.checkOutTime : checkOutTime // ignore: cast_nullable_to_non_nullable
as DateTime?,workSchedule: freezed == workSchedule ? _self.workSchedule : workSchedule // ignore: cast_nullable_to_non_nullable
as WorkSchedule?,heroCardModel: freezed == heroCardModel ? _self.heroCardModel : heroCardModel // ignore: cast_nullable_to_non_nullable
as HeroCardModel?,attendanceCardModel: freezed == attendanceCardModel ? _self.attendanceCardModel : attendanceCardModel // ignore: cast_nullable_to_non_nullable
as AttendanceCardModel?,
  ));
}

/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkScheduleCopyWith<$Res>? get workSchedule {
    if (_self.workSchedule == null) {
    return null;
  }

  return $WorkScheduleCopyWith<$Res>(_self.workSchedule!, (value) {
    return _then(_self.copyWith(workSchedule: value));
  });
}/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HeroCardModelCopyWith<$Res>? get heroCardModel {
    if (_self.heroCardModel == null) {
    return null;
  }

  return $HeroCardModelCopyWith<$Res>(_self.heroCardModel!, (value) {
    return _then(_self.copyWith(heroCardModel: value));
  });
}/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceCardModelCopyWith<$Res>? get attendanceCardModel {
    if (_self.attendanceCardModel == null) {
    return null;
  }

  return $AttendanceCardModelCopyWith<$Res>(_self.attendanceCardModel!, (value) {
    return _then(_self.copyWith(attendanceCardModel: value));
  });
}
}

// dart format on
