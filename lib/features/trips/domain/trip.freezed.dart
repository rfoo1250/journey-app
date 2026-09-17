// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Trip {

 String get id; DateTime get startedAt; TripStatus get status; DateTime get createdAt; DateTime? get endedAt; MatchStatus? get matchStatus; double get distanceM; int get durationS; int get movingS; double? get avgSpeedMps; double? get maxSpeedMps; double? get startLat; double? get startLon; double? get endLat; double? get endLon; String? get startPlace; String? get endPlace; String? get rawPolyline6; String? get matchedPolyline6;
/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripCopyWith<Trip> get copyWith => _$TripCopyWithImpl<Trip>(this as Trip, _$identity);

  /// Serializes this Trip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Trip;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Trip&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.endedAt, _this.endedAt) || other.endedAt == _this.endedAt)&&(identical(other.matchStatus, _this.matchStatus) || other.matchStatus == _this.matchStatus)&&(identical(other.distanceM, _this.distanceM) || other.distanceM == _this.distanceM)&&(identical(other.durationS, _this.durationS) || other.durationS == _this.durationS)&&(identical(other.movingS, _this.movingS) || other.movingS == _this.movingS)&&(identical(other.avgSpeedMps, _this.avgSpeedMps) || other.avgSpeedMps == _this.avgSpeedMps)&&(identical(other.maxSpeedMps, _this.maxSpeedMps) || other.maxSpeedMps == _this.maxSpeedMps)&&(identical(other.startLat, _this.startLat) || other.startLat == _this.startLat)&&(identical(other.startLon, _this.startLon) || other.startLon == _this.startLon)&&(identical(other.endLat, _this.endLat) || other.endLat == _this.endLat)&&(identical(other.endLon, _this.endLon) || other.endLon == _this.endLon)&&(identical(other.startPlace, _this.startPlace) || other.startPlace == _this.startPlace)&&(identical(other.endPlace, _this.endPlace) || other.endPlace == _this.endPlace)&&(identical(other.rawPolyline6, _this.rawPolyline6) || other.rawPolyline6 == _this.rawPolyline6)&&(identical(other.matchedPolyline6, _this.matchedPolyline6) || other.matchedPolyline6 == _this.matchedPolyline6));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Trip;
  return Object.hashAll([runtimeType,_this.id,_this.startedAt,_this.status,_this.createdAt,_this.endedAt,_this.matchStatus,_this.distanceM,_this.durationS,_this.movingS,_this.avgSpeedMps,_this.maxSpeedMps,_this.startLat,_this.startLon,_this.endLat,_this.endLon,_this.startPlace,_this.endPlace,_this.rawPolyline6,_this.matchedPolyline6]);
}

@override
String toString() {
  final _this = this as Trip;
  return 'Trip(id: ${_this.id}, startedAt: ${_this.startedAt}, status: ${_this.status}, createdAt: ${_this.createdAt}, endedAt: ${_this.endedAt}, matchStatus: ${_this.matchStatus}, distanceM: ${_this.distanceM}, durationS: ${_this.durationS}, movingS: ${_this.movingS}, avgSpeedMps: ${_this.avgSpeedMps}, maxSpeedMps: ${_this.maxSpeedMps}, startLat: ${_this.startLat}, startLon: ${_this.startLon}, endLat: ${_this.endLat}, endLon: ${_this.endLon}, startPlace: ${_this.startPlace}, endPlace: ${_this.endPlace}, rawPolyline6: ${_this.rawPolyline6}, matchedPolyline6: ${_this.matchedPolyline6})';
}


}

/// @nodoc
abstract mixin class $TripCopyWith<$Res>  {
  factory $TripCopyWith(Trip value, $Res Function(Trip) _then) = _$TripCopyWithImpl;
@useResult
$Res call({
 String id, DateTime startedAt, TripStatus status, DateTime createdAt, DateTime? endedAt, MatchStatus? matchStatus, double distanceM, int durationS, int movingS, double? avgSpeedMps, double? maxSpeedMps, double? startLat, double? startLon, double? endLat, double? endLon, String? startPlace, String? endPlace, String? rawPolyline6, String? matchedPolyline6
});




}
/// @nodoc
class _$TripCopyWithImpl<$Res>
    implements $TripCopyWith<$Res> {
  _$TripCopyWithImpl(this._self, this._then);

  final Trip _self;
  final $Res Function(Trip) _then;

/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startedAt = null,Object? status = null,Object? createdAt = null,Object? endedAt = freezed,Object? matchStatus = freezed,Object? distanceM = null,Object? durationS = null,Object? movingS = null,Object? avgSpeedMps = freezed,Object? maxSpeedMps = freezed,Object? startLat = freezed,Object? startLon = freezed,Object? endLat = freezed,Object? endLon = freezed,Object? startPlace = freezed,Object? endPlace = freezed,Object? rawPolyline6 = freezed,Object? matchedPolyline6 = freezed,}) {
  return _then(Trip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,matchStatus: freezed == matchStatus ? _self.matchStatus : matchStatus // ignore: cast_nullable_to_non_nullable
as MatchStatus?,distanceM: null == distanceM ? _self.distanceM : distanceM // ignore: cast_nullable_to_non_nullable
as double,durationS: null == durationS ? _self.durationS : durationS // ignore: cast_nullable_to_non_nullable
as int,movingS: null == movingS ? _self.movingS : movingS // ignore: cast_nullable_to_non_nullable
as int,avgSpeedMps: freezed == avgSpeedMps ? _self.avgSpeedMps : avgSpeedMps // ignore: cast_nullable_to_non_nullable
as double?,maxSpeedMps: freezed == maxSpeedMps ? _self.maxSpeedMps : maxSpeedMps // ignore: cast_nullable_to_non_nullable
as double?,startLat: freezed == startLat ? _self.startLat : startLat // ignore: cast_nullable_to_non_nullable
as double?,startLon: freezed == startLon ? _self.startLon : startLon // ignore: cast_nullable_to_non_nullable
as double?,endLat: freezed == endLat ? _self.endLat : endLat // ignore: cast_nullable_to_non_nullable
as double?,endLon: freezed == endLon ? _self.endLon : endLon // ignore: cast_nullable_to_non_nullable
as double?,startPlace: freezed == startPlace ? _self.startPlace : startPlace // ignore: cast_nullable_to_non_nullable
as String?,endPlace: freezed == endPlace ? _self.endPlace : endPlace // ignore: cast_nullable_to_non_nullable
as String?,rawPolyline6: freezed == rawPolyline6 ? _self.rawPolyline6 : rawPolyline6 // ignore: cast_nullable_to_non_nullable
as String?,matchedPolyline6: freezed == matchedPolyline6 ? _self.matchedPolyline6 : matchedPolyline6 // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Trip].
extension TripPatterns on Trip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Trip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Trip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Trip value)  $default,){
final _that = this;
switch (_that) {
case _Trip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Trip value)?  $default,){
final _that = this;
switch (_that) {
case _Trip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime startedAt,  TripStatus status,  DateTime createdAt,  DateTime? endedAt,  MatchStatus? matchStatus,  double distanceM,  int durationS,  int movingS,  double? avgSpeedMps,  double? maxSpeedMps,  double? startLat,  double? startLon,  double? endLat,  double? endLon,  String? startPlace,  String? endPlace,  String? rawPolyline6,  String? matchedPolyline6)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Trip() when $default != null:
return $default(_that.id,_that.startedAt,_that.status,_that.createdAt,_that.endedAt,_that.matchStatus,_that.distanceM,_that.durationS,_that.movingS,_that.avgSpeedMps,_that.maxSpeedMps,_that.startLat,_that.startLon,_that.endLat,_that.endLon,_that.startPlace,_that.endPlace,_that.rawPolyline6,_that.matchedPolyline6);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime startedAt,  TripStatus status,  DateTime createdAt,  DateTime? endedAt,  MatchStatus? matchStatus,  double distanceM,  int durationS,  int movingS,  double? avgSpeedMps,  double? maxSpeedMps,  double? startLat,  double? startLon,  double? endLat,  double? endLon,  String? startPlace,  String? endPlace,  String? rawPolyline6,  String? matchedPolyline6)  $default,) {final _that = this;
switch (_that) {
case _Trip():
return $default(_that.id,_that.startedAt,_that.status,_that.createdAt,_that.endedAt,_that.matchStatus,_that.distanceM,_that.durationS,_that.movingS,_that.avgSpeedMps,_that.maxSpeedMps,_that.startLat,_that.startLon,_that.endLat,_that.endLon,_that.startPlace,_that.endPlace,_that.rawPolyline6,_that.matchedPolyline6);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime startedAt,  TripStatus status,  DateTime createdAt,  DateTime? endedAt,  MatchStatus? matchStatus,  double distanceM,  int durationS,  int movingS,  double? avgSpeedMps,  double? maxSpeedMps,  double? startLat,  double? startLon,  double? endLat,  double? endLon,  String? startPlace,  String? endPlace,  String? rawPolyline6,  String? matchedPolyline6)?  $default,) {final _that = this;
switch (_that) {
case _Trip() when $default != null:
return $default(_that.id,_that.startedAt,_that.status,_that.createdAt,_that.endedAt,_that.matchStatus,_that.distanceM,_that.durationS,_that.movingS,_that.avgSpeedMps,_that.maxSpeedMps,_that.startLat,_that.startLon,_that.endLat,_that.endLon,_that.startPlace,_that.endPlace,_that.rawPolyline6,_that.matchedPolyline6);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Trip implements Trip {
  const _Trip({required this.id, required this.startedAt, required this.status, required this.createdAt, this.endedAt, this.matchStatus, this.distanceM = 0, this.durationS = 0, this.movingS = 0, this.avgSpeedMps, this.maxSpeedMps, this.startLat, this.startLon, this.endLat, this.endLon, this.startPlace, this.endPlace, this.rawPolyline6, this.matchedPolyline6});
  factory _Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

@override final  String id;
@override final  DateTime startedAt;
@override final  TripStatus status;
@override final  DateTime createdAt;
@override final  DateTime? endedAt;
@override final  MatchStatus? matchStatus;
@override@JsonKey() final  double distanceM;
@override@JsonKey() final  int durationS;
@override@JsonKey() final  int movingS;
@override final  double? avgSpeedMps;
@override final  double? maxSpeedMps;
@override final  double? startLat;
@override final  double? startLon;
@override final  double? endLat;
@override final  double? endLon;
@override final  String? startPlace;
@override final  String? endPlace;
@override final  String? rawPolyline6;
@override final  String? matchedPolyline6;

/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripCopyWith<_Trip> get copyWith => __$TripCopyWithImpl<_Trip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Trip&&(identical(other.id, id) || other.id == id)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.matchStatus, matchStatus) || other.matchStatus == matchStatus)&&(identical(other.distanceM, distanceM) || other.distanceM == distanceM)&&(identical(other.durationS, durationS) || other.durationS == durationS)&&(identical(other.movingS, movingS) || other.movingS == movingS)&&(identical(other.avgSpeedMps, avgSpeedMps) || other.avgSpeedMps == avgSpeedMps)&&(identical(other.maxSpeedMps, maxSpeedMps) || other.maxSpeedMps == maxSpeedMps)&&(identical(other.startLat, startLat) || other.startLat == startLat)&&(identical(other.startLon, startLon) || other.startLon == startLon)&&(identical(other.endLat, endLat) || other.endLat == endLat)&&(identical(other.endLon, endLon) || other.endLon == endLon)&&(identical(other.startPlace, startPlace) || other.startPlace == startPlace)&&(identical(other.endPlace, endPlace) || other.endPlace == endPlace)&&(identical(other.rawPolyline6, rawPolyline6) || other.rawPolyline6 == rawPolyline6)&&(identical(other.matchedPolyline6, matchedPolyline6) || other.matchedPolyline6 == matchedPolyline6));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,startedAt,status,createdAt,endedAt,matchStatus,distanceM,durationS,movingS,avgSpeedMps,maxSpeedMps,startLat,startLon,endLat,endLon,startPlace,endPlace,rawPolyline6,matchedPolyline6]);
}

@override
String toString() {
    return 'Trip(id: $id, startedAt: $startedAt, status: $status, createdAt: $createdAt, endedAt: $endedAt, matchStatus: $matchStatus, distanceM: $distanceM, durationS: $durationS, movingS: $movingS, avgSpeedMps: $avgSpeedMps, maxSpeedMps: $maxSpeedMps, startLat: $startLat, startLon: $startLon, endLat: $endLat, endLon: $endLon, startPlace: $startPlace, endPlace: $endPlace, rawPolyline6: $rawPolyline6, matchedPolyline6: $matchedPolyline6)';
}


}

/// @nodoc
abstract mixin class _$TripCopyWith<$Res> implements $TripCopyWith<$Res> {
  factory _$TripCopyWith(_Trip value, $Res Function(_Trip) _then) = __$TripCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime startedAt, TripStatus status, DateTime createdAt, DateTime? endedAt, MatchStatus? matchStatus, double distanceM, int durationS, int movingS, double? avgSpeedMps, double? maxSpeedMps, double? startLat, double? startLon, double? endLat, double? endLon, String? startPlace, String? endPlace, String? rawPolyline6, String? matchedPolyline6
});




}
/// @nodoc
class __$TripCopyWithImpl<$Res>
    implements _$TripCopyWith<$Res> {
  __$TripCopyWithImpl(this._self, this._then);

  final _Trip _self;
  final $Res Function(_Trip) _then;

/// Create a copy of Trip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startedAt = null,Object? status = null,Object? createdAt = null,Object? endedAt = freezed,Object? matchStatus = freezed,Object? distanceM = null,Object? durationS = null,Object? movingS = null,Object? avgSpeedMps = freezed,Object? maxSpeedMps = freezed,Object? startLat = freezed,Object? startLon = freezed,Object? endLat = freezed,Object? endLon = freezed,Object? startPlace = freezed,Object? endPlace = freezed,Object? rawPolyline6 = freezed,Object? matchedPolyline6 = freezed,}) {
  return _then(_Trip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,matchStatus: freezed == matchStatus ? _self.matchStatus : matchStatus // ignore: cast_nullable_to_non_nullable
as MatchStatus?,distanceM: null == distanceM ? _self.distanceM : distanceM // ignore: cast_nullable_to_non_nullable
as double,durationS: null == durationS ? _self.durationS : durationS // ignore: cast_nullable_to_non_nullable
as int,movingS: null == movingS ? _self.movingS : movingS // ignore: cast_nullable_to_non_nullable
as int,avgSpeedMps: freezed == avgSpeedMps ? _self.avgSpeedMps : avgSpeedMps // ignore: cast_nullable_to_non_nullable
as double?,maxSpeedMps: freezed == maxSpeedMps ? _self.maxSpeedMps : maxSpeedMps // ignore: cast_nullable_to_non_nullable
as double?,startLat: freezed == startLat ? _self.startLat : startLat // ignore: cast_nullable_to_non_nullable
as double?,startLon: freezed == startLon ? _self.startLon : startLon // ignore: cast_nullable_to_non_nullable
as double?,endLat: freezed == endLat ? _self.endLat : endLat // ignore: cast_nullable_to_non_nullable
as double?,endLon: freezed == endLon ? _self.endLon : endLon // ignore: cast_nullable_to_non_nullable
as double?,startPlace: freezed == startPlace ? _self.startPlace : startPlace // ignore: cast_nullable_to_non_nullable
as String?,endPlace: freezed == endPlace ? _self.endPlace : endPlace // ignore: cast_nullable_to_non_nullable
as String?,rawPolyline6: freezed == rawPolyline6 ? _self.rawPolyline6 : rawPolyline6 // ignore: cast_nullable_to_non_nullable
as String?,matchedPolyline6: freezed == matchedPolyline6 ? _self.matchedPolyline6 : matchedPolyline6 // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
