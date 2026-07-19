// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_work_items_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlanWorkItemsState implements DiagnosticableTreeMixin {

 bool get isLoading; bool get isSaving; List<WorkItem> get candidates; Set<int> get selectedIds;
/// Create a copy of PlanWorkItemsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanWorkItemsStateCopyWith<PlanWorkItemsState> get copyWith => _$PlanWorkItemsStateCopyWithImpl<PlanWorkItemsState>(this as PlanWorkItemsState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PlanWorkItemsState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('isSaving', isSaving))..add(DiagnosticsProperty('candidates', candidates))..add(DiagnosticsProperty('selectedIds', selectedIds));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanWorkItemsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&const DeepCollectionEquality().equals(other.candidates, candidates)&&const DeepCollectionEquality().equals(other.selectedIds, selectedIds));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSaving,const DeepCollectionEquality().hash(candidates),const DeepCollectionEquality().hash(selectedIds));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PlanWorkItemsState(isLoading: $isLoading, isSaving: $isSaving, candidates: $candidates, selectedIds: $selectedIds)';
}


}

/// @nodoc
abstract mixin class $PlanWorkItemsStateCopyWith<$Res>  {
  factory $PlanWorkItemsStateCopyWith(PlanWorkItemsState value, $Res Function(PlanWorkItemsState) _then) = _$PlanWorkItemsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isSaving, List<WorkItem> candidates, Set<int> selectedIds
});




}
/// @nodoc
class _$PlanWorkItemsStateCopyWithImpl<$Res>
    implements $PlanWorkItemsStateCopyWith<$Res> {
  _$PlanWorkItemsStateCopyWithImpl(this._self, this._then);

  final PlanWorkItemsState _self;
  final $Res Function(PlanWorkItemsState) _then;

/// Create a copy of PlanWorkItemsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isSaving = null,Object? candidates = null,Object? selectedIds = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,candidates: null == candidates ? _self.candidates : candidates // ignore: cast_nullable_to_non_nullable
as List<WorkItem>,selectedIds: null == selectedIds ? _self.selectedIds : selectedIds // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanWorkItemsState].
extension PlanWorkItemsStatePatterns on PlanWorkItemsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanWorkItemsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanWorkItemsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanWorkItemsState value)  $default,){
final _that = this;
switch (_that) {
case _PlanWorkItemsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanWorkItemsState value)?  $default,){
final _that = this;
switch (_that) {
case _PlanWorkItemsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isSaving,  List<WorkItem> candidates,  Set<int> selectedIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanWorkItemsState() when $default != null:
return $default(_that.isLoading,_that.isSaving,_that.candidates,_that.selectedIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isSaving,  List<WorkItem> candidates,  Set<int> selectedIds)  $default,) {final _that = this;
switch (_that) {
case _PlanWorkItemsState():
return $default(_that.isLoading,_that.isSaving,_that.candidates,_that.selectedIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isSaving,  List<WorkItem> candidates,  Set<int> selectedIds)?  $default,) {final _that = this;
switch (_that) {
case _PlanWorkItemsState() when $default != null:
return $default(_that.isLoading,_that.isSaving,_that.candidates,_that.selectedIds);case _:
  return null;

}
}

}

/// @nodoc


class _PlanWorkItemsState with DiagnosticableTreeMixin implements PlanWorkItemsState {
  const _PlanWorkItemsState({this.isLoading = true, this.isSaving = false, final  List<WorkItem> candidates = const <WorkItem>[], final  Set<int> selectedIds = const <int>{}}): _candidates = candidates,_selectedIds = selectedIds;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSaving;
 final  List<WorkItem> _candidates;
@override@JsonKey() List<WorkItem> get candidates {
  if (_candidates is EqualUnmodifiableListView) return _candidates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_candidates);
}

 final  Set<int> _selectedIds;
@override@JsonKey() Set<int> get selectedIds {
  if (_selectedIds is EqualUnmodifiableSetView) return _selectedIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedIds);
}


/// Create a copy of PlanWorkItemsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanWorkItemsStateCopyWith<_PlanWorkItemsState> get copyWith => __$PlanWorkItemsStateCopyWithImpl<_PlanWorkItemsState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PlanWorkItemsState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('isSaving', isSaving))..add(DiagnosticsProperty('candidates', candidates))..add(DiagnosticsProperty('selectedIds', selectedIds));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanWorkItemsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&const DeepCollectionEquality().equals(other._candidates, _candidates)&&const DeepCollectionEquality().equals(other._selectedIds, _selectedIds));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSaving,const DeepCollectionEquality().hash(_candidates),const DeepCollectionEquality().hash(_selectedIds));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PlanWorkItemsState(isLoading: $isLoading, isSaving: $isSaving, candidates: $candidates, selectedIds: $selectedIds)';
}


}

/// @nodoc
abstract mixin class _$PlanWorkItemsStateCopyWith<$Res> implements $PlanWorkItemsStateCopyWith<$Res> {
  factory _$PlanWorkItemsStateCopyWith(_PlanWorkItemsState value, $Res Function(_PlanWorkItemsState) _then) = __$PlanWorkItemsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isSaving, List<WorkItem> candidates, Set<int> selectedIds
});




}
/// @nodoc
class __$PlanWorkItemsStateCopyWithImpl<$Res>
    implements _$PlanWorkItemsStateCopyWith<$Res> {
  __$PlanWorkItemsStateCopyWithImpl(this._self, this._then);

  final _PlanWorkItemsState _self;
  final $Res Function(_PlanWorkItemsState) _then;

/// Create a copy of PlanWorkItemsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isSaving = null,Object? candidates = null,Object? selectedIds = null,}) {
  return _then(_PlanWorkItemsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,candidates: null == candidates ? _self._candidates : candidates // ignore: cast_nullable_to_non_nullable
as List<WorkItem>,selectedIds: null == selectedIds ? _self._selectedIds : selectedIds // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}


}

// dart format on
