import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:journey/features/recording/data/location_repository.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

class MockGeolocator extends Mock implements GeolocatorPlatform;

class FakeLocationSettings extends Fake implements LocationSettings;

Position fix(double lat, double lon) => Position(
  latitude: lat,
  longitude: lon,
  timestamp: DateTime.utc(2026, 9, 17),
  accuracy: 5,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: 0,
  headingAccuracy: 0,
  speed: 0,
  speedAccuracy: 0,
);

void main() {
  late MockGeolocator geo;
  late LocationRepository repo;
  var notificationRequests = 0;

  setUpAll(() => registerFallbackValue(FakeLocationSettings()));

  setUp(() {
    geo = MockGeolocator();
    notificationRequests = 0;
    repo = LocationRepository(
      geolocator: geo,
      requestNotificationPermission: () async {
        notificationRequests++;
        return true;
      },
      log: Logger(level: Level.off),
    );
    when(geo.isLocationServiceEnabled).thenAnswer((_) async => true);
  });

  group('ensurePermission', () {
    test('service disabled short-circuits', () async {
      when(geo.isLocationServiceEnabled).thenAnswer((_) async => false);
      expect(await repo.ensurePermission(), LocationAccess.serviceDisabled);
      verifyNever(geo.checkPermission);
    });

    test('already granted does not request again', () async {
      when(geo.checkPermission)
          .thenAnswer((_) async => LocationPermission.whileInUse);
      expect(await repo.ensurePermission(), LocationAccess.granted);
      verifyNever(geo.requestPermission);
    });

    test('denied → request → granted', () async {
      when(geo.checkPermission)
          .thenAnswer((_) async => LocationPermission.denied);
      when(geo.requestPermission)
          .thenAnswer((_) async => LocationPermission.always);
      expect(await repo.ensurePermission(), LocationAccess.granted);
      verify(geo.requestPermission).called(1);
    });

    test('denied → request → still denied', () async {
      when(geo.checkPermission)
          .thenAnswer((_) async => LocationPermission.denied);
      when(geo.requestPermission)
          .thenAnswer((_) async => LocationPermission.denied);
      expect(await repo.ensurePermission(), LocationAccess.denied);
    });

    test('denied forever is reported without requesting', () async {
      when(geo.checkPermission)
          .thenAnswer((_) async => LocationPermission.deniedForever);
      expect(await repo.ensurePermission(), LocationAccess.deniedForever);
      verifyNever(geo.requestPermission);
    });

    test('notification permission requested only on Android', () async {
      when(geo.checkPermission)
          .thenAnswer((_) async => LocationPermission.whileInUse);

      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      await repo.ensurePermission();
      expect(notificationRequests, 1);

      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      await repo.ensurePermission();
      expect(notificationRequests, 1);

      debugDefaultTargetPlatformOverride = null;
    });
  });

  test('positions forwards the platform stream', () async {
    final fixes = [fix(3.1, 101.6), fix(3.2, 101.7)];
    when(
      () => geo.getPositionStream(
        locationSettings: any(named: 'locationSettings'),
      ),
    ).thenAnswer((_) => Stream.fromIterable(fixes));

    expect(await repo.positions().toList(), fixes);
  });

  group('settingsFor', () {
    test('android uses foreground notification and 5 m filter', () {
      final s = LocationRepository.settingsFor(TargetPlatform.android);
      expect(s, isA<AndroidSettings>());
      expect(s.distanceFilter, 5);
      expect(s.accuracy, LocationAccuracy.bestForNavigation);
      expect(
        (s as AndroidSettings).foregroundNotificationConfig,
        LocationRepository.androidNotification,
      );
    });

    test('iOS is automotive, never auto-pauses, allows background', () {
      final s =
          LocationRepository.settingsFor(TargetPlatform.iOS) as AppleSettings;
      expect(s.activityType, ActivityType.automotiveNavigation);
      expect(s.pauseLocationUpdatesAutomatically, isFalse);
      expect(s.allowBackgroundLocationUpdates, isTrue);
      expect(s.distanceFilter, 5);
    });
  });
}
