// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_item_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkItemListState {

 bool get isLoading; List<WorkItem> get tasks; WorkItemSort get sort; String? get errorMessage;
/// Create a copy of WorkItemListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkItemListStateCopyWith<WorkItemListState> get copyWith => _$WorkItemListStateCopyWithImpl<WorkItemListState>(this as WorkItemListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkItemListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.tasks, tasks)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(tasks),sort,errorMessage);

@override
String toString() {
  return 'WorkItemListState(isLoading: $isLoading, tasks: $tasks, sort: $sort, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $WorkItemListStateCopyWith<$Res>  {
  factory $WorkItemListStateCopyWith(WorkItemListState value, $Res Function(WorkItemListState) _then) = _$WorkItemListStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<WorkItem> tasks, WorkItemSort sort, String? errorMessage
});




}
/// @nodoc
class _$WorkItemListStateCopyWithImpl<$Res>
    implements $WorkItemListStateCopyWith<$Res> {
  _$WorkItemListStateCopyWithImpl(this._self, this._then);

  final WorkItemListState _self;
  final $Res Function(WorkItemListState) _then;

/// Create a copy of WorkItemListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? tasks = null,Object? sort = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<WorkItem>,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as WorkItemSort,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkItemListState].
extension WorkItemListStatePatterns on WorkItemListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkItemListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkItemListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkItemListState value)  $default,){
final _that = this;
switch (_that) {
case _WorkItemListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkItemListState value)?  $default,){
final _that = this;
switch (_that) {
case _WorkItemListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<WorkItem> tasks,  WorkItemSort sort,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkItemListState() when $default != null:
return $default(_that.isLoading,_that.tasks,_that.sort,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<WorkItem> tasks,  WorkItemSort sort,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _WorkItemListState():
return $default(_that.isLoading,_that.tasks,_that.sort,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<WorkItem> tasks,  WorkItemSort sort,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _WorkItemListState() when $default != null:
return $default(_that.isLoading,_that.tasks,_that.sort,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _WorkItemListState implements WorkItemListState {
  const _WorkItemListState({this.isLoading = true, final  List<WorkItem> tasks = const <WorkItem>[], this.sort = WorkItemSort.createdDesc, this.errorMessage}): _tasks = tasks;
  

@override@JsonKey() final  bool isLoading;
 final  List<WorkItem> _tasks;
@override@JsonKey() List<WorkItem> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}

@override@JsonKey() final  WorkItemSort sort;
@override final  String? errorMessage;

/// Create a copy of WorkItemListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkItemListStateCopyWith<_WorkItemListState> get copyWith => __$WorkItemListStateCopyWithImpl<_WorkItemListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkItemListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._tasks, _tasks)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_tasks),sort,errorMessage);

@override
String toString() {
  return 'WorkItemListState(isLoading: $isLoading, tasks: $tasks, sort: $sort, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$WorkItemListStateCopyWith<$Res> implements $WorkItemListStateCopyWith<$Res> {
  factory _$WorkItemListStateCopyWith(_WorkItemListState value, $Res Function(_WorkItemListState) _then) = __$WorkItemListStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<WorkItem> tasks, WorkItemSort sort, String? errorMessage
});




}
/// @nodoc
class __$WorkItemListStateCopyWithImpl<$Res>
    implements _$WorkItemListStateCopyWith<$Res> {
  __$WorkItemListStateCopyWithImpl(this._self, this._then);

  final _WorkItemListState _self;
  final $Res Function(_WorkItemListState) _then;

/// Create a copy of WorkItemListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? tasks = null,Object? sort = null,Object? errorMessage = freezed,}) {
  return _then(_WorkItemListState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<WorkItem>,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as WorkItemSort,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
