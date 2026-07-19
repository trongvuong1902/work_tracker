// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'today_work_items_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodayWorkItemsState implements DiagnosticableTreeMixin {

 bool get isLoading; List<TodayWorkItem> get items;
/// Create a copy of TodayWorkItemsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayWorkItemsStateCopyWith<TodayWorkItemsState> get copyWith => _$TodayWorkItemsStateCopyWithImpl<TodayWorkItemsState>(this as TodayWorkItemsState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TodayWorkItemsState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('items', items));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayWorkItemsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(items));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TodayWorkItemsState(isLoading: $isLoading, items: $items)';
}


}

/// @nodoc
abstract mixin class $TodayWorkItemsStateCopyWith<$Res>  {
  factory $TodayWorkItemsStateCopyWith(TodayWorkItemsState value, $Res Function(TodayWorkItemsState) _then) = _$TodayWorkItemsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<TodayWorkItem> items
});




}
/// @nodoc
class _$TodayWorkItemsStateCopyWithImpl<$Res>
    implements $TodayWorkItemsStateCopyWith<$Res> {
  _$TodayWorkItemsStateCopyWithImpl(this._self, this._then);

  final TodayWorkItemsState _self;
  final $Res Function(TodayWorkItemsState) _then;

/// Create a copy of TodayWorkItemsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? items = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<TodayWorkItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [TodayWorkItemsState].
extension TodayWorkItemsStatePatterns on TodayWorkItemsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodayWorkItemsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodayWorkItemsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodayWorkItemsState value)  $default,){
final _that = this;
switch (_that) {
case _TodayWorkItemsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodayWorkItemsState value)?  $default,){
final _that = this;
switch (_that) {
case _TodayWorkItemsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<TodayWorkItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodayWorkItemsState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<TodayWorkItem> items)  $default,) {final _that = this;
switch (_that) {
case _TodayWorkItemsState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<TodayWorkItem> items)?  $default,) {final _that = this;
switch (_that) {
case _TodayWorkItemsState() when $default != null:
return $default(_that.isLoading,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _TodayWorkItemsState with DiagnosticableTreeMixin implements TodayWorkItemsState {
  const _TodayWorkItemsState({this.isLoading = true, final  List<TodayWorkItem> items = const <TodayWorkItem>[]}): _items = items;
  

@override@JsonKey() final  bool isLoading;
 final  List<TodayWorkItem> _items;
@override@JsonKey() List<TodayWorkItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of TodayWorkItemsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayWorkItemsStateCopyWith<_TodayWorkItemsState> get copyWith => __$TodayWorkItemsStateCopyWithImpl<_TodayWorkItemsState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TodayWorkItemsState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('items', items));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayWorkItemsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_items));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TodayWorkItemsState(isLoading: $isLoading, items: $items)';
}


}

/// @nodoc
abstract mixin class _$TodayWorkItemsStateCopyWith<$Res> implements $TodayWorkItemsStateCopyWith<$Res> {
  factory _$TodayWorkItemsStateCopyWith(_TodayWorkItemsState value, $Res Function(_TodayWorkItemsState) _then) = __$TodayWorkItemsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<TodayWorkItem> items
});




}
/// @nodoc
class __$TodayWorkItemsStateCopyWithImpl<$Res>
    implements _$TodayWorkItemsStateCopyWith<$Res> {
  __$TodayWorkItemsStateCopyWithImpl(this._self, this._then);

  final _TodayWorkItemsState _self;
  final $Res Function(_TodayWorkItemsState) _then;

/// Create a copy of TodayWorkItemsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? items = null,}) {
  return _then(_TodayWorkItemsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TodayWorkItem>,
  ));
}


}

// dart format on
