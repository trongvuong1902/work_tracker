// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_tasks_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlanTasksState implements DiagnosticableTreeMixin {

 bool get isLoading; bool get isSaving; List<Task> get candidates; Set<int> get selectedIds;
/// Create a copy of PlanTasksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanTasksStateCopyWith<PlanTasksState> get copyWith => _$PlanTasksStateCopyWithImpl<PlanTasksState>(this as PlanTasksState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PlanTasksState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('isSaving', isSaving))..add(DiagnosticsProperty('candidates', candidates))..add(DiagnosticsProperty('selectedIds', selectedIds));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanTasksState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&const DeepCollectionEquality().equals(other.candidates, candidates)&&const DeepCollectionEquality().equals(other.selectedIds, selectedIds));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSaving,const DeepCollectionEquality().hash(candidates),const DeepCollectionEquality().hash(selectedIds));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PlanTasksState(isLoading: $isLoading, isSaving: $isSaving, candidates: $candidates, selectedIds: $selectedIds)';
}


}

/// @nodoc
abstract mixin class $PlanTasksStateCopyWith<$Res>  {
  factory $PlanTasksStateCopyWith(PlanTasksState value, $Res Function(PlanTasksState) _then) = _$PlanTasksStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isSaving, List<Task> candidates, Set<int> selectedIds
});




}
/// @nodoc
class _$PlanTasksStateCopyWithImpl<$Res>
    implements $PlanTasksStateCopyWith<$Res> {
  _$PlanTasksStateCopyWithImpl(this._self, this._then);

  final PlanTasksState _self;
  final $Res Function(PlanTasksState) _then;

/// Create a copy of PlanTasksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isSaving = null,Object? candidates = null,Object? selectedIds = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,candidates: null == candidates ? _self.candidates : candidates // ignore: cast_nullable_to_non_nullable
as List<Task>,selectedIds: null == selectedIds ? _self.selectedIds : selectedIds // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanTasksState].
extension PlanTasksStatePatterns on PlanTasksState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanTasksState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanTasksState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanTasksState value)  $default,){
final _that = this;
switch (_that) {
case _PlanTasksState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanTasksState value)?  $default,){
final _that = this;
switch (_that) {
case _PlanTasksState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isSaving,  List<Task> candidates,  Set<int> selectedIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanTasksState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isSaving,  List<Task> candidates,  Set<int> selectedIds)  $default,) {final _that = this;
switch (_that) {
case _PlanTasksState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isSaving,  List<Task> candidates,  Set<int> selectedIds)?  $default,) {final _that = this;
switch (_that) {
case _PlanTasksState() when $default != null:
return $default(_that.isLoading,_that.isSaving,_that.candidates,_that.selectedIds);case _:
  return null;

}
}

}

/// @nodoc


class _PlanTasksState with DiagnosticableTreeMixin implements PlanTasksState {
  const _PlanTasksState({this.isLoading = true, this.isSaving = false, final  List<Task> candidates = const <Task>[], final  Set<int> selectedIds = const <int>{}}): _candidates = candidates,_selectedIds = selectedIds;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSaving;
 final  List<Task> _candidates;
@override@JsonKey() List<Task> get candidates {
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


/// Create a copy of PlanTasksState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanTasksStateCopyWith<_PlanTasksState> get copyWith => __$PlanTasksStateCopyWithImpl<_PlanTasksState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PlanTasksState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('isSaving', isSaving))..add(DiagnosticsProperty('candidates', candidates))..add(DiagnosticsProperty('selectedIds', selectedIds));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanTasksState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&const DeepCollectionEquality().equals(other._candidates, _candidates)&&const DeepCollectionEquality().equals(other._selectedIds, _selectedIds));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSaving,const DeepCollectionEquality().hash(_candidates),const DeepCollectionEquality().hash(_selectedIds));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PlanTasksState(isLoading: $isLoading, isSaving: $isSaving, candidates: $candidates, selectedIds: $selectedIds)';
}


}

/// @nodoc
abstract mixin class _$PlanTasksStateCopyWith<$Res> implements $PlanTasksStateCopyWith<$Res> {
  factory _$PlanTasksStateCopyWith(_PlanTasksState value, $Res Function(_PlanTasksState) _then) = __$PlanTasksStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isSaving, List<Task> candidates, Set<int> selectedIds
});




}
/// @nodoc
class __$PlanTasksStateCopyWithImpl<$Res>
    implements _$PlanTasksStateCopyWith<$Res> {
  __$PlanTasksStateCopyWithImpl(this._self, this._then);

  final _PlanTasksState _self;
  final $Res Function(_PlanTasksState) _then;

/// Create a copy of PlanTasksState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isSaving = null,Object? candidates = null,Object? selectedIds = null,}) {
  return _then(_PlanTasksState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,candidates: null == candidates ? _self._candidates : candidates // ignore: cast_nullable_to_non_nullable
as List<Task>,selectedIds: null == selectedIds ? _self._selectedIds : selectedIds // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}


}

// dart format on
