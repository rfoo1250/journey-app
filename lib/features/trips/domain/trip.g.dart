// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Trip _$TripFromJson(Map<String, dynamic> json) => _Trip(
  id: json['id'] as String,
  startedAt: DateTime.parse(json['startedAt'] as String),
  status: $enumDecode(_$TripStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  endedAt: json['endedAt'] == null
      ? null
      : DateTime.parse(json['endedAt'] as String),
  matchStatus: $enumDecodeNullable(_$MatchStatusEnumMap, json['matchStatus']),
  distanceM: (json['distanceM'] as num?)?.toDouble() ?? 0,
  durationS: (json['durationS'] as num?)?.toInt() ?? 0,
  movingS: (json['movingS'] as num?)?.toInt() ?? 0,
  avgSpeedMps: (json['avgSpeedMps'] as num?)?.toDouble(),
  maxSpeedMps: (json['maxSpeedMps'] as num?)?.toDouble(),
  startLat: (json['startLat'] as num?)?.toDouble(),
  startLon: (json['startLon'] as num?)?.toDouble(),
  endLat: (json['endLat'] as num?)?.toDouble(),
  endLon: (json['endLon'] as num?)?.toDouble(),
  startPlace: json['startPlace'] as String?,
  endPlace: json['endPlace'] as String?,
  rawPolyline6: json['rawPolyline6'] as String?,
  matchedPolyline6: json['matchedPolyline6'] as String?,
);

Map<String, dynamic> _$TripToJson(_Trip instance) => <String, dynamic>{
  'id': instance.id,
  'startedAt': instance.startedAt.toIso8601String(),
  'status': _$TripStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'endedAt': instance.endedAt?.toIso8601String(),
  'matchStatus': _$MatchStatusEnumMap[instance.matchStatus],
  'distanceM': instance.distanceM,
  'durationS': instance.durationS,
  'movingS': instance.movingS,
  'avgSpeedMps': instance.avgSpeedMps,
  'maxSpeedMps': instance.maxSpeedMps,
  'startLat': instance.startLat,
  'startLon': instance.startLon,
  'endLat': instance.endLat,
  'endLon': instance.endLon,
  'startPlace': instance.startPlace,
  'endPlace': instance.endPlace,
  'rawPolyline6': instance.rawPolyline6,
  'matchedPolyline6': instance.matchedPolyline6,
};

const _$TripStatusEnumMap = {
  TripStatus.inProgress: 'inProgress',
  TripStatus.complete: 'complete',
};

const _$MatchStatusEnumMap = {
  MatchStatus.matched: 'matched',
  MatchStatus.unmatched: 'unmatched',
  MatchStatus.failed: 'failed',
};
