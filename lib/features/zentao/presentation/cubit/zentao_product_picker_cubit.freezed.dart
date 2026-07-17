// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zentao_product_picker_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ZentaoProductPickerState {

 bool get isLoadingProducts; List<ZentaoProduct> get products; String? get productsError; ZentaoProduct? get selectedProduct; bool get isLoadingItems; List<ZentaoTask> get tasks; List<ZentaoBug> get bugs; String? get itemsError; int? get importingId;
/// Create a copy of ZentaoProductPickerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZentaoProductPickerStateCopyWith<ZentaoProductPickerState> get copyWith => _$ZentaoProductPickerStateCopyWithImpl<ZentaoProductPickerState>(this as ZentaoProductPickerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZentaoProductPickerState&&(identical(other.isLoadingProducts, isLoadingProducts) || other.isLoadingProducts == isLoadingProducts)&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.productsError, productsError) || other.productsError == productsError)&&(identical(other.selectedProduct, selectedProduct) || other.selectedProduct == selectedProduct)&&(identical(other.isLoadingItems, isLoadingItems) || other.isLoadingItems == isLoadingItems)&&const DeepCollectionEquality().equals(other.tasks, tasks)&&const DeepCollectionEquality().equals(other.bugs, bugs)&&(identical(other.itemsError, itemsError) || other.itemsError == itemsError)&&(identical(other.importingId, importingId) || other.importingId == importingId));
}


@override
int get hashCode => Object.hash(runtimeType,isLoadingProducts,const DeepCollectionEquality().hash(products),productsError,selectedProduct,isLoadingItems,const DeepCollectionEquality().hash(tasks),const DeepCollectionEquality().hash(bugs),itemsError,importingId);

@override
String toString() {
  return 'ZentaoProductPickerState(isLoadingProducts: $isLoadingProducts, products: $products, productsError: $productsError, selectedProduct: $selectedProduct, isLoadingItems: $isLoadingItems, tasks: $tasks, bugs: $bugs, itemsError: $itemsError, importingId: $importingId)';
}


}

/// @nodoc
abstract mixin class $ZentaoProductPickerStateCopyWith<$Res>  {
  factory $ZentaoProductPickerStateCopyWith(ZentaoProductPickerState value, $Res Function(ZentaoProductPickerState) _then) = _$ZentaoProductPickerStateCopyWithImpl;
@useResult
$Res call({
 bool isLoadingProducts, List<ZentaoProduct> products, String? productsError, ZentaoProduct? selectedProduct, bool isLoadingItems, List<ZentaoTask> tasks, List<ZentaoBug> bugs, String? itemsError, int? importingId
});


$ZentaoProductCopyWith<$Res>? get selectedProduct;

}
/// @nodoc
class _$ZentaoProductPickerStateCopyWithImpl<$Res>
    implements $ZentaoProductPickerStateCopyWith<$Res> {
  _$ZentaoProductPickerStateCopyWithImpl(this._self, this._then);

  final ZentaoProductPickerState _self;
  final $Res Function(ZentaoProductPickerState) _then;

/// Create a copy of ZentaoProductPickerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoadingProducts = null,Object? products = null,Object? productsError = freezed,Object? selectedProduct = freezed,Object? isLoadingItems = null,Object? tasks = null,Object? bugs = null,Object? itemsError = freezed,Object? importingId = freezed,}) {
  return _then(_self.copyWith(
isLoadingProducts: null == isLoadingProducts ? _self.isLoadingProducts : isLoadingProducts // ignore: cast_nullable_to_non_nullable
as bool,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ZentaoProduct>,productsError: freezed == productsError ? _self.productsError : productsError // ignore: cast_nullable_to_non_nullable
as String?,selectedProduct: freezed == selectedProduct ? _self.selectedProduct : selectedProduct // ignore: cast_nullable_to_non_nullable
as ZentaoProduct?,isLoadingItems: null == isLoadingItems ? _self.isLoadingItems : isLoadingItems // ignore: cast_nullable_to_non_nullable
as bool,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<ZentaoTask>,bugs: null == bugs ? _self.bugs : bugs // ignore: cast_nullable_to_non_nullable
as List<ZentaoBug>,itemsError: freezed == itemsError ? _self.itemsError : itemsError // ignore: cast_nullable_to_non_nullable
as String?,importingId: freezed == importingId ? _self.importingId : importingId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of ZentaoProductPickerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZentaoProductCopyWith<$Res>? get selectedProduct {
    if (_self.selectedProduct == null) {
    return null;
  }

  return $ZentaoProductCopyWith<$Res>(_self.selectedProduct!, (value) {
    return _then(_self.copyWith(selectedProduct: value));
  });
}
}


/// Adds pattern-matching-related methods to [ZentaoProductPickerState].
extension ZentaoProductPickerStatePatterns on ZentaoProductPickerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ZentaoProductPickerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ZentaoProductPickerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ZentaoProductPickerState value)  $default,){
final _that = this;
switch (_that) {
case _ZentaoProductPickerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ZentaoProductPickerState value)?  $default,){
final _that = this;
switch (_that) {
case _ZentaoProductPickerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoadingProducts,  List<ZentaoProduct> products,  String? productsError,  ZentaoProduct? selectedProduct,  bool isLoadingItems,  List<ZentaoTask> tasks,  List<ZentaoBug> bugs,  String? itemsError,  int? importingId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ZentaoProductPickerState() when $default != null:
return $default(_that.isLoadingProducts,_that.products,_that.productsError,_that.selectedProduct,_that.isLoadingItems,_that.tasks,_that.bugs,_that.itemsError,_that.importingId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoadingProducts,  List<ZentaoProduct> products,  String? productsError,  ZentaoProduct? selectedProduct,  bool isLoadingItems,  List<ZentaoTask> tasks,  List<ZentaoBug> bugs,  String? itemsError,  int? importingId)  $default,) {final _that = this;
switch (_that) {
case _ZentaoProductPickerState():
return $default(_that.isLoadingProducts,_that.products,_that.productsError,_that.selectedProduct,_that.isLoadingItems,_that.tasks,_that.bugs,_that.itemsError,_that.importingId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoadingProducts,  List<ZentaoProduct> products,  String? productsError,  ZentaoProduct? selectedProduct,  bool isLoadingItems,  List<ZentaoTask> tasks,  List<ZentaoBug> bugs,  String? itemsError,  int? importingId)?  $default,) {final _that = this;
switch (_that) {
case _ZentaoProductPickerState() when $default != null:
return $default(_that.isLoadingProducts,_that.products,_that.productsError,_that.selectedProduct,_that.isLoadingItems,_that.tasks,_that.bugs,_that.itemsError,_that.importingId);case _:
  return null;

}
}

}

/// @nodoc


class _ZentaoProductPickerState implements ZentaoProductPickerState {
  const _ZentaoProductPickerState({this.isLoadingProducts = true, final  List<ZentaoProduct> products = const <ZentaoProduct>[], this.productsError, this.selectedProduct, this.isLoadingItems = false, final  List<ZentaoTask> tasks = const <ZentaoTask>[], final  List<ZentaoBug> bugs = const <ZentaoBug>[], this.itemsError, this.importingId}): _products = products,_tasks = tasks,_bugs = bugs;
  

@override@JsonKey() final  bool isLoadingProducts;
 final  List<ZentaoProduct> _products;
@override@JsonKey() List<ZentaoProduct> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

@override final  String? productsError;
@override final  ZentaoProduct? selectedProduct;
@override@JsonKey() final  bool isLoadingItems;
 final  List<ZentaoTask> _tasks;
@override@JsonKey() List<ZentaoTask> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}

 final  List<ZentaoBug> _bugs;
@override@JsonKey() List<ZentaoBug> get bugs {
  if (_bugs is EqualUnmodifiableListView) return _bugs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bugs);
}

@override final  String? itemsError;
@override final  int? importingId;

/// Create a copy of ZentaoProductPickerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZentaoProductPickerStateCopyWith<_ZentaoProductPickerState> get copyWith => __$ZentaoProductPickerStateCopyWithImpl<_ZentaoProductPickerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZentaoProductPickerState&&(identical(other.isLoadingProducts, isLoadingProducts) || other.isLoadingProducts == isLoadingProducts)&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.productsError, productsError) || other.productsError == productsError)&&(identical(other.selectedProduct, selectedProduct) || other.selectedProduct == selectedProduct)&&(identical(other.isLoadingItems, isLoadingItems) || other.isLoadingItems == isLoadingItems)&&const DeepCollectionEquality().equals(other._tasks, _tasks)&&const DeepCollectionEquality().equals(other._bugs, _bugs)&&(identical(other.itemsError, itemsError) || other.itemsError == itemsError)&&(identical(other.importingId, importingId) || other.importingId == importingId));
}


@override
int get hashCode => Object.hash(runtimeType,isLoadingProducts,const DeepCollectionEquality().hash(_products),productsError,selectedProduct,isLoadingItems,const DeepCollectionEquality().hash(_tasks),const DeepCollectionEquality().hash(_bugs),itemsError,importingId);

@override
String toString() {
  return 'ZentaoProductPickerState(isLoadingProducts: $isLoadingProducts, products: $products, productsError: $productsError, selectedProduct: $selectedProduct, isLoadingItems: $isLoadingItems, tasks: $tasks, bugs: $bugs, itemsError: $itemsError, importingId: $importingId)';
}


}

/// @nodoc
abstract mixin class _$ZentaoProductPickerStateCopyWith<$Res> implements $ZentaoProductPickerStateCopyWith<$Res> {
  factory _$ZentaoProductPickerStateCopyWith(_ZentaoProductPickerState value, $Res Function(_ZentaoProductPickerState) _then) = __$ZentaoProductPickerStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoadingProducts, List<ZentaoProduct> products, String? productsError, ZentaoProduct? selectedProduct, bool isLoadingItems, List<ZentaoTask> tasks, List<ZentaoBug> bugs, String? itemsError, int? importingId
});


@override $ZentaoProductCopyWith<$Res>? get selectedProduct;

}
/// @nodoc
class __$ZentaoProductPickerStateCopyWithImpl<$Res>
    implements _$ZentaoProductPickerStateCopyWith<$Res> {
  __$ZentaoProductPickerStateCopyWithImpl(this._self, this._then);

  final _ZentaoProductPickerState _self;
  final $Res Function(_ZentaoProductPickerState) _then;

/// Create a copy of ZentaoProductPickerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoadingProducts = null,Object? products = null,Object? productsError = freezed,Object? selectedProduct = freezed,Object? isLoadingItems = null,Object? tasks = null,Object? bugs = null,Object? itemsError = freezed,Object? importingId = freezed,}) {
  return _then(_ZentaoProductPickerState(
isLoadingProducts: null == isLoadingProducts ? _self.isLoadingProducts : isLoadingProducts // ignore: cast_nullable_to_non_nullable
as bool,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ZentaoProduct>,productsError: freezed == productsError ? _self.productsError : productsError // ignore: cast_nullable_to_non_nullable
as String?,selectedProduct: freezed == selectedProduct ? _self.selectedProduct : selectedProduct // ignore: cast_nullable_to_non_nullable
as ZentaoProduct?,isLoadingItems: null == isLoadingItems ? _self.isLoadingItems : isLoadingItems // ignore: cast_nullable_to_non_nullable
as bool,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<ZentaoTask>,bugs: null == bugs ? _self._bugs : bugs // ignore: cast_nullable_to_non_nullable
as List<ZentaoBug>,itemsError: freezed == itemsError ? _self.itemsError : itemsError // ignore: cast_nullable_to_non_nullable
as String?,importingId: freezed == importingId ? _self.importingId : importingId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of ZentaoProductPickerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZentaoProductCopyWith<$Res>? get selectedProduct {
    if (_self.selectedProduct == null) {
    return null;
  }

  return $ZentaoProductCopyWith<$Res>(_self.selectedProduct!, (value) {
    return _then(_self.copyWith(selectedProduct: value));
  });
}
}

// dart format on
