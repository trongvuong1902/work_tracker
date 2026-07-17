// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bug_sync_products_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BugSyncProductsState {

 bool get isLoading; List<ZentaoProduct> get products; Set<int> get selectedIds; String? get errorMessage;
/// Create a copy of BugSyncProductsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BugSyncProductsStateCopyWith<BugSyncProductsState> get copyWith => _$BugSyncProductsStateCopyWithImpl<BugSyncProductsState>(this as BugSyncProductsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BugSyncProductsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.products, products)&&const DeepCollectionEquality().equals(other.selectedIds, selectedIds)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(products),const DeepCollectionEquality().hash(selectedIds),errorMessage);

@override
String toString() {
  return 'BugSyncProductsState(isLoading: $isLoading, products: $products, selectedIds: $selectedIds, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $BugSyncProductsStateCopyWith<$Res>  {
  factory $BugSyncProductsStateCopyWith(BugSyncProductsState value, $Res Function(BugSyncProductsState) _then) = _$BugSyncProductsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<ZentaoProduct> products, Set<int> selectedIds, String? errorMessage
});




}
/// @nodoc
class _$BugSyncProductsStateCopyWithImpl<$Res>
    implements $BugSyncProductsStateCopyWith<$Res> {
  _$BugSyncProductsStateCopyWithImpl(this._self, this._then);

  final BugSyncProductsState _self;
  final $Res Function(BugSyncProductsState) _then;

/// Create a copy of BugSyncProductsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? products = null,Object? selectedIds = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ZentaoProduct>,selectedIds: null == selectedIds ? _self.selectedIds : selectedIds // ignore: cast_nullable_to_non_nullable
as Set<int>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BugSyncProductsState].
extension BugSyncProductsStatePatterns on BugSyncProductsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BugSyncProductsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BugSyncProductsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BugSyncProductsState value)  $default,){
final _that = this;
switch (_that) {
case _BugSyncProductsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BugSyncProductsState value)?  $default,){
final _that = this;
switch (_that) {
case _BugSyncProductsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<ZentaoProduct> products,  Set<int> selectedIds,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BugSyncProductsState() when $default != null:
return $default(_that.isLoading,_that.products,_that.selectedIds,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<ZentaoProduct> products,  Set<int> selectedIds,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _BugSyncProductsState():
return $default(_that.isLoading,_that.products,_that.selectedIds,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<ZentaoProduct> products,  Set<int> selectedIds,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _BugSyncProductsState() when $default != null:
return $default(_that.isLoading,_that.products,_that.selectedIds,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _BugSyncProductsState implements BugSyncProductsState {
  const _BugSyncProductsState({this.isLoading = true, final  List<ZentaoProduct> products = const <ZentaoProduct>[], final  Set<int> selectedIds = const <int>{}, this.errorMessage}): _products = products,_selectedIds = selectedIds;
  

@override@JsonKey() final  bool isLoading;
 final  List<ZentaoProduct> _products;
@override@JsonKey() List<ZentaoProduct> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  Set<int> _selectedIds;
@override@JsonKey() Set<int> get selectedIds {
  if (_selectedIds is EqualUnmodifiableSetView) return _selectedIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedIds);
}

@override final  String? errorMessage;

/// Create a copy of BugSyncProductsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BugSyncProductsStateCopyWith<_BugSyncProductsState> get copyWith => __$BugSyncProductsStateCopyWithImpl<_BugSyncProductsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BugSyncProductsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._products, _products)&&const DeepCollectionEquality().equals(other._selectedIds, _selectedIds)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_products),const DeepCollectionEquality().hash(_selectedIds),errorMessage);

@override
String toString() {
  return 'BugSyncProductsState(isLoading: $isLoading, products: $products, selectedIds: $selectedIds, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$BugSyncProductsStateCopyWith<$Res> implements $BugSyncProductsStateCopyWith<$Res> {
  factory _$BugSyncProductsStateCopyWith(_BugSyncProductsState value, $Res Function(_BugSyncProductsState) _then) = __$BugSyncProductsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<ZentaoProduct> products, Set<int> selectedIds, String? errorMessage
});




}
/// @nodoc
class __$BugSyncProductsStateCopyWithImpl<$Res>
    implements _$BugSyncProductsStateCopyWith<$Res> {
  __$BugSyncProductsStateCopyWithImpl(this._self, this._then);

  final _BugSyncProductsState _self;
  final $Res Function(_BugSyncProductsState) _then;

/// Create a copy of BugSyncProductsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? products = null,Object? selectedIds = null,Object? errorMessage = freezed,}) {
  return _then(_BugSyncProductsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ZentaoProduct>,selectedIds: null == selectedIds ? _self._selectedIds : selectedIds // ignore: cast_nullable_to_non_nullable
as Set<int>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
