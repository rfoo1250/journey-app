import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:journey/features/recording/data/location_repository.dart';
import 'package:journey/features/recording/domain/recording_config.dart';
import 'package:journey/features/recording/domain/recording_controller.dart';
import 'package:journey/features/recording/domain/recording_state.dart';
import 'package:journey/features/trips/data/trip_repository.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

class MockLocationRepository extends Mock implements LocationRepository;

class MockTripRepository extends Mock implements TripRepository;

Position fix(int i) => Position(
  latitude: 3.1 + i * 0.001,
  longitude: 101.6,
  timestamp: DateTime.utc(2026, 9, 17, 0, 0, i),
  accuracy: 5,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: 90,
  headingAccuracy: 0,
  speed: 12,
  speedAccuracy: 0,
);

void main() {
  late MockLocationRepository location;
  late MockTripRepository trips;
  late StreamController<Position> fixes;
  late ProviderContainer container;
  late List<RecordingState> seen;

  RecordingController ctrl() =>
      container.read(recordingControllerProvider.notifier);
  RecordingState state() => container.read(recordingControllerProvider);
  Future<void> settle() => Future<void>.delayed(Duration.zero);

  setUpAll(() {
    Logger.level = Level.off;
    registerFallbackValue(DateTime.utc(2026));
  });

  setUp(() {
    location = MockLocationRepository();
    trips = MockTripRepository();
    fixes = StreamController<Position>();
    when(location.ensurePermission)
        .thenAnswer((_) async => LocationAccess.granted);
    when(location.positions).thenAnswer((_) => fixes.stream);
    when(
      () => trips.createInProgress(
        id: any<String>(named: 'id'),
        startedAt: any<DateTime>(named: 'startedAt'),
      ),
    ).thenAnswer((_) async {});
    when(() => trips.appendPoints(any<String>(), any<List<Position>>()))
        .thenAnswer((_) async {});
    when(
      () => trips.finish(
        id: any<String>(named: 'id'),
        endedAt: any<DateTime>(named: 'endedAt'),
        distanceM: any<double>(named: 'distanceM'),
        rawPolyline6: any<String>(named: 'rawPolyline6'),
        start: any<({double lat, double lon})?>(named: 'start'),
        end: any<({double lat, double lon})?>(named: 'end'),
      ),
    ).thenAnswer((_) async {});

    container = ProviderContainer.test(
      overrides: [
        locationRepositoryProvider.overrideWithValue(location),
        tripRepositoryProvider.overrideWithValue(trips),
        recordingConfigProvider.overrideWithValue(
          const RecordingConfig(
            flushEvery: 3,
            flushInterval: Duration(milliseconds: 50),
          ),
        ),
      ],
    );
    seen = [];
    container.listen(
      recordingControllerProvider,
      (_, next) => seen.add(next),
      fireImmediately: true,
    );
  });

  // close() only completes once a listener receives `done`; tests that never
  // subscribe would hang, so don't await it.
  tearDown(() => unawaited(fixes.close()));

  test('starts idle', () {
    expect(state(), const RecordingState.idle());
  });

  test(
    'start: idle → requestingPermission → recording; creates trip',
    () async {
      await ctrl().start();
      expect(seen.map((s) => s.runtimeType), [
        RecordingIdle,
        RecordingRequestingPermission,
        RecordingActive,
      ]);
      final s = state() as RecordingActive;
      verify(() => trips.createInProgress(id: s.tripId, startedAt: s.startedAt))
          .called(1);

      fixes
        ..add(fix(1))
        ..add(fix(2));
      await settle();

      final r = state() as RecordingActive;
      expect(r.fixCount, 2);
      expect(r.lastFix, fix(2));
      expect(r.trace, [(lat: 3.101, lon: 101.6), (lat: 3.102, lon: 101.6)]);
    },
  );

  test('start is ignored while already recording', () async {
    await ctrl().start();
    await ctrl().start();
    verify(location.ensurePermission).called(1);
  });

  for (final (access, kind) in [
    (LocationAccess.denied, RecordingErrorKind.permissionDenied),
    (LocationAccess.deniedForever, RecordingErrorKind.permissionDeniedForever),
    (
      LocationAccess.serviceDisabled,
      RecordingErrorKind.locationServiceDisabled,
    ),
  ]) {
    test('start with $access → error($kind), no trip, no stream', () async {
      when(location.ensurePermission).thenAnswer((_) async => access);
      await ctrl().start();
      expect(state(), RecordingState.error(kind: kind));
      verifyNever(location.positions);
      verifyNever(
        () => trips.createInProgress(
          id: any<String>(named: 'id'),
          startedAt: any<DateTime>(named: 'startedAt'),
        ),
      );

      ctrl().dismissError();
      expect(state(), const RecordingState.idle());
    });
  }

  test('flushes to trip_points every flushEvery fixes', () async {
    await ctrl().start();
    final id = (state() as RecordingActive).tripId;

    fixes
      ..add(fix(1))
      ..add(fix(2));
    await settle();
    verifyNever(() => trips.appendPoints(any<String>(), any<List<Position>>()));

    fixes.add(fix(3));
    await settle();
    final batch =
        verify(() => trips.appendPoints(id, captureAny<List<Position>>()))
                .captured
                .single
            as List<Position>;
    expect(batch, [fix(1), fix(2), fix(3)]);
  });

  test('flushes pending fixes on the interval timer', () async {
    await ctrl().start();
    final id = (state() as RecordingActive).tripId;

    fixes.add(fix(1));
    await settle();
    verifyNever(() => trips.appendPoints(any<String>(), any<List<Position>>()));

    await Future<void>.delayed(const Duration(milliseconds: 120));
    final batch =
        verify(() => trips.appendPoints(id, captureAny<List<Position>>()))
                .captured
                .single
            as List<Position>;
    expect(batch, [fix(1)]);

    // Nothing new → no empty flush.
    await Future<void>.delayed(const Duration(milliseconds: 120));
    verifyNever(() => trips.appendPoints(any<String>(), any<List<Position>>()));
  });

  test('pause ignores fixes, resume keeps count and trace', () async {
    await ctrl().start();
    fixes.add(fix(1));
    await settle();

    ctrl().pause();
    expect(state(), isA<RecordingPaused>());
    fixes.add(fix(2));
    await settle();
    expect((state() as RecordingPaused).fixCount, 1);

    ctrl().resume();
    fixes.add(fix(3));
    await settle();
    final s = state() as RecordingActive;
    expect(s.fixCount, 2);
    expect(s.trace, hasLength(2));
  });

  test(
    'stop: flushes remainder, finishes trip with raw stats → idle',
    () async {
      await ctrl().start();
      final id = (state() as RecordingActive).tripId;
      fixes
        ..add(fix(1))
        ..add(fix(2));
      await settle();

      await ctrl().stop();

      expect(seen.whereType<RecordingProcessing>(), hasLength(1));
      expect(state(), const RecordingState.idle());
      expect(fixes.hasListener, isFalse);

      final flushed =
          verify(() => trips.appendPoints(id, captureAny<List<Position>>()))
                  .captured
                  .single
              as List<Position>;
      expect(flushed, [fix(1), fix(2)]);

      final finish = verify(
        () => trips.finish(
          id: id,
          endedAt: captureAny<DateTime>(named: 'endedAt'),
          distanceM: captureAny<double>(named: 'distanceM'),
          rawPolyline6: captureAny<String>(named: 'rawPolyline6'),
          start: captureAny<({double lat, double lon})?>(named: 'start'),
          end: captureAny<({double lat, double lon})?>(named: 'end'),
        ),
      ).captured;
      expect(finish[0], fix(2).timestamp);
      expect(finish[1] as double, closeTo(111, 2)); // 0.001° lat ≈ 111 m
      expect(finish[2], isNotEmpty);
      expect(finish[3], (lat: 3.101, lon: 101.6));
      expect(finish[4], (lat: 3.102, lon: 101.6));
    },
  );

  test('stop from paused also works', () async {
    await ctrl().start();
    ctrl().pause();
    await ctrl().stop();
    expect(state(), const RecordingState.idle());
  });

  test('stop while idle is a no-op', () async {
    await ctrl().stop();
    expect(seen, [const RecordingState.idle()]);
    verifyNever(
      () => trips.finish(
        id: any<String>(named: 'id'),
        endedAt: any<DateTime>(named: 'endedAt'),
        distanceM: any<double>(named: 'distanceM'),
        rawPolyline6: any<String>(named: 'rawPolyline6'),
      ),
    );
  });

  test('stream error → error(streamFailure) and cancels', () async {
    await ctrl().start();
    fixes.addError(Exception('gps died'));
    await settle();

    final s = state() as RecordingError;
    expect(s.kind, RecordingErrorKind.streamFailure);
    expect(s.message, contains('gps died'));
    expect(fixes.hasListener, isFalse);
  });
}
