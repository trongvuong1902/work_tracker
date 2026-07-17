// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_activity_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationActivityState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LocationActivityState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationActivityState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LocationActivityState()';
}


}

/// @nodoc
class $LocationActivityStateCopyWith<$Res>  {
$LocationActivityStateCopyWith(LocationActivityState _, $Res Function(LocationActivityState) __);
}


/// Adds pattern-matching-related methods to [LocationActivityState].
extension LocationActivityStatePatterns on LocationActivityState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Loading value)?  loading,TResult Function( _NotEnabled value)?  notEnabled,TResult Function( _EnabledNoEvents value)?  enabledNoEvents,TResult Function( _Populated value)?  populated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading(_that);case _NotEnabled() when notEnabled != null:
return notEnabled(_that);case _EnabledNoEvents() when enabledNoEvents != null:
return enabledNoEvents(_that);case _Populated() when populated != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Loading value)  loading,required TResult Function( _NotEnabled value)  notEnabled,required TResult Function( _EnabledNoEvents value)  enabledNoEvents,required TResult Function( _Populated value)  populated,}){
final _that = this;
switch (_that) {
case _Loading():
return loading(_that);case _NotEnabled():
return notEnabled(_that);case _EnabledNoEvents():
return enabledNoEvents(_that);case _Populated():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Loading value)?  loading,TResult? Function( _NotEnabled value)?  notEnabled,TResult? Function( _EnabledNoEvents value)?  enabledNoEvents,TResult? Function( _Populated value)?  populated,}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading(_that);case _NotEnabled() when notEnabled != null:
return notEnabled(_that);case _EnabledNoEvents() when enabledNoEvents != null:
return enabledNoEvents(_that);case _Populated() when populated != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function()?  notEnabled,TResult Function()?  enabledNoEvents,TResult Function( List<LocationActivityDaySection> sections,  bool canLoadMore,  bool isLoadingMore)?  populated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _NotEnabled() when notEnabled != null:
return notEnabled();case _EnabledNoEvents() when enabledNoEvents != null:
return enabledNoEvents();case _Populated() when populated != null:
return populated(_that.sections,_that.canLoadMore,_that.isLoadingMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function()  notEnabled,required TResult Function()  enabledNoEvents,required TResult Function( List<LocationActivityDaySection> sections,  bool canLoadMore,  bool isLoadingMore)  populated,}) {final _that = this;
switch (_that) {
case _Loading():
return loading();case _NotEnabled():
return notEnabled();case _EnabledNoEvents():
return enabledNoEvents();case _Populated():
return populated(_that.sections,_that.canLoadMore,_that.isLoadingMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function()?  notEnabled,TResult? Function()?  enabledNoEvents,TResult? Function( List<LocationActivityDaySection> sections,  bool canLoadMore,  bool isLoadingMore)?  populated,}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _NotEnabled() when notEnabled != null:
return notEnabled();case _EnabledNoEvents() when enabledNoEvents != null:
return enabledNoEvents();case _Populated() when populated != null:
return populated(_that.sections,_that.canLoadMore,_that.isLoadingMore);case _:
  return null;

}
}

}

/// @nodoc


class _Loading with DiagnosticableTreeMixin implements LocationActivityState {
  const _Loading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LocationActivityState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LocationActivityState.loading()';
}


}




/// @nodoc


class _NotEnabled with DiagnosticableTreeMixin implements LocationActivityState {
  const _NotEnabled();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LocationActivityState.notEnabled'))
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
  return 'LocationActivityState.notEnabled()';
}


}




/// @nodoc


class _EnabledNoEvents with DiagnosticableTreeMixin implements LocationActivityState {
  const _EnabledNoEvents();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LocationActivityState.enabledNoEvents'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EnabledNoEvents);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LocationActivityState.enabledNoEvents()';
}


}




/// @nodoc


class _Populated with DiagnosticableTreeMixin implements LocationActivityState {
  const _Populated({required final  List<LocationActivityDaySection> sections, required this.canLoadMore, required this.isLoadingMore}): _sections = sections;
  

 final  List<LocationActivityDaySection> _sections;
 List<LocationActivityDaySection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

 final  bool canLoadMore;
 final  bool isLoadingMore;

/// Create a copy of LocationActivityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PopulatedCopyWith<_Populated> get copyWith => __$PopulatedCopyWithImpl<_Populated>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LocationActivityState.populated'))
    ..add(DiagnosticsProperty('sections', sections))..add(DiagnosticsProperty('canLoadMore', canLoadMore))..add(DiagnosticsProperty('isLoadingMore', isLoadingMore));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Populated&&const DeepCollectionEquality().equals(other._sections, _sections)&&(identical(other.canLoadMore, canLoadMore) || other.canLoadMore == canLoadMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sections),canLoadMore,isLoadingMore);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LocationActivityState.populated(sections: $sections, canLoadMore: $canLoadMore, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class _$PopulatedCopyWith<$Res> implements $LocationActivityStateCopyWith<$Res> {
  factory _$PopulatedCopyWith(_Populated value, $Res Function(_Populated) _then) = __$PopulatedCopyWithImpl;
@useResult
$Res call({
 List<LocationActivityDaySection> sections, bool canLoadMore, bool isLoadingMore
});




}
/// @nodoc
class __$PopulatedCopyWithImpl<$Res>
    implements _$PopulatedCopyWith<$Res> {
  __$PopulatedCopyWithImpl(this._self, this._then);

  final _Populated _self;
  final $Res Function(_Populated) _then;

/// Create a copy of LocationActivityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sections = null,Object? canLoadMore = null,Object? isLoadingMore = null,}) {
  return _then(_Populated(
sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<LocationActivityDaySection>,canLoadMore: null == canLoadMore ? _self.canLoadMore : canLoadMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$LocationActivityDaySection implements DiagnosticableTreeMixin {

 DateTime get date; List<LocationLog> get events; Map<LocationLog, LocationLogBadgeTier> get badges;
/// Create a copy of LocationActivityDaySection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationActivityDaySectionCopyWith<LocationActivityDaySection> get copyWith => _$LocationActivityDaySectionCopyWithImpl<LocationActivityDaySection>(this as LocationActivityDaySection, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LocationActivityDaySection'))
    ..add(DiagnosticsProperty('date', date))..add(DiagnosticsProperty('events', events))..add(DiagnosticsProperty('badges', badges));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationActivityDaySection&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.events, events)&&const DeepCollectionEquality().equals(other.badges, badges));
}


@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(events),const DeepCollectionEquality().hash(badges));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LocationActivityDaySection(date: $date, events: $events, badges: $badges)';
}


}

/// @nodoc
abstract mixin class $LocationActivityDaySectionCopyWith<$Res>  {
  factory $LocationActivityDaySectionCopyWith(LocationActivityDaySection value, $Res Function(LocationActivityDaySection) _then) = _$LocationActivityDaySectionCopyWithImpl;
@useResult
$Res call({
 DateTime date, List<LocationLog> events, Map<LocationLog, LocationLogBadgeTier> badges
});




}
/// @nodoc
class _$LocationActivityDaySectionCopyWithImpl<$Res>
    implements $LocationActivityDaySectionCopyWith<$Res> {
  _$LocationActivityDaySectionCopyWithImpl(this._self, this._then);

  final LocationActivityDaySection _self;
  final $Res Function(LocationActivityDaySection) _then;

/// Create a copy of LocationActivityDaySection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? events = null,Object? badges = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<LocationLog>,badges: null == badges ? _self.badges : badges // ignore: cast_nullable_to_non_nullable
as Map<LocationLog, LocationLogBadgeTier>,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationActivityDaySection].
extension LocationActivityDaySectionPatterns on LocationActivityDaySection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationActivityDaySection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationActivityDaySection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationActivityDaySection value)  $default,){
final _that = this;
switch (_that) {
case _LocationActivityDaySection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationActivityDaySection value)?  $default,){
final _that = this;
switch (_that) {
case _LocationActivityDaySection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  List<LocationLog> events,  Map<LocationLog, LocationLogBadgeTier> badges)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationActivityDaySection() when $default != null:
return $default(_that.date,_that.events,_that.badges);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  List<LocationLog> events,  Map<LocationLog, LocationLogBadgeTier> badges)  $default,) {final _that = this;
switch (_that) {
case _LocationActivityDaySection():
return $default(_that.date,_that.events,_that.badges);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  List<LocationLog> events,  Map<LocationLog, LocationLogBadgeTier> badges)?  $default,) {final _that = this;
switch (_that) {
case _LocationActivityDaySection() when $default != null:
return $default(_that.date,_that.events,_that.badges);case _:
  return null;

}
}

}

/// @nodoc


class _LocationActivityDaySection with DiagnosticableTreeMixin implements LocationActivityDaySection {
  const _LocationActivityDaySection({required this.date, required final  List<LocationLog> events, required final  Map<LocationLog, LocationLogBadgeTier> badges}): _events = events,_badges = badges;
  

@override final  DateTime date;
 final  List<LocationLog> _events;
@override List<LocationLog> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

 final  Map<LocationLog, LocationLogBadgeTier> _badges;
@override Map<LocationLog, LocationLogBadgeTier> get badges {
  if (_badges is EqualUnmodifiableMapView) return _badges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_badges);
}


/// Create a copy of LocationActivityDaySection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationActivityDaySectionCopyWith<_LocationActivityDaySection> get copyWith => __$LocationActivityDaySectionCopyWithImpl<_LocationActivityDaySection>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LocationActivityDaySection'))
    ..add(DiagnosticsProperty('date', date))..add(DiagnosticsProperty('events', events))..add(DiagnosticsProperty('badges', badges));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationActivityDaySection&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._events, _events)&&const DeepCollectionEquality().equals(other._badges, _badges));
}


@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(_events),const DeepCollectionEquality().hash(_badges));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LocationActivityDaySection(date: $date, events: $events, badges: $badges)';
}


}

/// @nodoc
abstract mixin class _$LocationActivityDaySectionCopyWith<$Res> implements $LocationActivityDaySectionCopyWith<$Res> {
  factory _$LocationActivityDaySectionCopyWith(_LocationActivityDaySection value, $Res Function(_LocationActivityDaySection) _then) = __$LocationActivityDaySectionCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, List<LocationLog> events, Map<LocationLog, LocationLogBadgeTier> badges
});




}
/// @nodoc
class __$LocationActivityDaySectionCopyWithImpl<$Res>
    implements _$LocationActivityDaySectionCopyWith<$Res> {
  __$LocationActivityDaySectionCopyWithImpl(this._self, this._then);

  final _LocationActivityDaySection _self;
  final $Res Function(_LocationActivityDaySection) _then;

/// Create a copy of LocationActivityDaySection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? events = null,Object? badges = null,}) {
  return _then(_LocationActivityDaySection(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<LocationLog>,badges: null == badges ? _self._badges : badges // ignore: cast_nullable_to_non_nullable
as Map<LocationLog, LocationLogBadgeTier>,
  ));
}


}

// dart format on
