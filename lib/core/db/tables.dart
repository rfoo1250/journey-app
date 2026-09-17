import 'package:drift/drift.dart';

/// Lifecycle of a trip row (PLAN.md §4.3).
enum TripStatus { inProgress, complete }

/// Result of map matching for a trip (PLAN.md §4.3).
enum MatchStatus { matched, unmatched, failed }

@DataClassName('TripRow')
class Trips extends Table {
  TextColumn get id => text()();
  IntColumn get startedAt => integer()();
  IntColumn get endedAt => integer().nullable()();
  TextColumn get status => textEnum<TripStatus>()();
  TextColumn get matchStatus => textEnum<MatchStatus>().nullable()();
  RealColumn get distanceM => real().withDefault(const Constant(0))();
  IntColumn get durationS => integer().withDefault(const Constant(0))();
  IntColumn get movingS => integer().withDefault(const Constant(0))();
  RealColumn get avgSpeedMps => real().nullable()();
  RealColumn get maxSpeedMps => real().nullable()();
  RealColumn get startLat => real().nullable()();
  RealColumn get startLon => real().nullable()();
  RealColumn get endLat => real().nullable()();
  RealColumn get endLon => real().nullable()();
  TextColumn get startPlace => text().nullable()();
  TextColumn get endPlace => text().nullable()();
  TextColumn get rawPolyline6 => text().nullable()();
  TextColumn get matchedPolyline6 => text().nullable()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(name: 'trip_points_trip_ts', columns: {#tripId, #ts})
@DataClassName('TripPointRow')
class TripPoints extends Table {
  TextColumn get tripId =>
      text().references(Trips, #id, onDelete: KeyAction.cascade)();
  IntColumn get ts => integer()();
  RealColumn get lat => real()();
  RealColumn get lon => real()();
  RealColumn get accuracyM => real().nullable()();
  RealColumn get speedMps => real().nullable()();
  RealColumn get headingDeg => real().nullable()();
  RealColumn get altitudeM => real().nullable()();
}
