import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:journey/features/recording/data/location_repository.dart';
import 'package:journey/features/recording/domain/recording_controller.dart';
import 'package:journey/features/recording/domain/recording_state.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

class MockLocationRepository extends Mock implements LocationRepository;

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
  late MockLocationRepository repo;
  late StreamController<Position> fixes;
  late ProviderContainer container;
  late List<RecordingState> seen;

  RecordingController ctrl() =>
      container.read(recordingControllerProvider.notifier);
  RecordingState state() => container.read(recordingControllerProvider);

  setUp(() {
    repo = MockLocationRepository();
    fixes = StreamController<Position>();
    when(repo.ensurePermission).thenAnswer((_) async => LocationAccess.granted);
    when(repo.positions).thenAnswer((_) => fixes.stream);

    container = ProviderContainer.test(
      overrides: [locationRepositoryProvider.overrideWithValue(repo)],
    );
    seen = [];
    container.listen(
      recordingControllerProvider,
      (_, next) => seen.add(next),
      fireImmediately: true,
    );
  });

  setUpAll(() => Logger.level = Level.off);

  // close() only completes once a listener receives `done`; tests that never
  // subscribe would hang, so don't await it.
  tearDown(() => unawaited(fixes.close()));

  test('starts idle', () {
    expect(state(), const RecordingState.idle());
  });

  test(
    'start: idle → requestingPermission → recording, counts fixes',
    () async {
      await ctrl().start();
      expect(seen.map((s) => s.runtimeType), [
        RecordingIdle,
        RecordingRequestingPermission,
        RecordingActive,
      ]);

      fixes
        ..add(fix(1))
        ..add(fix(2));
      await Future<void>.delayed(Duration.zero);

      final s = state() as RecordingActive;
      expect(s.fixCount, 2);
      expect(s.lastFix, fix(2));
    },
  );

  test('start is ignored while already recording', () async {
    await ctrl().start();
    await ctrl().start();
    verify(repo.ensurePermission).called(1);
  });

  for (final (access, kind) in [
    (LocationAccess.denied, RecordingErrorKind.permissionDenied),
    (LocationAccess.deniedForever, RecordingErrorKind.permissionDeniedForever),
    (
      LocationAccess.serviceDisabled,
      RecordingErrorKind.locationServiceDisabled,
    ),
  ]) {
    test('start with $access → error($kind), no stream', () async {
      when(repo.ensurePermission).thenAnswer((_) async => access);
      await ctrl().start();
      expect(state(), RecordingState.error(kind: kind));
      verifyNever(repo.positions);

      ctrl().dismissError();
      expect(state(), const RecordingState.idle());
    });
  }

  test('pause ignores fixes, resume keeps count', () async {
    await ctrl().start();
    fixes.add(fix(1));
    await Future<void>.delayed(Duration.zero);

    ctrl().pause();
    expect(state(), isA<RecordingPaused>());
    fixes.add(fix(2));
    await Future<void>.delayed(Duration.zero);
    expect((state() as RecordingPaused).fixCount, 1);

    ctrl().resume();
    fixes.add(fix(3));
    await Future<void>.delayed(Duration.zero);
    final s = state() as RecordingActive;
    expect(s.fixCount, 2);
    expect(s.lastFix, fix(3));
  });

  test('stop: recording → processing → idle and cancels stream', () async {
    await ctrl().start();
    expect(fixes.hasListener, isTrue);

    await ctrl().stop();
    expect(seen.whereType<RecordingProcessing>(), hasLength(1));
    expect(state(), const RecordingState.idle());
    expect(fixes.hasListener, isFalse);
  });

  test('stop from paused also works', () async {
    await ctrl().start();
    ctrl().pause();
    await ctrl().stop();
    expect(state(), const RecordingState.idle());
  });

  test('stop while idle is a no-op', () async {
    await ctrl().stop();
    expect(seen, [const RecordingState.idle()]);
  });

  test('stream error → error(streamFailure) and cancels', () async {
    await ctrl().start();
    fixes.addError(Exception('gps died'));
    await Future<void>.delayed(Duration.zero);

    final s = state() as RecordingError;
    expect(s.kind, RecordingErrorKind.streamFailure);
    expect(s.message, contains('gps died'));
    expect(fixes.hasListener, isFalse);
  });
}
