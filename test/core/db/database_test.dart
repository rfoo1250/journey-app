import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journey/core/db/database.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  TripsCompanion trip(String id) => TripsCompanion.insert(
    id: id,
    startedAt: 1000,
    status: TripStatus.inProgress,
    createdAt: 1000,
  );

  test('watchAll emits newest first', () async {
    await db.tripsDao.upsert(trip('a'));
    await db.tripsDao.upsert(trip('b').copyWith(startedAt: const Value(2000)));

    final rows = await db.tripsDao.watchAll().first;
    expect(rows.map((r) => r.id), ['b', 'a']);
  });

  test('deleting a trip cascades to its points', () async {
    await db.tripsDao.upsert(trip('a'));
    await db.tripsDao.addPoints([
      TripPointsCompanion.insert(tripId: 'a', ts: 1, lat: 3.1, lon: 101.6),
      TripPointsCompanion.insert(tripId: 'a', ts: 2, lat: 3.2, lon: 101.7),
    ]);
    expect(await db.tripsDao.pointsFor('a'), hasLength(2));

    await db.tripsDao.deleteById('a');

    expect(await db.tripsDao.pointsFor('a'), isEmpty);
    expect(await db.tripsDao.getById('a'), isNull);
  });
}
