// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TripsTable extends Trips with TableInfo<$TripsTable, TripRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TripsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<int> startedAt = GeneratedColumn<int>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<int> endedAt = GeneratedColumn<int>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TripStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TripStatus>($TripsTable.$converterstatus);
  @override
  late final GeneratedColumnWithTypeConverter<MatchStatus?, String>
  matchStatus = GeneratedColumn<String>(
    'match_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<MatchStatus?>($TripsTable.$convertermatchStatusn);
  static const VerificationMeta _distanceMMeta = const VerificationMeta(
    'distanceM',
  );
  @override
  late final GeneratedColumn<double> distanceM = GeneratedColumn<double>(
    'distance_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _durationSMeta = const VerificationMeta(
    'durationS',
  );
  @override
  late final GeneratedColumn<int> durationS = GeneratedColumn<int>(
    'duration_s',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _movingSMeta = const VerificationMeta(
    'movingS',
  );
  @override
  late final GeneratedColumn<int> movingS = GeneratedColumn<int>(
    'moving_s',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _avgSpeedMpsMeta = const VerificationMeta(
    'avgSpeedMps',
  );
  @override
  late final GeneratedColumn<double> avgSpeedMps = GeneratedColumn<double>(
    'avg_speed_mps',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxSpeedMpsMeta = const VerificationMeta(
    'maxSpeedMps',
  );
  @override
  late final GeneratedColumn<double> maxSpeedMps = GeneratedColumn<double>(
    'max_speed_mps',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startLatMeta = const VerificationMeta(
    'startLat',
  );
  @override
  late final GeneratedColumn<double> startLat = GeneratedColumn<double>(
    'start_lat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startLonMeta = const VerificationMeta(
    'startLon',
  );
  @override
  late final GeneratedColumn<double> startLon = GeneratedColumn<double>(
    'start_lon',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endLatMeta = const VerificationMeta('endLat');
  @override
  late final GeneratedColumn<double> endLat = GeneratedColumn<double>(
    'end_lat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endLonMeta = const VerificationMeta('endLon');
  @override
  late final GeneratedColumn<double> endLon = GeneratedColumn<double>(
    'end_lon',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startPlaceMeta = const VerificationMeta(
    'startPlace',
  );
  @override
  late final GeneratedColumn<String> startPlace = GeneratedColumn<String>(
    'start_place',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endPlaceMeta = const VerificationMeta(
    'endPlace',
  );
  @override
  late final GeneratedColumn<String> endPlace = GeneratedColumn<String>(
    'end_place',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rawPolyline6Meta = const VerificationMeta(
    'rawPolyline6',
  );
  @override
  late final GeneratedColumn<String> rawPolyline6 = GeneratedColumn<String>(
    'raw_polyline6',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _matchedPolyline6Meta = const VerificationMeta(
    'matchedPolyline6',
  );
  @override
  late final GeneratedColumn<String> matchedPolyline6 = GeneratedColumn<String>(
    'matched_polyline6',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startedAt,
    endedAt,
    status,
    matchStatus,
    distanceM,
    durationS,
    movingS,
    avgSpeedMps,
    maxSpeedMps,
    startLat,
    startLon,
    endLat,
    endLon,
    startPlace,
    endPlace,
    rawPolyline6,
    matchedPolyline6,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trips';
  @override
  VerificationContext validateIntegrity(
    Insertable<TripRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('distance_m')) {
      context.handle(
        _distanceMMeta,
        distanceM.isAcceptableOrUnknown(data['distance_m']!, _distanceMMeta),
      );
    }
    if (data.containsKey('duration_s')) {
      context.handle(
        _durationSMeta,
        durationS.isAcceptableOrUnknown(data['duration_s']!, _durationSMeta),
      );
    }
    if (data.containsKey('moving_s')) {
      context.handle(
        _movingSMeta,
        movingS.isAcceptableOrUnknown(data['moving_s']!, _movingSMeta),
      );
    }
    if (data.containsKey('avg_speed_mps')) {
      context.handle(
        _avgSpeedMpsMeta,
        avgSpeedMps.isAcceptableOrUnknown(
          data['avg_speed_mps']!,
          _avgSpeedMpsMeta,
        ),
      );
    }
    if (data.containsKey('max_speed_mps')) {
      context.handle(
        _maxSpeedMpsMeta,
        maxSpeedMps.isAcceptableOrUnknown(
          data['max_speed_mps']!,
          _maxSpeedMpsMeta,
        ),
      );
    }
    if (data.containsKey('start_lat')) {
      context.handle(
        _startLatMeta,
        startLat.isAcceptableOrUnknown(data['start_lat']!, _startLatMeta),
      );
    }
    if (data.containsKey('start_lon')) {
      context.handle(
        _startLonMeta,
        startLon.isAcceptableOrUnknown(data['start_lon']!, _startLonMeta),
      );
    }
    if (data.containsKey('end_lat')) {
      context.handle(
        _endLatMeta,
        endLat.isAcceptableOrUnknown(data['end_lat']!, _endLatMeta),
      );
    }
    if (data.containsKey('end_lon')) {
      context.handle(
        _endLonMeta,
        endLon.isAcceptableOrUnknown(data['end_lon']!, _endLonMeta),
      );
    }
    if (data.containsKey('start_place')) {
      context.handle(
        _startPlaceMeta,
        startPlace.isAcceptableOrUnknown(data['start_place']!, _startPlaceMeta),
      );
    }
    if (data.containsKey('end_place')) {
      context.handle(
        _endPlaceMeta,
        endPlace.isAcceptableOrUnknown(data['end_place']!, _endPlaceMeta),
      );
    }
    if (data.containsKey('raw_polyline6')) {
      context.handle(
        _rawPolyline6Meta,
        rawPolyline6.isAcceptableOrUnknown(
          data['raw_polyline6']!,
          _rawPolyline6Meta,
        ),
      );
    }
    if (data.containsKey('matched_polyline6')) {
      context.handle(
        _matchedPolyline6Meta,
        matchedPolyline6.isAcceptableOrUnknown(
          data['matched_polyline6']!,
          _matchedPolyline6Meta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TripRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TripRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ended_at'],
      ),
      status: $TripsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      matchStatus: $TripsTable.$convertermatchStatusn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}match_status'],
        ),
      ),
      distanceM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance_m'],
      )!,
      durationS: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_s'],
      )!,
      movingS: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}moving_s'],
      )!,
      avgSpeedMps: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_speed_mps'],
      ),
      maxSpeedMps: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_speed_mps'],
      ),
      startLat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}start_lat'],
      ),
      startLon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}start_lon'],
      ),
      endLat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}end_lat'],
      ),
      endLon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}end_lon'],
      ),
      startPlace: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_place'],
      ),
      endPlace: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_place'],
      ),
      rawPolyline6: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_polyline6'],
      ),
      matchedPolyline6: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}matched_polyline6'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TripsTable createAlias(String alias) {
    return $TripsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TripStatus, String, String> $converterstatus =
      const EnumNameConverter<TripStatus>(TripStatus.values);
  static JsonTypeConverter2<MatchStatus, String, String> $convertermatchStatus =
      const EnumNameConverter<MatchStatus>(MatchStatus.values);
  static JsonTypeConverter2<MatchStatus?, String?, String?>
  $convertermatchStatusn = JsonTypeConverter2.asNullable($convertermatchStatus);
}

class TripRow extends DataClass implements Insertable<TripRow> {
  final String id;
  final int startedAt;
  final int? endedAt;
  final TripStatus status;
  final MatchStatus? matchStatus;
  final double distanceM;
  final int durationS;
  final int movingS;
  final double? avgSpeedMps;
  final double? maxSpeedMps;
  final double? startLat;
  final double? startLon;
  final double? endLat;
  final double? endLon;
  final String? startPlace;
  final String? endPlace;
  final String? rawPolyline6;
  final String? matchedPolyline6;
  final int createdAt;
  const TripRow({
    required this.id,
    required this.startedAt,
    this.endedAt,
    required this.status,
    this.matchStatus,
    required this.distanceM,
    required this.durationS,
    required this.movingS,
    this.avgSpeedMps,
    this.maxSpeedMps,
    this.startLat,
    this.startLon,
    this.endLat,
    this.endLon,
    this.startPlace,
    this.endPlace,
    this.rawPolyline6,
    this.matchedPolyline6,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['started_at'] = Variable<int>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<int>(endedAt);
    }
    {
      map['status'] = Variable<String>(
        $TripsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || matchStatus != null) {
      map['match_status'] = Variable<String>(
        $TripsTable.$convertermatchStatusn.toSql(matchStatus),
      );
    }
    map['distance_m'] = Variable<double>(distanceM);
    map['duration_s'] = Variable<int>(durationS);
    map['moving_s'] = Variable<int>(movingS);
    if (!nullToAbsent || avgSpeedMps != null) {
      map['avg_speed_mps'] = Variable<double>(avgSpeedMps);
    }
    if (!nullToAbsent || maxSpeedMps != null) {
      map['max_speed_mps'] = Variable<double>(maxSpeedMps);
    }
    if (!nullToAbsent || startLat != null) {
      map['start_lat'] = Variable<double>(startLat);
    }
    if (!nullToAbsent || startLon != null) {
      map['start_lon'] = Variable<double>(startLon);
    }
    if (!nullToAbsent || endLat != null) {
      map['end_lat'] = Variable<double>(endLat);
    }
    if (!nullToAbsent || endLon != null) {
      map['end_lon'] = Variable<double>(endLon);
    }
    if (!nullToAbsent || startPlace != null) {
      map['start_place'] = Variable<String>(startPlace);
    }
    if (!nullToAbsent || endPlace != null) {
      map['end_place'] = Variable<String>(endPlace);
    }
    if (!nullToAbsent || rawPolyline6 != null) {
      map['raw_polyline6'] = Variable<String>(rawPolyline6);
    }
    if (!nullToAbsent || matchedPolyline6 != null) {
      map['matched_polyline6'] = Variable<String>(matchedPolyline6);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  TripsCompanion toCompanion(bool nullToAbsent) {
    return TripsCompanion(
      id: Value(id),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      status: Value(status),
      matchStatus: matchStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(matchStatus),
      distanceM: Value(distanceM),
      durationS: Value(durationS),
      movingS: Value(movingS),
      avgSpeedMps: avgSpeedMps == null && nullToAbsent
          ? const Value.absent()
          : Value(avgSpeedMps),
      maxSpeedMps: maxSpeedMps == null && nullToAbsent
          ? const Value.absent()
          : Value(maxSpeedMps),
      startLat: startLat == null && nullToAbsent
          ? const Value.absent()
          : Value(startLat),
      startLon: startLon == null && nullToAbsent
          ? const Value.absent()
          : Value(startLon),
      endLat: endLat == null && nullToAbsent
          ? const Value.absent()
          : Value(endLat),
      endLon: endLon == null && nullToAbsent
          ? const Value.absent()
          : Value(endLon),
      startPlace: startPlace == null && nullToAbsent
          ? const Value.absent()
          : Value(startPlace),
      endPlace: endPlace == null && nullToAbsent
          ? const Value.absent()
          : Value(endPlace),
      rawPolyline6: rawPolyline6 == null && nullToAbsent
          ? const Value.absent()
          : Value(rawPolyline6),
      matchedPolyline6: matchedPolyline6 == null && nullToAbsent
          ? const Value.absent()
          : Value(matchedPolyline6),
      createdAt: Value(createdAt),
    );
  }

  factory TripRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TripRow(
      id: serializer.fromJson<String>(json['id']),
      startedAt: serializer.fromJson<int>(json['startedAt']),
      endedAt: serializer.fromJson<int?>(json['endedAt']),
      status: $TripsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      matchStatus: $TripsTable.$convertermatchStatusn.fromJson(
        serializer.fromJson<String?>(json['matchStatus']),
      ),
      distanceM: serializer.fromJson<double>(json['distanceM']),
      durationS: serializer.fromJson<int>(json['durationS']),
      movingS: serializer.fromJson<int>(json['movingS']),
      avgSpeedMps: serializer.fromJson<double?>(json['avgSpeedMps']),
      maxSpeedMps: serializer.fromJson<double?>(json['maxSpeedMps']),
      startLat: serializer.fromJson<double?>(json['startLat']),
      startLon: serializer.fromJson<double?>(json['startLon']),
      endLat: serializer.fromJson<double?>(json['endLat']),
      endLon: serializer.fromJson<double?>(json['endLon']),
      startPlace: serializer.fromJson<String?>(json['startPlace']),
      endPlace: serializer.fromJson<String?>(json['endPlace']),
      rawPolyline6: serializer.fromJson<String?>(json['rawPolyline6']),
      matchedPolyline6: serializer.fromJson<String?>(json['matchedPolyline6']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'startedAt': serializer.toJson<int>(startedAt),
      'endedAt': serializer.toJson<int?>(endedAt),
      'status': serializer.toJson<String>(
        $TripsTable.$converterstatus.toJson(status),
      ),
      'matchStatus': serializer.toJson<String?>(
        $TripsTable.$convertermatchStatusn.toJson(matchStatus),
      ),
      'distanceM': serializer.toJson<double>(distanceM),
      'durationS': serializer.toJson<int>(durationS),
      'movingS': serializer.toJson<int>(movingS),
      'avgSpeedMps': serializer.toJson<double?>(avgSpeedMps),
      'maxSpeedMps': serializer.toJson<double?>(maxSpeedMps),
      'startLat': serializer.toJson<double?>(startLat),
      'startLon': serializer.toJson<double?>(startLon),
      'endLat': serializer.toJson<double?>(endLat),
      'endLon': serializer.toJson<double?>(endLon),
      'startPlace': serializer.toJson<String?>(startPlace),
      'endPlace': serializer.toJson<String?>(endPlace),
      'rawPolyline6': serializer.toJson<String?>(rawPolyline6),
      'matchedPolyline6': serializer.toJson<String?>(matchedPolyline6),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  TripRow copyWith({
    String? id,
    int? startedAt,
    Value<int?> endedAt = const Value.absent(),
    TripStatus? status,
    Value<MatchStatus?> matchStatus = const Value.absent(),
    double? distanceM,
    int? durationS,
    int? movingS,
    Value<double?> avgSpeedMps = const Value.absent(),
    Value<double?> maxSpeedMps = const Value.absent(),
    Value<double?> startLat = const Value.absent(),
    Value<double?> startLon = const Value.absent(),
    Value<double?> endLat = const Value.absent(),
    Value<double?> endLon = const Value.absent(),
    Value<String?> startPlace = const Value.absent(),
    Value<String?> endPlace = const Value.absent(),
    Value<String?> rawPolyline6 = const Value.absent(),
    Value<String?> matchedPolyline6 = const Value.absent(),
    int? createdAt,
  }) => TripRow(
    id: id ?? this.id,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    status: status ?? this.status,
    matchStatus: matchStatus.present ? matchStatus.value : this.matchStatus,
    distanceM: distanceM ?? this.distanceM,
    durationS: durationS ?? this.durationS,
    movingS: movingS ?? this.movingS,
    avgSpeedMps: avgSpeedMps.present ? avgSpeedMps.value : this.avgSpeedMps,
    maxSpeedMps: maxSpeedMps.present ? maxSpeedMps.value : this.maxSpeedMps,
    startLat: startLat.present ? startLat.value : this.startLat,
    startLon: startLon.present ? startLon.value : this.startLon,
    endLat: endLat.present ? endLat.value : this.endLat,
    endLon: endLon.present ? endLon.value : this.endLon,
    startPlace: startPlace.present ? startPlace.value : this.startPlace,
    endPlace: endPlace.present ? endPlace.value : this.endPlace,
    rawPolyline6: rawPolyline6.present ? rawPolyline6.value : this.rawPolyline6,
    matchedPolyline6: matchedPolyline6.present
        ? matchedPolyline6.value
        : this.matchedPolyline6,
    createdAt: createdAt ?? this.createdAt,
  );
  TripRow copyWithCompanion(TripsCompanion data) {
    return TripRow(
      id: data.id.present ? data.id.value : this.id,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      status: data.status.present ? data.status.value : this.status,
      matchStatus: data.matchStatus.present
          ? data.matchStatus.value
          : this.matchStatus,
      distanceM: data.distanceM.present ? data.distanceM.value : this.distanceM,
      durationS: data.durationS.present ? data.durationS.value : this.durationS,
      movingS: data.movingS.present ? data.movingS.value : this.movingS,
      avgSpeedMps: data.avgSpeedMps.present
          ? data.avgSpeedMps.value
          : this.avgSpeedMps,
      maxSpeedMps: data.maxSpeedMps.present
          ? data.maxSpeedMps.value
          : this.maxSpeedMps,
      startLat: data.startLat.present ? data.startLat.value : this.startLat,
      startLon: data.startLon.present ? data.startLon.value : this.startLon,
      endLat: data.endLat.present ? data.endLat.value : this.endLat,
      endLon: data.endLon.present ? data.endLon.value : this.endLon,
      startPlace: data.startPlace.present
          ? data.startPlace.value
          : this.startPlace,
      endPlace: data.endPlace.present ? data.endPlace.value : this.endPlace,
      rawPolyline6: data.rawPolyline6.present
          ? data.rawPolyline6.value
          : this.rawPolyline6,
      matchedPolyline6: data.matchedPolyline6.present
          ? data.matchedPolyline6.value
          : this.matchedPolyline6,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TripRow(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('status: $status, ')
          ..write('matchStatus: $matchStatus, ')
          ..write('distanceM: $distanceM, ')
          ..write('durationS: $durationS, ')
          ..write('movingS: $movingS, ')
          ..write('avgSpeedMps: $avgSpeedMps, ')
          ..write('maxSpeedMps: $maxSpeedMps, ')
          ..write('startLat: $startLat, ')
          ..write('startLon: $startLon, ')
          ..write('endLat: $endLat, ')
          ..write('endLon: $endLon, ')
          ..write('startPlace: $startPlace, ')
          ..write('endPlace: $endPlace, ')
          ..write('rawPolyline6: $rawPolyline6, ')
          ..write('matchedPolyline6: $matchedPolyline6, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startedAt,
    endedAt,
    status,
    matchStatus,
    distanceM,
    durationS,
    movingS,
    avgSpeedMps,
    maxSpeedMps,
    startLat,
    startLon,
    endLat,
    endLon,
    startPlace,
    endPlace,
    rawPolyline6,
    matchedPolyline6,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TripRow &&
          other.id == this.id &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.status == this.status &&
          other.matchStatus == this.matchStatus &&
          other.distanceM == this.distanceM &&
          other.durationS == this.durationS &&
          other.movingS == this.movingS &&
          other.avgSpeedMps == this.avgSpeedMps &&
          other.maxSpeedMps == this.maxSpeedMps &&
          other.startLat == this.startLat &&
          other.startLon == this.startLon &&
          other.endLat == this.endLat &&
          other.endLon == this.endLon &&
          other.startPlace == this.startPlace &&
          other.endPlace == this.endPlace &&
          other.rawPolyline6 == this.rawPolyline6 &&
          other.matchedPolyline6 == this.matchedPolyline6 &&
          other.createdAt == this.createdAt);
}

class TripsCompanion extends UpdateCompanion<TripRow> {
  final Value<String> id;
  final Value<int> startedAt;
  final Value<int?> endedAt;
  final Value<TripStatus> status;
  final Value<MatchStatus?> matchStatus;
  final Value<double> distanceM;
  final Value<int> durationS;
  final Value<int> movingS;
  final Value<double?> avgSpeedMps;
  final Value<double?> maxSpeedMps;
  final Value<double?> startLat;
  final Value<double?> startLon;
  final Value<double?> endLat;
  final Value<double?> endLon;
  final Value<String?> startPlace;
  final Value<String?> endPlace;
  final Value<String?> rawPolyline6;
  final Value<String?> matchedPolyline6;
  final Value<int> createdAt;
  final Value<int> rowid;
  const TripsCompanion({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.matchStatus = const Value.absent(),
    this.distanceM = const Value.absent(),
    this.durationS = const Value.absent(),
    this.movingS = const Value.absent(),
    this.avgSpeedMps = const Value.absent(),
    this.maxSpeedMps = const Value.absent(),
    this.startLat = const Value.absent(),
    this.startLon = const Value.absent(),
    this.endLat = const Value.absent(),
    this.endLon = const Value.absent(),
    this.startPlace = const Value.absent(),
    this.endPlace = const Value.absent(),
    this.rawPolyline6 = const Value.absent(),
    this.matchedPolyline6 = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TripsCompanion.insert({
    required String id,
    required int startedAt,
    this.endedAt = const Value.absent(),
    required TripStatus status,
    this.matchStatus = const Value.absent(),
    this.distanceM = const Value.absent(),
    this.durationS = const Value.absent(),
    this.movingS = const Value.absent(),
    this.avgSpeedMps = const Value.absent(),
    this.maxSpeedMps = const Value.absent(),
    this.startLat = const Value.absent(),
    this.startLon = const Value.absent(),
    this.endLat = const Value.absent(),
    this.endLon = const Value.absent(),
    this.startPlace = const Value.absent(),
    this.endPlace = const Value.absent(),
    this.rawPolyline6 = const Value.absent(),
    this.matchedPolyline6 = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       startedAt = Value(startedAt),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<TripRow> custom({
    Expression<String>? id,
    Expression<int>? startedAt,
    Expression<int>? endedAt,
    Expression<String>? status,
    Expression<String>? matchStatus,
    Expression<double>? distanceM,
    Expression<int>? durationS,
    Expression<int>? movingS,
    Expression<double>? avgSpeedMps,
    Expression<double>? maxSpeedMps,
    Expression<double>? startLat,
    Expression<double>? startLon,
    Expression<double>? endLat,
    Expression<double>? endLon,
    Expression<String>? startPlace,
    Expression<String>? endPlace,
    Expression<String>? rawPolyline6,
    Expression<String>? matchedPolyline6,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (status != null) 'status': status,
      if (matchStatus != null) 'match_status': matchStatus,
      if (distanceM != null) 'distance_m': distanceM,
      if (durationS != null) 'duration_s': durationS,
      if (movingS != null) 'moving_s': movingS,
      if (avgSpeedMps != null) 'avg_speed_mps': avgSpeedMps,
      if (maxSpeedMps != null) 'max_speed_mps': maxSpeedMps,
      if (startLat != null) 'start_lat': startLat,
      if (startLon != null) 'start_lon': startLon,
      if (endLat != null) 'end_lat': endLat,
      if (endLon != null) 'end_lon': endLon,
      if (startPlace != null) 'start_place': startPlace,
      if (endPlace != null) 'end_place': endPlace,
      if (rawPolyline6 != null) 'raw_polyline6': rawPolyline6,
      if (matchedPolyline6 != null) 'matched_polyline6': matchedPolyline6,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TripsCompanion copyWith({
    Value<String>? id,
    Value<int>? startedAt,
    Value<int?>? endedAt,
    Value<TripStatus>? status,
    Value<MatchStatus?>? matchStatus,
    Value<double>? distanceM,
    Value<int>? durationS,
    Value<int>? movingS,
    Value<double?>? avgSpeedMps,
    Value<double?>? maxSpeedMps,
    Value<double?>? startLat,
    Value<double?>? startLon,
    Value<double?>? endLat,
    Value<double?>? endLon,
    Value<String?>? startPlace,
    Value<String?>? endPlace,
    Value<String?>? rawPolyline6,
    Value<String?>? matchedPolyline6,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return TripsCompanion(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      status: status ?? this.status,
      matchStatus: matchStatus ?? this.matchStatus,
      distanceM: distanceM ?? this.distanceM,
      durationS: durationS ?? this.durationS,
      movingS: movingS ?? this.movingS,
      avgSpeedMps: avgSpeedMps ?? this.avgSpeedMps,
      maxSpeedMps: maxSpeedMps ?? this.maxSpeedMps,
      startLat: startLat ?? this.startLat,
      startLon: startLon ?? this.startLon,
      endLat: endLat ?? this.endLat,
      endLon: endLon ?? this.endLon,
      startPlace: startPlace ?? this.startPlace,
      endPlace: endPlace ?? this.endPlace,
      rawPolyline6: rawPolyline6 ?? this.rawPolyline6,
      matchedPolyline6: matchedPolyline6 ?? this.matchedPolyline6,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<int>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<int>(endedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $TripsTable.$converterstatus.toSql(status.value),
      );
    }
    if (matchStatus.present) {
      map['match_status'] = Variable<String>(
        $TripsTable.$convertermatchStatusn.toSql(matchStatus.value),
      );
    }
    if (distanceM.present) {
      map['distance_m'] = Variable<double>(distanceM.value);
    }
    if (durationS.present) {
      map['duration_s'] = Variable<int>(durationS.value);
    }
    if (movingS.present) {
      map['moving_s'] = Variable<int>(movingS.value);
    }
    if (avgSpeedMps.present) {
      map['avg_speed_mps'] = Variable<double>(avgSpeedMps.value);
    }
    if (maxSpeedMps.present) {
      map['max_speed_mps'] = Variable<double>(maxSpeedMps.value);
    }
    if (startLat.present) {
      map['start_lat'] = Variable<double>(startLat.value);
    }
    if (startLon.present) {
      map['start_lon'] = Variable<double>(startLon.value);
    }
    if (endLat.present) {
      map['end_lat'] = Variable<double>(endLat.value);
    }
    if (endLon.present) {
      map['end_lon'] = Variable<double>(endLon.value);
    }
    if (startPlace.present) {
      map['start_place'] = Variable<String>(startPlace.value);
    }
    if (endPlace.present) {
      map['end_place'] = Variable<String>(endPlace.value);
    }
    if (rawPolyline6.present) {
      map['raw_polyline6'] = Variable<String>(rawPolyline6.value);
    }
    if (matchedPolyline6.present) {
      map['matched_polyline6'] = Variable<String>(matchedPolyline6.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TripsCompanion(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('status: $status, ')
          ..write('matchStatus: $matchStatus, ')
          ..write('distanceM: $distanceM, ')
          ..write('durationS: $durationS, ')
          ..write('movingS: $movingS, ')
          ..write('avgSpeedMps: $avgSpeedMps, ')
          ..write('maxSpeedMps: $maxSpeedMps, ')
          ..write('startLat: $startLat, ')
          ..write('startLon: $startLon, ')
          ..write('endLat: $endLat, ')
          ..write('endLon: $endLon, ')
          ..write('startPlace: $startPlace, ')
          ..write('endPlace: $endPlace, ')
          ..write('rawPolyline6: $rawPolyline6, ')
          ..write('matchedPolyline6: $matchedPolyline6, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TripPointsTable extends TripPoints
    with TableInfo<$TripPointsTable, TripPointRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TripPointsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tripIdMeta = const VerificationMeta('tripId');
  @override
  late final GeneratedColumn<String> tripId = GeneratedColumn<String>(
    'trip_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trips (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tsMeta = const VerificationMeta('ts');
  @override
  late final GeneratedColumn<int> ts = GeneratedColumn<int>(
    'ts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lonMeta = const VerificationMeta('lon');
  @override
  late final GeneratedColumn<double> lon = GeneratedColumn<double>(
    'lon',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accuracyMMeta = const VerificationMeta(
    'accuracyM',
  );
  @override
  late final GeneratedColumn<double> accuracyM = GeneratedColumn<double>(
    'accuracy_m',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _speedMpsMeta = const VerificationMeta(
    'speedMps',
  );
  @override
  late final GeneratedColumn<double> speedMps = GeneratedColumn<double>(
    'speed_mps',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _headingDegMeta = const VerificationMeta(
    'headingDeg',
  );
  @override
  late final GeneratedColumn<double> headingDeg = GeneratedColumn<double>(
    'heading_deg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altitudeMMeta = const VerificationMeta(
    'altitudeM',
  );
  @override
  late final GeneratedColumn<double> altitudeM = GeneratedColumn<double>(
    'altitude_m',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    tripId,
    ts,
    lat,
    lon,
    accuracyM,
    speedMps,
    headingDeg,
    altitudeM,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trip_points';
  @override
  VerificationContext validateIntegrity(
    Insertable<TripPointRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tripIdMeta);
    }
    if (data.containsKey('ts')) {
      context.handle(_tsMeta, ts.isAcceptableOrUnknown(data['ts']!, _tsMeta));
    } else if (isInserting) {
      context.missing(_tsMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lon')) {
      context.handle(
        _lonMeta,
        lon.isAcceptableOrUnknown(data['lon']!, _lonMeta),
      );
    } else if (isInserting) {
      context.missing(_lonMeta);
    }
    if (data.containsKey('accuracy_m')) {
      context.handle(
        _accuracyMMeta,
        accuracyM.isAcceptableOrUnknown(data['accuracy_m']!, _accuracyMMeta),
      );
    }
    if (data.containsKey('speed_mps')) {
      context.handle(
        _speedMpsMeta,
        speedMps.isAcceptableOrUnknown(data['speed_mps']!, _speedMpsMeta),
      );
    }
    if (data.containsKey('heading_deg')) {
      context.handle(
        _headingDegMeta,
        headingDeg.isAcceptableOrUnknown(data['heading_deg']!, _headingDegMeta),
      );
    }
    if (data.containsKey('altitude_m')) {
      context.handle(
        _altitudeMMeta,
        altitudeM.isAcceptableOrUnknown(data['altitude_m']!, _altitudeMMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TripPointRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TripPointRow(
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trip_id'],
      )!,
      ts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ts'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      )!,
      lon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lon'],
      )!,
      accuracyM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_m'],
      ),
      speedMps: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}speed_mps'],
      ),
      headingDeg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}heading_deg'],
      ),
      altitudeM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}altitude_m'],
      ),
    );
  }

  @override
  $TripPointsTable createAlias(String alias) {
    return $TripPointsTable(attachedDatabase, alias);
  }
}

class TripPointRow extends DataClass implements Insertable<TripPointRow> {
  final String tripId;
  final int ts;
  final double lat;
  final double lon;
  final double? accuracyM;
  final double? speedMps;
  final double? headingDeg;
  final double? altitudeM;
  const TripPointRow({
    required this.tripId,
    required this.ts,
    required this.lat,
    required this.lon,
    this.accuracyM,
    this.speedMps,
    this.headingDeg,
    this.altitudeM,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['trip_id'] = Variable<String>(tripId);
    map['ts'] = Variable<int>(ts);
    map['lat'] = Variable<double>(lat);
    map['lon'] = Variable<double>(lon);
    if (!nullToAbsent || accuracyM != null) {
      map['accuracy_m'] = Variable<double>(accuracyM);
    }
    if (!nullToAbsent || speedMps != null) {
      map['speed_mps'] = Variable<double>(speedMps);
    }
    if (!nullToAbsent || headingDeg != null) {
      map['heading_deg'] = Variable<double>(headingDeg);
    }
    if (!nullToAbsent || altitudeM != null) {
      map['altitude_m'] = Variable<double>(altitudeM);
    }
    return map;
  }

  TripPointsCompanion toCompanion(bool nullToAbsent) {
    return TripPointsCompanion(
      tripId: Value(tripId),
      ts: Value(ts),
      lat: Value(lat),
      lon: Value(lon),
      accuracyM: accuracyM == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracyM),
      speedMps: speedMps == null && nullToAbsent
          ? const Value.absent()
          : Value(speedMps),
      headingDeg: headingDeg == null && nullToAbsent
          ? const Value.absent()
          : Value(headingDeg),
      altitudeM: altitudeM == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeM),
    );
  }

  factory TripPointRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TripPointRow(
      tripId: serializer.fromJson<String>(json['tripId']),
      ts: serializer.fromJson<int>(json['ts']),
      lat: serializer.fromJson<double>(json['lat']),
      lon: serializer.fromJson<double>(json['lon']),
      accuracyM: serializer.fromJson<double?>(json['accuracyM']),
      speedMps: serializer.fromJson<double?>(json['speedMps']),
      headingDeg: serializer.fromJson<double?>(json['headingDeg']),
      altitudeM: serializer.fromJson<double?>(json['altitudeM']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tripId': serializer.toJson<String>(tripId),
      'ts': serializer.toJson<int>(ts),
      'lat': serializer.toJson<double>(lat),
      'lon': serializer.toJson<double>(lon),
      'accuracyM': serializer.toJson<double?>(accuracyM),
      'speedMps': serializer.toJson<double?>(speedMps),
      'headingDeg': serializer.toJson<double?>(headingDeg),
      'altitudeM': serializer.toJson<double?>(altitudeM),
    };
  }

  TripPointRow copyWith({
    String? tripId,
    int? ts,
    double? lat,
    double? lon,
    Value<double?> accuracyM = const Value.absent(),
    Value<double?> speedMps = const Value.absent(),
    Value<double?> headingDeg = const Value.absent(),
    Value<double?> altitudeM = const Value.absent(),
  }) => TripPointRow(
    tripId: tripId ?? this.tripId,
    ts: ts ?? this.ts,
    lat: lat ?? this.lat,
    lon: lon ?? this.lon,
    accuracyM: accuracyM.present ? accuracyM.value : this.accuracyM,
    speedMps: speedMps.present ? speedMps.value : this.speedMps,
    headingDeg: headingDeg.present ? headingDeg.value : this.headingDeg,
    altitudeM: altitudeM.present ? altitudeM.value : this.altitudeM,
  );
  TripPointRow copyWithCompanion(TripPointsCompanion data) {
    return TripPointRow(
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      ts: data.ts.present ? data.ts.value : this.ts,
      lat: data.lat.present ? data.lat.value : this.lat,
      lon: data.lon.present ? data.lon.value : this.lon,
      accuracyM: data.accuracyM.present ? data.accuracyM.value : this.accuracyM,
      speedMps: data.speedMps.present ? data.speedMps.value : this.speedMps,
      headingDeg: data.headingDeg.present
          ? data.headingDeg.value
          : this.headingDeg,
      altitudeM: data.altitudeM.present ? data.altitudeM.value : this.altitudeM,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TripPointRow(')
          ..write('tripId: $tripId, ')
          ..write('ts: $ts, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('accuracyM: $accuracyM, ')
          ..write('speedMps: $speedMps, ')
          ..write('headingDeg: $headingDeg, ')
          ..write('altitudeM: $altitudeM')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    tripId,
    ts,
    lat,
    lon,
    accuracyM,
    speedMps,
    headingDeg,
    altitudeM,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TripPointRow &&
          other.tripId == this.tripId &&
          other.ts == this.ts &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.accuracyM == this.accuracyM &&
          other.speedMps == this.speedMps &&
          other.headingDeg == this.headingDeg &&
          other.altitudeM == this.altitudeM);
}

class TripPointsCompanion extends UpdateCompanion<TripPointRow> {
  final Value<String> tripId;
  final Value<int> ts;
  final Value<double> lat;
  final Value<double> lon;
  final Value<double?> accuracyM;
  final Value<double?> speedMps;
  final Value<double?> headingDeg;
  final Value<double?> altitudeM;
  final Value<int> rowid;
  const TripPointsCompanion({
    this.tripId = const Value.absent(),
    this.ts = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.accuracyM = const Value.absent(),
    this.speedMps = const Value.absent(),
    this.headingDeg = const Value.absent(),
    this.altitudeM = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TripPointsCompanion.insert({
    required String tripId,
    required int ts,
    required double lat,
    required double lon,
    this.accuracyM = const Value.absent(),
    this.speedMps = const Value.absent(),
    this.headingDeg = const Value.absent(),
    this.altitudeM = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : tripId = Value(tripId),
       ts = Value(ts),
       lat = Value(lat),
       lon = Value(lon);
  static Insertable<TripPointRow> custom({
    Expression<String>? tripId,
    Expression<int>? ts,
    Expression<double>? lat,
    Expression<double>? lon,
    Expression<double>? accuracyM,
    Expression<double>? speedMps,
    Expression<double>? headingDeg,
    Expression<double>? altitudeM,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (tripId != null) 'trip_id': tripId,
      if (ts != null) 'ts': ts,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (accuracyM != null) 'accuracy_m': accuracyM,
      if (speedMps != null) 'speed_mps': speedMps,
      if (headingDeg != null) 'heading_deg': headingDeg,
      if (altitudeM != null) 'altitude_m': altitudeM,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TripPointsCompanion copyWith({
    Value<String>? tripId,
    Value<int>? ts,
    Value<double>? lat,
    Value<double>? lon,
    Value<double?>? accuracyM,
    Value<double?>? speedMps,
    Value<double?>? headingDeg,
    Value<double?>? altitudeM,
    Value<int>? rowid,
  }) {
    return TripPointsCompanion(
      tripId: tripId ?? this.tripId,
      ts: ts ?? this.ts,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      accuracyM: accuracyM ?? this.accuracyM,
      speedMps: speedMps ?? this.speedMps,
      headingDeg: headingDeg ?? this.headingDeg,
      altitudeM: altitudeM ?? this.altitudeM,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tripId.present) {
      map['trip_id'] = Variable<String>(tripId.value);
    }
    if (ts.present) {
      map['ts'] = Variable<int>(ts.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<double>(lon.value);
    }
    if (accuracyM.present) {
      map['accuracy_m'] = Variable<double>(accuracyM.value);
    }
    if (speedMps.present) {
      map['speed_mps'] = Variable<double>(speedMps.value);
    }
    if (headingDeg.present) {
      map['heading_deg'] = Variable<double>(headingDeg.value);
    }
    if (altitudeM.present) {
      map['altitude_m'] = Variable<double>(altitudeM.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TripPointsCompanion(')
          ..write('tripId: $tripId, ')
          ..write('ts: $ts, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('accuracyM: $accuracyM, ')
          ..write('speedMps: $speedMps, ')
          ..write('headingDeg: $headingDeg, ')
          ..write('altitudeM: $altitudeM, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TripsTable trips = $TripsTable(this);
  late final $TripPointsTable tripPoints = $TripPointsTable(this);
  late final Index tripPointsTripTs = Index(
    'trip_points_trip_ts',
    'CREATE INDEX trip_points_trip_ts ON trip_points (trip_id, ts)',
  );
  late final TripsDao tripsDao = TripsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    trips,
    tripPoints,
    tripPointsTripTs,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'trips',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('trip_points', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$TripsTableCreateCompanionBuilder = TripsCompanion Function({
  required String id,
  required int startedAt,
  Value<int?> endedAt,
  required TripStatus status,
  Value<MatchStatus?> matchStatus,
  Value<double> distanceM,
  Value<int> durationS,
  Value<int> movingS,
  Value<double?> avgSpeedMps,
  Value<double?> maxSpeedMps,
  Value<double?> startLat,
  Value<double?> startLon,
  Value<double?> endLat,
  Value<double?> endLon,
  Value<String?> startPlace,
  Value<String?> endPlace,
  Value<String?> rawPolyline6,
  Value<String?> matchedPolyline6,
  required int createdAt,
  Value<int> rowid,
});
typedef $$TripsTableUpdateCompanionBuilder = TripsCompanion Function({
  Value<String> id,
  Value<int> startedAt,
  Value<int?> endedAt,
  Value<TripStatus> status,
  Value<MatchStatus?> matchStatus,
  Value<double> distanceM,
  Value<int> durationS,
  Value<int> movingS,
  Value<double?> avgSpeedMps,
  Value<double?> maxSpeedMps,
  Value<double?> startLat,
  Value<double?> startLon,
  Value<double?> endLat,
  Value<double?> endLon,
  Value<String?> startPlace,
  Value<String?> endPlace,
  Value<String?> rawPolyline6,
  Value<String?> matchedPolyline6,
  Value<int> createdAt,
  Value<int> rowid,
});

final class $$TripsTableReferences
    extends BaseReferences<_$AppDatabase, $TripsTable, TripRow> {
  $$TripsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TripPointsTable, List<TripPointRow>>
  _tripPointsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tripPoints,
    aliasName: 'trips__id__trip_points__trip_id',
  );

  $$TripPointsTableProcessedTableManager get tripPointsRefs {
    final manager = $$TripPointsTableTableManager(
      $_db,
      $_db.tripPoints,
    ).filter((f) => f.tripId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tripPointsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TripsTableFilterComposer extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TripStatus, TripStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<MatchStatus?, MatchStatus, String>
  get matchStatus => $composableBuilder(
    column: $table.matchStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get distanceM => $composableBuilder(
    column: $table.distanceM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationS => $composableBuilder(
    column: $table.durationS,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get movingS => $composableBuilder(
    column: $table.movingS,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgSpeedMps => $composableBuilder(
    column: $table.avgSpeedMps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxSpeedMps => $composableBuilder(
    column: $table.maxSpeedMps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get startLat => $composableBuilder(
    column: $table.startLat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get startLon => $composableBuilder(
    column: $table.startLon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get endLat => $composableBuilder(
    column: $table.endLat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get endLon => $composableBuilder(
    column: $table.endLon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startPlace => $composableBuilder(
    column: $table.startPlace,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endPlace => $composableBuilder(
    column: $table.endPlace,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawPolyline6 => $composableBuilder(
    column: $table.rawPolyline6,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matchedPolyline6 => $composableBuilder(
    column: $table.matchedPolyline6,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> tripPointsRefs(
    Expression<bool> Function($$TripPointsTableFilterComposer f) f,
  ) {
    final $$TripPointsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tripPoints,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripPointsTableFilterComposer(
            $db: $db,
            $table: $db.tripPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TripsTableOrderingComposer
    extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matchStatus => $composableBuilder(
    column: $table.matchStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanceM => $composableBuilder(
    column: $table.distanceM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationS => $composableBuilder(
    column: $table.durationS,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get movingS => $composableBuilder(
    column: $table.movingS,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgSpeedMps => $composableBuilder(
    column: $table.avgSpeedMps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxSpeedMps => $composableBuilder(
    column: $table.maxSpeedMps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get startLat => $composableBuilder(
    column: $table.startLat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get startLon => $composableBuilder(
    column: $table.startLon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get endLat => $composableBuilder(
    column: $table.endLat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get endLon => $composableBuilder(
    column: $table.endLon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startPlace => $composableBuilder(
    column: $table.startPlace,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endPlace => $composableBuilder(
    column: $table.endPlace,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawPolyline6 => $composableBuilder(
    column: $table.rawPolyline6,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matchedPolyline6 => $composableBuilder(
    column: $table.matchedPolyline6,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TripsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<int> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TripStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MatchStatus?, String> get matchStatus =>
      $composableBuilder(
        column: $table.matchStatus,
        builder: (column) => column,
      );

  GeneratedColumn<double> get distanceM =>
      $composableBuilder(column: $table.distanceM, builder: (column) => column);

  GeneratedColumn<int> get durationS =>
      $composableBuilder(column: $table.durationS, builder: (column) => column);

  GeneratedColumn<int> get movingS =>
      $composableBuilder(column: $table.movingS, builder: (column) => column);

  GeneratedColumn<double> get avgSpeedMps => $composableBuilder(
    column: $table.avgSpeedMps,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxSpeedMps => $composableBuilder(
    column: $table.maxSpeedMps,
    builder: (column) => column,
  );

  GeneratedColumn<double> get startLat =>
      $composableBuilder(column: $table.startLat, builder: (column) => column);

  GeneratedColumn<double> get startLon =>
      $composableBuilder(column: $table.startLon, builder: (column) => column);

  GeneratedColumn<double> get endLat =>
      $composableBuilder(column: $table.endLat, builder: (column) => column);

  GeneratedColumn<double> get endLon =>
      $composableBuilder(column: $table.endLon, builder: (column) => column);

  GeneratedColumn<String> get startPlace => $composableBuilder(
    column: $table.startPlace,
    builder: (column) => column,
  );

  GeneratedColumn<String> get endPlace =>
      $composableBuilder(column: $table.endPlace, builder: (column) => column);

  GeneratedColumn<String> get rawPolyline6 => $composableBuilder(
    column: $table.rawPolyline6,
    builder: (column) => column,
  );

  GeneratedColumn<String> get matchedPolyline6 => $composableBuilder(
    column: $table.matchedPolyline6,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> tripPointsRefs<T extends Object>(
    Expression<T> Function($$TripPointsTableAnnotationComposer a) f,
  ) {
    final $$TripPointsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tripPoints,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripPointsTableAnnotationComposer(
            $db: $db,
            $table: $db.tripPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TripsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TripsTable,
          TripRow,
          $$TripsTableFilterComposer,
          $$TripsTableOrderingComposer,
          $$TripsTableAnnotationComposer,
          $$TripsTableCreateCompanionBuilder,
          $$TripsTableUpdateCompanionBuilder,
          (TripRow, $$TripsTableReferences),
          TripRow,
          PrefetchHooks Function({bool tripPointsRefs})
        > {
  $$TripsTableTableManager(_$AppDatabase db, $TripsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TripsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TripsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TripsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> startedAt = const Value.absent(),
                Value<int?> endedAt = const Value.absent(),
                Value<TripStatus> status = const Value.absent(),
                Value<MatchStatus?> matchStatus = const Value.absent(),
                Value<double> distanceM = const Value.absent(),
                Value<int> durationS = const Value.absent(),
                Value<int> movingS = const Value.absent(),
                Value<double?> avgSpeedMps = const Value.absent(),
                Value<double?> maxSpeedMps = const Value.absent(),
                Value<double?> startLat = const Value.absent(),
                Value<double?> startLon = const Value.absent(),
                Value<double?> endLat = const Value.absent(),
                Value<double?> endLon = const Value.absent(),
                Value<String?> startPlace = const Value.absent(),
                Value<String?> endPlace = const Value.absent(),
                Value<String?> rawPolyline6 = const Value.absent(),
                Value<String?> matchedPolyline6 = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TripsCompanion(
                id: id,
                startedAt: startedAt,
                endedAt: endedAt,
                status: status,
                matchStatus: matchStatus,
                distanceM: distanceM,
                durationS: durationS,
                movingS: movingS,
                avgSpeedMps: avgSpeedMps,
                maxSpeedMps: maxSpeedMps,
                startLat: startLat,
                startLon: startLon,
                endLat: endLat,
                endLon: endLon,
                startPlace: startPlace,
                endPlace: endPlace,
                rawPolyline6: rawPolyline6,
                matchedPolyline6: matchedPolyline6,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int startedAt,
                Value<int?> endedAt = const Value.absent(),
                required TripStatus status,
                Value<MatchStatus?> matchStatus = const Value.absent(),
                Value<double> distanceM = const Value.absent(),
                Value<int> durationS = const Value.absent(),
                Value<int> movingS = const Value.absent(),
                Value<double?> avgSpeedMps = const Value.absent(),
                Value<double?> maxSpeedMps = const Value.absent(),
                Value<double?> startLat = const Value.absent(),
                Value<double?> startLon = const Value.absent(),
                Value<double?> endLat = const Value.absent(),
                Value<double?> endLon = const Value.absent(),
                Value<String?> startPlace = const Value.absent(),
                Value<String?> endPlace = const Value.absent(),
                Value<String?> rawPolyline6 = const Value.absent(),
                Value<String?> matchedPolyline6 = const Value.absent(),
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => TripsCompanion.insert(
                id: id,
                startedAt: startedAt,
                endedAt: endedAt,
                status: status,
                matchStatus: matchStatus,
                distanceM: distanceM,
                durationS: durationS,
                movingS: movingS,
                avgSpeedMps: avgSpeedMps,
                maxSpeedMps: maxSpeedMps,
                startLat: startLat,
                startLon: startLon,
                endLat: endLat,
                endLon: endLon,
                startPlace: startPlace,
                endPlace: endPlace,
                rawPolyline6: rawPolyline6,
                matchedPolyline6: matchedPolyline6,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TripsTable, TripRow>(table),
                  $$TripsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tripPointsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (tripPointsRefs) db.tripPoints],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tripPointsRefs)
                    await $_getPrefetchedData<
                      TripRow,
                      $TripsTable,
                      TripPointRow
                    >(
                      currentTable: table,
                      referencedTable: $$TripsTableReferences
                          ._tripPointsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TripsTableReferences(db, table, p0).tripPointsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.tripId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TripsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TripsTable,
      TripRow,
      $$TripsTableFilterComposer,
      $$TripsTableOrderingComposer,
      $$TripsTableAnnotationComposer,
      $$TripsTableCreateCompanionBuilder,
      $$TripsTableUpdateCompanionBuilder,
      (TripRow, $$TripsTableReferences),
      TripRow,
      PrefetchHooks Function({bool tripPointsRefs})
    >;
typedef $$TripPointsTableCreateCompanionBuilder = TripPointsCompanion Function({
  required String tripId,
  required int ts,
  required double lat,
  required double lon,
  Value<double?> accuracyM,
  Value<double?> speedMps,
  Value<double?> headingDeg,
  Value<double?> altitudeM,
  Value<int> rowid,
});
typedef $$TripPointsTableUpdateCompanionBuilder = TripPointsCompanion Function({
  Value<String> tripId,
  Value<int> ts,
  Value<double> lat,
  Value<double> lon,
  Value<double?> accuracyM,
  Value<double?> speedMps,
  Value<double?> headingDeg,
  Value<double?> altitudeM,
  Value<int> rowid,
});

final class $$TripPointsTableReferences
    extends BaseReferences<_$AppDatabase, $TripPointsTable, TripPointRow> {
  $$TripPointsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TripsTable _tripIdTable(_$AppDatabase db) =>
      db.trips.createAlias('trip_points__trip_id__trips__id');

  $$TripsTableProcessedTableManager get tripId {
    final $_column = $_itemColumn<String>('trip_id')!;

    final manager = $$TripsTableTableManager(
      $_db,
      $_db.trips,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tripIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TripPointsTableFilterComposer
    extends Composer<_$AppDatabase, $TripPointsTable> {
  $$TripPointsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get ts => $composableBuilder(
    column: $table.ts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyM => $composableBuilder(
    column: $table.accuracyM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get speedMps => $composableBuilder(
    column: $table.speedMps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get headingDeg => $composableBuilder(
    column: $table.headingDeg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get altitudeM => $composableBuilder(
    column: $table.altitudeM,
    builder: (column) => ColumnFilters(column),
  );

  $$TripsTableFilterComposer get tripId {
    final $$TripsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableFilterComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TripPointsTableOrderingComposer
    extends Composer<_$AppDatabase, $TripPointsTable> {
  $$TripPointsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get ts => $composableBuilder(
    column: $table.ts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyM => $composableBuilder(
    column: $table.accuracyM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get speedMps => $composableBuilder(
    column: $table.speedMps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get headingDeg => $composableBuilder(
    column: $table.headingDeg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get altitudeM => $composableBuilder(
    column: $table.altitudeM,
    builder: (column) => ColumnOrderings(column),
  );

  $$TripsTableOrderingComposer get tripId {
    final $$TripsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableOrderingComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TripPointsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TripPointsTable> {
  $$TripPointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get ts =>
      $composableBuilder(column: $table.ts, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lon =>
      $composableBuilder(column: $table.lon, builder: (column) => column);

  GeneratedColumn<double> get accuracyM =>
      $composableBuilder(column: $table.accuracyM, builder: (column) => column);

  GeneratedColumn<double> get speedMps =>
      $composableBuilder(column: $table.speedMps, builder: (column) => column);

  GeneratedColumn<double> get headingDeg => $composableBuilder(
    column: $table.headingDeg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get altitudeM =>
      $composableBuilder(column: $table.altitudeM, builder: (column) => column);

  $$TripsTableAnnotationComposer get tripId {
    final $$TripsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableAnnotationComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TripPointsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TripPointsTable,
          TripPointRow,
          $$TripPointsTableFilterComposer,
          $$TripPointsTableOrderingComposer,
          $$TripPointsTableAnnotationComposer,
          $$TripPointsTableCreateCompanionBuilder,
          $$TripPointsTableUpdateCompanionBuilder,
          (TripPointRow, $$TripPointsTableReferences),
          TripPointRow,
          PrefetchHooks Function({bool tripId})
        > {
  $$TripPointsTableTableManager(_$AppDatabase db, $TripPointsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TripPointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TripPointsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TripPointsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> tripId = const Value.absent(),
                Value<int> ts = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> lon = const Value.absent(),
                Value<double?> accuracyM = const Value.absent(),
                Value<double?> speedMps = const Value.absent(),
                Value<double?> headingDeg = const Value.absent(),
                Value<double?> altitudeM = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TripPointsCompanion(
                tripId: tripId,
                ts: ts,
                lat: lat,
                lon: lon,
                accuracyM: accuracyM,
                speedMps: speedMps,
                headingDeg: headingDeg,
                altitudeM: altitudeM,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String tripId,
                required int ts,
                required double lat,
                required double lon,
                Value<double?> accuracyM = const Value.absent(),
                Value<double?> speedMps = const Value.absent(),
                Value<double?> headingDeg = const Value.absent(),
                Value<double?> altitudeM = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TripPointsCompanion.insert(
                tripId: tripId,
                ts: ts,
                lat: lat,
                lon: lon,
                accuracyM: accuracyM,
                speedMps: speedMps,
                headingDeg: headingDeg,
                altitudeM: altitudeM,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TripPointsTable, TripPointRow>(table),
                  $$TripPointsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tripId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tripId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.tripId,
                        referencedTable: $$TripPointsTableReferences
                            ._tripIdTable(db),
                        referencedColumn: $$TripPointsTableReferences
                            ._tripIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TripPointsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TripPointsTable,
      TripPointRow,
      $$TripPointsTableFilterComposer,
      $$TripPointsTableOrderingComposer,
      $$TripPointsTableAnnotationComposer,
      $$TripPointsTableCreateCompanionBuilder,
      $$TripPointsTableUpdateCompanionBuilder,
      (TripPointRow, $$TripPointsTableReferences),
      TripPointRow,
      PrefetchHooks Function({bool tripId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TripsTableTableManager get trips =>
      $$TripsTableTableManager(_db, _db.trips);
  $$TripPointsTableTableManager get tripPoints =>
      $$TripPointsTableTableManager(_db, _db.tripPoints);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'365ef3f215d780c29a21b6328f0b547a8363c6a6';
