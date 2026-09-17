import 'package:journey/core/db/database.dart';
import 'package:journey/features/trips/domain/trip.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'trip_repository.g.dart';

/// Façade over the drift `TripsDao`. Maps rows to the domain [Trip] so
/// other features never import drift.
class TripRepository {
  new(this._db);

  final AppDatabase _db;

  Stream<List<Trip>> watchAll() =>
      _db.tripsDao.watchAll().map((rows) => rows.map(_toDomain).toList());

  Stream<Trip?> watchById(String id) =>
      _db.tripsDao.watchById(id).map((r) => r == null ? null : _toDomain(r));

  Future<int> delete(String id) => _db.tripsDao.deleteById(id);

  static Trip _toDomain(TripRow r) => Trip(
    id: r.id,
    startedAt: _utc(r.startedAt),
    endedAt: r.endedAt == null ? null : _utc(r.endedAt!),
    status: r.status,
    matchStatus: r.matchStatus,
    distanceM: r.distanceM,
    durationS: r.durationS,
    movingS: r.movingS,
    avgSpeedMps: r.avgSpeedMps,
    maxSpeedMps: r.maxSpeedMps,
    startLat: r.startLat,
    startLon: r.startLon,
    endLat: r.endLat,
    endLon: r.endLon,
    startPlace: r.startPlace,
    endPlace: r.endPlace,
    rawPolyline6: r.rawPolyline6,
    matchedPolyline6: r.matchedPolyline6,
    createdAt: _utc(r.createdAt),
  );

  static DateTime _utc(int epochMs) =>
      DateTime.fromMillisecondsSinceEpoch(epochMs, isUtc: true);
}

@riverpod
TripRepository tripRepository(Ref ref) =>
    TripRepository(ref.watch(appDatabaseProvider));

@riverpod
Stream<List<Trip>> tripList(Ref ref) =>
    ref.watch(tripRepositoryProvider).watchAll();
