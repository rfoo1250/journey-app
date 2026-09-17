import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:journey/features/recording/data/location_repository.dart';
import 'package:journey/features/recording/presentation/record_screen.dart';
import 'package:journey/features/recording/presentation/widgets/live_map.dart';
import 'package:journey/features/trips/data/trip_repository.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

class MockLocationRepository extends Mock implements LocationRepository;

class MockTripRepository extends Mock implements TripRepository;

void main() {
  late MockLocationRepository repo;
  late MockTripRepository trips;
  StreamController<Position>? fixes;

  setUpAll(() {
    Logger.level = Level.off;
    registerFallbackValue(DateTime.utc(2026));
  });

  setUp(() {
    repo = MockLocationRepository();
    trips = MockTripRepository();
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
        firstFixAt: any<DateTime?>(named: 'firstFixAt'),
        lastFixAt: any<DateTime?>(named: 'lastFixAt'),
        distanceM: any<double>(named: 'distanceM'),
        rawPolyline6: any<String>(named: 'rawPolyline6'),
        start: any<({double lat, double lon})?>(named: 'start'),
        end: any<({double lat, double lon})?>(named: 'end'),
      ),
    ).thenAnswer((_) async {});
    // Created lazily so it lives in the widget test's fake-async zone;
    // otherwise cancel()/close() futures never complete under pump().
    when(repo.positions).thenAnswer((_) {
      fixes = StreamController<Position>();
      return fixes!.stream;
    });
    when(repo.openAppSettings).thenAnswer((_) async => true);
    when(repo.openLocationSettings).thenAnswer((_) async => true);
  });

  tearDown(() {
    // close() only completes once a listener receives `done`; don't await.
    unawaited(fixes?.close() ?? Future.value());
    fixes = null;
  });

  Widget app() => ProviderScope(
    overrides: [
      locationRepositoryProvider.overrideWithValue(repo),
      tripRepositoryProvider.overrideWithValue(trips),
      liveMapBuilderProvider.overrideWithValue((_) => const SizedBox()),
    ],
    child: const MaterialApp(home: RecordScreen()),
  );

  testWidgets('idle shows Start', (tester) async {
    await tester.pumpWidget(app());
    expect(find.text('Start'), findsOneWidget);
    expect(find.text('Stop'), findsNothing);
  });

  testWidgets('Start → recording shows status card, Pause and Stop', (
    tester,
  ) async {
    when(repo.ensurePermission).thenAnswer((_) async => LocationAccess.granted);
    await tester.pumpWidget(app());

    await tester.tap(find.byKey(const Key('start')));
    await tester.pump(); // requestingPermission
    await tester.pump(); // recording

    expect(find.text('Recording'), findsOneWidget);
    expect(find.text('Waiting for GPS…'), findsOneWidget);
    expect(find.text('Pause'), findsOneWidget);
    expect(find.text('Stop'), findsOneWidget);

    await tester.tap(find.text('Pause'));
    await tester.pump();
    expect(find.text('Paused'), findsOneWidget);
    expect(find.text('Resume'), findsOneWidget);

    await tester.tap(find.text('Stop'));
    await tester.pumpAndSettle();
    expect(find.text('Start'), findsOneWidget);
  });

  testWidgets('denied forever → error view opens app settings', (tester) async {
    when(repo.ensurePermission)
        .thenAnswer((_) async => LocationAccess.deniedForever);
    await tester.pumpWidget(app());

    await tester.tap(find.byKey(const Key('start')));
    await tester.pumpAndSettle();

    expect(find.text('Location is blocked'), findsOneWidget);
    await tester.tap(find.text('Open app settings'));
    verify(repo.openAppSettings).called(1);

    await tester.tap(find.text('Dismiss'));
    await tester.pump();
    expect(find.text('Start'), findsOneWidget);
  });

  testWidgets('service disabled → error view opens location settings', (
    tester,
  ) async {
    when(repo.ensurePermission)
        .thenAnswer((_) async => LocationAccess.serviceDisabled);
    await tester.pumpWidget(app());

    await tester.tap(find.byKey(const Key('start')));
    await tester.pumpAndSettle();

    expect(find.text('Location services are off'), findsOneWidget);
    await tester.tap(find.text('Open location settings'));
    verify(repo.openLocationSettings).called(1);
  });

  testWidgets('denied → Try again re-requests', (tester) async {
    when(repo.ensurePermission).thenAnswer((_) async => LocationAccess.denied);
    await tester.pumpWidget(app());

    await tester.tap(find.byKey(const Key('start')));
    await tester.pumpAndSettle();
    expect(find.text('Location permission needed'), findsOneWidget);

    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    verify(repo.ensurePermission).called(2);
  });
}
