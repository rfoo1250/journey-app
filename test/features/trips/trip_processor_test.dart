import 'package:flutter_test/flutter_test.dart';
import 'package:journey/core/db/database.dart';
import 'package:journey/core/geo/fix.dart';
import 'package:journey/core/geo/polyline6.dart';
import 'package:journey/core/result.dart';
import 'package:journey/core/services/valhalla_client.dart';
import 'package:journey/features/trips/data/trip_repository.dart';
import 'package:journey/features/trips/domain/trip.dart';
import 'package:journey/features/trips/domain/trip_processor.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

import '../../core/geo/fixtures.dart';

class MockTripRepository extends Mock implements TripRepository;

class MockValhallaClient extends Mock implements ValhallaClient;

TripPointRow row(Fix f) => TripPointRow(
  tripId: 't1',
  ts: f.ts.millisecondsSinceEpoch,
  lat: f.lat,
  lon: f.lon,
  accuracyM: f.accuracyM,
  speedMps: f.speedMps,
  headingDeg: f.headingDeg,
  altitudeM: f.altitudeM,
);

Trip trip({MatchStatus status = MatchStatus.unmatched}) => Trip(
  id: 't1',
  startedAt: t0,
  status: TripStatus.complete,
  matchStatus: status,
  createdAt: t0,
);

final List<({double lat, double lon})> matchedPts = [
  (lat: 3.1578, lon: 101.7117),
  (lat: 3.1578, lon: 101.7150),
  (lat: 3.1578, lon: 101.7182),
];

void main() {
  late MockTripRepository trips;
  late MockValhallaClient valhalla;
  late TripProcessor processor;
  Map<Symbol, dynamic>? saved;

  setUpAll(() {
    Logger.level = Level.off;
    registerFallbackValue(MatchStatus.unmatched);
  });

  setUp(() {
    trips = MockTripRepository();
    valhalla = MockValhallaClient();
    processor = TripProcessor(trips: trips, valhalla: valhalla);
    saved = null;
    when(() => trips.getById('t1')).thenAnswer((_) async => trip());
    when(
      () => trips.applyProcessing(
        id: any<String>(named: 'id'),
        matchStatus: any<MatchStatus>(named: 'matchStatus'),
        distanceM: any<double>(named: 'distanceM'),
        durationS: any<int>(named: 'durationS'),
        movingS: any<int>(named: 'movingS'),
        avgSpeedMps: any<double?>(named: 'avgSpeedMps'),
        maxSpeedMps: any<double?>(named: 'maxSpeedMps'),
        rawPolyline6: any<String>(named: 'rawPolyline6'),
        matchedPolyline6: any<String?>(named: 'matchedPolyline6'),
        start: any<({double lat, double lon})?>(named: 'start'),
        end: any<({double lat, double lon})?>(named: 'end'),
      ),
    ).thenAnswer((inv) async => saved = inv.namedArguments);
  });

  /// Named args of the last applyProcessing call (order-independent).
  Map<Symbol, dynamic> persisted() {
    verify(
      () => trips.applyProcessing(
        id: 't1',
        matchStatus: captureAny<MatchStatus>(named: 'matchStatus'),
        distanceM: captureAny<double>(named: 'distanceM'),
        durationS: captureAny<int>(named: 'durationS'),
        movingS: captureAny<int>(named: 'movingS'),
        avgSpeedMps: captureAny<double?>(named: 'avgSpeedMps'),
        maxSpeedMps: captureAny<double?>(named: 'maxSpeedMps'),
        rawPolyline6: captureAny<String>(named: 'rawPolyline6'),
        matchedPolyline6: captureAny<String?>(named: 'matchedPolyline6'),
        start: captureAny<({double lat, double lon})?>(named: 'start'),
        end: captureAny<({double lat, double lon})?>(named: 'end'),
      ),
    ).called(1);
    return saved!;
  }

  test('matched: stores Valhalla geometry, distance along it, stats', () async {
    final drive = straightDrive(); // 720 m east at 12 m/s
    when(() => trips.points('t1'))
        .thenAnswer((_) async => drive.map(row).toList());
    when(
      () => valhalla.traceRoute(
        any<List<Fix>>(),
        gpsAccuracyM: any<double>(named: 'gpsAccuracyM'),
      ),
    ).thenAnswer(
      (_) async => Result.ok(
        MatchedRoute(
          polyline6: Polyline6.encode(matchedPts),
          points: matchedPts,
          lengthM: 723,
        ),
      ),
    );

    final r = await processor.process('t1');
    expect(r.isOk, isTrue);

    final p = persisted();
    expect(p[#matchStatus], MatchStatus.matched);
    expect(p[#distanceM]! as double, closeTo(722, 5)); // along matched line
    expect(p[#durationS], 60); // durationS: last − first
    expect(p[#movingS], 60); // movingS: all fixes at 12 m/s
    expect(
      p[#avgSpeedMps]! as double,
      closeTo(12, 0.2),
    ); // avg = distance / moving
    expect(p[#maxSpeedMps], 12); // max speed
    expect(p[#rawPolyline6], isNotEmpty); // simplified raw polyline
    expect(p[#matchedPolyline6], Polyline6.encode(matchedPts));
    expect(p[#start], drive.first.point);

    // Shape sent is simplified: straight line → 2 points, median accuracy 5.
    final sent = verify(
      () => valhalla.traceRoute(
        captureAny<List<Fix>>(),
        gpsAccuracyM: captureAny<double>(named: 'gpsAccuracyM'),
      ),
    ).captured;
    expect(sent[0] as List<Fix>, hasLength(2));
    expect(sent[1], 5);
  });

  test('Valhalla unreachable → unmatched, distance along raw trace', () async {
    final drive = straightDrive();
    when(() => trips.points('t1'))
        .thenAnswer((_) async => drive.map(row).toList());
    when(
      () => valhalla.traceRoute(
        any<List<Fix>>(),
        gpsAccuracyM: any<double>(named: 'gpsAccuracyM'),
      ),
    ).thenAnswer((_) async => const Result.err(NetworkError('down')));

    await processor.process('t1');

    final p = persisted();
    expect(p[#matchStatus], MatchStatus.unmatched);
    expect(p[#distanceM]! as double, closeTo(720, 3));
    expect(p[#matchedPolyline6], isNull);
  });

  test('bad Valhalla response → failed (no retry)', () async {
    final drive = straightDrive(seconds: 10);
    when(() => trips.points('t1'))
        .thenAnswer((_) async => drive.map(row).toList());
    when(
      () => valhalla.traceRoute(
        any<List<Fix>>(),
        gpsAccuracyM: any<double>(named: 'gpsAccuracyM'),
      ),
    ).thenAnswer((_) async => const Result.err(ParseError('garbage')));

    await processor.process('t1');
    expect(persisted()[#matchStatus], MatchStatus.failed);
  });

  test('too few usable fixes → failed without calling Valhalla', () async {
    // One live fix plus a cached fix from before the session start.
    when(() => trips.points('t1')).thenAnswer(
      (_) async => [row(fix(-5, 3.1, 101.6)), row(fix(1, 3.1, 101.6))],
    );

    await processor.process('t1');

    verifyNever(
      () => valhalla.traceRoute(
        any<List<Fix>>(),
        gpsAccuracyM: any<double>(named: 'gpsAccuracyM'),
      ),
    );
    final p = persisted();
    expect(p[#matchStatus], MatchStatus.failed);
    expect(p[#distanceM], 0);
    expect(p[#durationS], 0);
  });

  test('stationary fixes count no moving time and null avg speed', () async {
    final still = [
      for (var s = 0; s < 30; s++) fix(s, 3.1, 101.6, speed: 0, heading: -1),
    ];
    when(() => trips.points('t1'))
        .thenAnswer((_) async => still.map(row).toList());
    when(
      () => valhalla.traceRoute(
        any<List<Fix>>(),
        gpsAccuracyM: any<double>(named: 'gpsAccuracyM'),
      ),
    ).thenAnswer((_) async => const Result.err(NetworkError('down')));

    await processor.process('t1');
    final p = persisted();
    expect(p[#movingS], 0);
    expect(p[#avgSpeedMps], isNull);
    expect(p[#maxSpeedMps], 0);
  });

  test('unknown trip → InvalidInputError', () async {
    when(() => trips.getById('nope')).thenAnswer((_) async => null);
    final r = await processor.process('nope');
    expect(r.errorOrNull, isA<InvalidInputError>());
  });

  test(
    'retryUnmatched processes each pending trip and counts matches',
    () async {
      when(trips.unmatched).thenAnswer((_) async => [trip(), trip()]);
      when(
        () => trips.points('t1'),
      ).thenAnswer((_) async => straightDrive(seconds: 20).map(row).toList());
      var call = 0;
      when(
        () => valhalla.traceRoute(
          any<List<Fix>>(),
          gpsAccuracyM: any<double>(named: 'gpsAccuracyM'),
        ),
      ).thenAnswer((_) async {
        call++;
        return call == 1
            ? Result.ok(
                MatchedRoute(
                  polyline6: Polyline6.encode(matchedPts),
                  points: matchedPts,
                  lengthM: 700,
                ),
              )
            : const Result.err(NetworkError('down'));
      });
      // Reload after processing reports the persisted status.
      var reloads = 0;
      when(() => trips.getById('t1')).thenAnswer((_) async {
        reloads++;
        // getById is called before and after each process(): 1,2 for the
        // first trip, 3,4 for the second. Report matched only on reload #2.
        return trip(
          status: reloads == 2 ? MatchStatus.matched : MatchStatus.unmatched,
        );
      });

      expect(await processor.retryUnmatched(), 1);
    },
  );
}
