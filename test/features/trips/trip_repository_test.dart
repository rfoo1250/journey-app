import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:journey/core/db/database.dart';
import 'package:journey/features/trips/data/trip_repository.dart';

Position fix(int s, double lat, double lon) => Position(
  latitude: lat,
  longitude: lon,
  timestamp: DateTime.utc(2026, 9, 17, 8, 0, s),
  accuracy: 5,
  altitude: 40,
  altitudeAccuracy: 0,
  heading: 90,
  headingAccuracy: 0,
  speed: 10,
  speedAccuracy: 0,
);

void main() {
  late AppDatabase db;
  late TripRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = TripRepository(db);
  });
  tearDown(() => db.close());

  test('createInProgress → visible in watchAll as in_progress', () async {
    await repo.createInProgress(
      id: 't1',
      startedAt: DateTime.utc(2026, 9, 17, 8),
    );
    final trips = await repo.watchAll().first;
    expect(trips.single.id, 't1');
    expect(trips.single.status, TripStatus.inProgress);
    expect(trips.single.endedAt, isNull);
  });

  test('appendPoints stores every field, ordered by ts', () async {
    await repo.createInProgress(
      id: 't1',
      startedAt: DateTime.utc(2026, 9, 17, 8),
    );
    await repo.appendPoints('t1', [fix(2, 3.2, 101.7), fix(1, 3.1, 101.6)]);

    final pts = await repo.points('t1');
    expect(pts.map((p) => p.lat), [3.1, 3.2]);
    expect(pts.first.accuracyM, 5);
    expect(pts.first.speedMps, 10);
    expect(pts.first.headingDeg, 90);
    expect(pts.first.altitudeM, 40);
  });

  test('finish completes the trip with stats and unmatched status', () async {
    final started = DateTime.utc(2026, 9, 17, 8);
    await repo.createInProgress(id: 't1', startedAt: started);
    await repo.finish(
      id: 't1',
      endedAt: started.add(const Duration(minutes: 12, seconds: 30)),
      // Cached first fix 5 s before Start must not distort the duration.
      firstFixAt: started.subtract(const Duration(seconds: 5)),
      lastFixAt: started.add(const Duration(minutes: 12, seconds: 25)),
      distanceM: 4321,
      rawPolyline6: 'abc',
      start: (lat: 3.1, lon: 101.6),
      end: (lat: 3.2, lon: 101.7),
    );

    final t = (await repo.watchById('t1').first)!;
    expect(t.status, TripStatus.complete);
    expect(t.matchStatus, MatchStatus.unmatched);
    expect(t.durationS, 750);
    expect(t.distanceM, 4321);
    expect(t.rawPolyline6, 'abc');
    expect((t.startLat, t.endLon), (3.1, 101.7));
    expect(t.matchedPolyline6, isNull);
  });

  test('finish on unknown id is a no-op', () async {
    await repo.finish(
      id: 'nope',
      endedAt: DateTime.utc(2026),
      distanceM: 0,
      rawPolyline6: '',
    );
    expect(await repo.watchAll().first, isEmpty);
  });
}
