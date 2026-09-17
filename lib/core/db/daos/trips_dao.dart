import 'package:drift/drift.dart';
import 'package:journey/core/db/database.dart';
import 'package:journey/core/db/tables.dart';

part 'trips_dao.g.dart';

@DriftAccessor(tables: [Trips, TripPoints])
class TripsDao extends DatabaseAccessor<AppDatabase> with _$TripsDaoMixin {
  new(super.attachedDatabase);

  /// Newest first (PLAN.md §2 goal 4).
  Stream<List<TripRow>> watchAll() =>
      (select(trips)..orderBy([(t) => OrderingTerm.desc(t.startedAt)])).watch();

  Stream<TripRow?> watchById(String id) =>
      (select(trips)..where((t) => t.id.equals(id))).watchSingleOrNull();

  Future<List<TripRow>> byMatchStatus(MatchStatus status) =>
      (select(trips)
            ..where((t) => t.matchStatus.equalsValue(status))
            ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
          .get();

  Future<TripRow?> getById(String id) =>
      (select(trips)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> upsert(TripsCompanion trip) =>
      into(trips).insertOnConflictUpdate(trip);

  Future<int> deleteById(String id) =>
      (delete(trips)..where((t) => t.id.equals(id))).go();

  Future<void> addPoints(List<TripPointsCompanion> points) =>
      batch((b) => b.insertAll(tripPoints, points));

  Future<List<TripPointRow>> pointsFor(String tripId) =>
      (select(tripPoints)
            ..where((p) => p.tripId.equals(tripId))
            ..orderBy([(p) => OrderingTerm.asc(p.ts)]))
          .get();
}
