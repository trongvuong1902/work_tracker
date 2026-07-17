// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'today_activity_timeline_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodayActivityTimelineState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TodayActivityTimelineState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayActivityTimelineState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TodayActivityTimelineState()';
}


}

/// @nodoc
class $TodayActivityTimelineStateCopyWith<$Res>  {
$TodayActivityTimelineStateCopyWith(TodayActivityTimelineState _, $Res Function(TodayActivityTimelineState) __);
}


/// Adds pattern-matching-related methods to [TodayActivityTimelineState].
extension TodayActivityTimelineStatePatterns on TodayActivityTimelineState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _NotEnabled value)?  notEnabled,TResult Function( _NoEventsToday value)?  noEventsToday,TResult Function( _Populated value)?  populated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotEnabled() when notEnabled != null:
return notEnabled(_that);case _NoEventsToday() when noEventsToday != null:
return noEventsToday(_that);case _Populated() when populated != null:
return populated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _NotEnabled value)  notEnabled,required TResult Function( _NoEventsToday value)  noEventsToday,required TResult Function( _Populated value)  populated,}){
final _that = this;
switch (_that) {
case _NotEnabled():
return notEnabled(_that);case _NoEventsToday():
return noEventsToday(_that);case _Populated():
return populated(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _NotEnabled value)?  notEnabled,TResult? Function( _NoEventsToday value)?  noEventsToday,TResult? Function( _Populated value)?  populated,}){
final _that = this;
switch (_that) {
case _NotEnabled() when notEnabled != null:
return notEnabled(_that);case _NoEventsToday() when noEventsToday != null:
return noEventsToday(_that);case _Populated() when populated != null:
return populated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  notEnabled,TResult Function()?  noEventsToday,TResult Function( List<LocationLog> events,  Map<LocationLog, LocationLogBadgeTier> badges)?  populated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotEnabled() when notEnabled != null:
return notEnabled();case _NoEventsToday() when noEventsToday != null:
return noEventsToday();case _Populated() when populated != null:
return populated(_that.events,_that.badges);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  notEnabled,required TResult Function()  noEventsToday,required TResult Function( List<LocationLog> events,  Map<LocationLog, LocationLogBadgeTier> badges)  populated,}) {final _that = this;
switch (_that) {
case _NotEnabled():
return notEnabled();case _NoEventsToday():
return noEventsToday();case _Populated():
return populated(_that.events,_that.badges);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  notEnabled,TResult? Function()?  noEventsToday,TResult? Function( List<LocationLog> events,  Map<LocationLog, LocationLogBadgeTier> badges)?  populated,}) {final _that = this;
switch (_that) {
case _NotEnabled() when notEnabled != null:
return notEnabled();case _NoEventsToday() when noEventsToday != null:
return noEventsToday();case _Populated() when populated != null:
return populated(_that.events,_that.badges);case _:
  return null;

}
}

}

/// @nodoc


class _NotEnabled with DiagnosticableTreeMixin implements TodayActivityTimelineState {
  const _NotEnabled();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TodayActivityTimelineState.notEnabled'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotEnabled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TodayActivityTimelineState.notEnabled()';
}


}




/// @nodoc


class _NoEventsToday with DiagnosticableTreeMixin implements TodayActivityTimelineState {
  const _NoEventsToday();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TodayActivityTimelineState.noEventsToday'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoEventsToday);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TodayActivityTimelineState.noEventsToday()';
}


}




/// @nodoc


class _Populated with DiagnosticableTreeMixin implements TodayActivityTimelineState {
  const _Populated({required final  List<LocationLog> events, required final  Map<LocationLog, LocationLogBadgeTier> badges}): _events = events,_badges = badges;
  

 final  List<LocationLog> _events;
 List<LocationLog> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

 final  Map<LocationLog, LocationLogBadgeTier> _badges;
 Map<LocationLog, LocationLogBadgeTier> get badges {
  if (_badges is EqualUnmodifiableMapView) return _badges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_badges);
}


/// Create a copy of TodayActivityTimelineState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PopulatedCopyWith<_Populated> get copyWith => __$PopulatedCopyWithImpl<_Populated>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TodayActivityTimelineState.populated'))
    ..add(DiagnosticsProperty('events', events))..add(DiagnosticsProperty('badges', badges));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Populated&&const DeepCollectionEquality().equals(other._events, _events)&&const DeepCollectionEquality().equals(other._badges, _badges));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_events),const DeepCollectionEquality().hash(_badges));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TodayActivityTimelineState.populated(events: $events, badges: $badges)';
}


}

/// @nodoc
abstract mixin class _$PopulatedCopyWith<$Res> implements $TodayActivityTimelineStateCopyWith<$Res> {
  factory _$PopulatedCopyWith(_Populated value, $Res Function(_Populated) _then) = __$PopulatedCopyWithImpl;
@useResult
$Res call({
 List<LocationLog> events, Map<LocationLog, LocationLogBadgeTier> badges
});




}
/// @nodoc
class __$PopulatedCopyWithImpl<$Res>
    implements _$PopulatedCopyWith<$Res> {
  __$PopulatedCopyWithImpl(this._self, this._then);

  final _Populated _self;
  final $Res Function(_Populated) _then;

/// Create a copy of TodayActivityTimelineState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? events = null,Object? badges = null,}) {
  return _then(_Populated(
events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<LocationLog>,badges: null == badges ? _self._badges : badges // ignore: cast_nullable_to_non_nullable
as Map<LocationLog, LocationLogBadgeTier>,
  ));
}


}

// dart format on
