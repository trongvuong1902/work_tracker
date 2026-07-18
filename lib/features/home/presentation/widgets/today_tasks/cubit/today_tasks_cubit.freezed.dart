// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'today_tasks_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodayTasksState implements DiagnosticableTreeMixin {

 bool get isLoading; List<TodayTaskItem> get items;
/// Create a copy of TodayTasksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayTasksStateCopyWith<TodayTasksState> get copyWith => _$TodayTasksStateCopyWithImpl<TodayTasksState>(this as TodayTasksState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TodayTasksState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('items', items));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayTasksState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(items));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TodayTasksState(isLoading: $isLoading, items: $items)';
}


}

/// @nodoc
abstract mixin class $TodayTasksStateCopyWith<$Res>  {
  factory $TodayTasksStateCopyWith(TodayTasksState value, $Res Function(TodayTasksState) _then) = _$TodayTasksStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<TodayTaskItem> items
});




}
/// @nodoc
class _$TodayTasksStateCopyWithImpl<$Res>
    implements $TodayTasksStateCopyWith<$Res> {
  _$TodayTasksStateCopyWithImpl(this._self, this._then);

  final TodayTasksState _self;
  final $Res Function(TodayTasksState) _then;

/// Create a copy of TodayTasksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? items = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<TodayTaskItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [TodayTasksState].
extension TodayTasksStatePatterns on TodayTasksState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodayTasksState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodayTasksState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodayTasksState value)  $default,){
final _that = this;
switch (_that) {
case _TodayTasksState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodayTasksState value)?  $default,){
final _that = this;
switch (_that) {
case _TodayTasksState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<TodayTaskItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodayTasksState() when $default != null:
return $default(_that.isLoading,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<TodayTaskItem> items)  $default,) {final _that = this;
switch (_that) {
case _TodayTasksState():
return $default(_that.isLoading,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<TodayTaskItem> items)?  $default,) {final _that = this;
switch (_that) {
case _TodayTasksState() when $default != null:
return $default(_that.isLoading,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _TodayTasksState with DiagnosticableTreeMixin implements TodayTasksState {
  const _TodayTasksState({this.isLoading = true, final  List<TodayTaskItem> items = const <TodayTaskItem>[]}): _items = items;
  

@override@JsonKey() final  bool isLoading;
 final  List<TodayTaskItem> _items;
@override@JsonKey() List<TodayTaskItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of TodayTasksState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayTasksStateCopyWith<_TodayTasksState> get copyWith => __$TodayTasksStateCopyWithImpl<_TodayTasksState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TodayTasksState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('items', items));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayTasksState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_items));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TodayTasksState(isLoading: $isLoading, items: $items)';
}


}

/// @nodoc
abstract mixin class _$TodayTasksStateCopyWith<$Res> implements $TodayTasksStateCopyWith<$Res> {
  factory _$TodayTasksStateCopyWith(_TodayTasksState value, $Res Function(_TodayTasksState) _then) = __$TodayTasksStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<TodayTaskItem> items
});




}
/// @nodoc
class __$TodayTasksStateCopyWithImpl<$Res>
    implements _$TodayTasksStateCopyWith<$Res> {
  __$TodayTasksStateCopyWithImpl(this._self, this._then);

  final _TodayTasksState _self;
  final $Res Function(_TodayTasksState) _then;

/// Create a copy of TodayTasksState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? items = null,}) {
  return _then(_TodayTasksState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TodayTaskItem>,
  ));
}


}

// dart format on
