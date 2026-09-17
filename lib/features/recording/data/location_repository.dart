import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_repository.g.dart';

/// Outcome of [LocationRepository.ensurePermission].
enum LocationAccess {
  /// Fine location granted (at least while-in-use); recording can start.
  granted,

  /// User declined this time; we may ask again.
  denied,

  /// User declined permanently; only the OS settings screen can fix it.
  deniedForever,

  /// Device location services are switched off.
  serviceDisabled,
}

/// Wraps geolocator: permission flow and the high-accuracy position stream
/// with platform settings from docs/PLAN.md §4.1.
class LocationRepository {
  new({
    GeolocatorPlatform? geolocator,
    Future<bool> Function()? requestNotificationPermission,
    Logger? log,
  }) : _geo = geolocator ?? GeolocatorPlatform.instance,
       _requestNotificationPermission =
           requestNotificationPermission ?? _defaultNotificationRequest,
       _log = log ?? Logger();

  final GeolocatorPlatform _geo;
  final Future<bool> Function() _requestNotificationPermission;
  final Logger _log;

  static const _distanceFilterM = 5;

  /// Android foreground-service notification shown while recording.
  static const androidNotification = ForegroundNotificationConfig(
    notificationTitle: 'Journey is recording your drive',
    notificationText: 'Tap to open. Stop recording from the app.',
    notificationChannelName: 'Drive recording',
    setOngoing: true,
    enableWakeLock: true,
  );

  /// Checks location services and permission, requesting if needed.
  /// On Android 13+ also asks for notification permission (best-effort) so
  /// the foreground-service notification is visible.
  Future<LocationAccess> ensurePermission() async {
    if (!await _geo.isLocationServiceEnabled()) {
      _log.w('Location services disabled');
      return LocationAccess.serviceDisabled;
    }

    var permission = await _geo.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geo.requestPermission();
    }

    switch (permission) {
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        if (defaultTargetPlatform == TargetPlatform.android) {
          final ok = await _requestNotificationPermission();
          if (!ok) _log.w('Notification permission not granted');
        }
        return LocationAccess.granted;
      case LocationPermission.denied:
      case LocationPermission.unableToDetermine:
        _log.w('Location permission denied');
        return LocationAccess.denied;
      case LocationPermission.deniedForever:
        _log.w('Location permission denied forever');
        return LocationAccess.deniedForever;
    }
  }

  /// High-accuracy fixes, ≥ [_distanceFilterM] m apart. On Android this
  /// starts a foreground service; on iOS background updates are allowed.
  Stream<Position> positions() => _geo.getPositionStream(
    locationSettings: settingsFor(defaultTargetPlatform),
  );

  Future<bool> openAppSettings() => _geo.openAppSettings();

  Future<bool> openLocationSettings() => _geo.openLocationSettings();

  /// Platform-specific settings (docs/PLAN.md §4.1). Public for tests.
  static LocationSettings settingsFor(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return AndroidSettings(
          accuracy: LocationAccuracy.bestForNavigation,
          distanceFilter: _distanceFilterM,
          foregroundNotificationConfig: androidNotification,
        );
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return AppleSettings(
          accuracy: LocationAccuracy.bestForNavigation,
          distanceFilter: _distanceFilterM,
          activityType: ActivityType.automotiveNavigation,
          showBackgroundLocationIndicator: true,
        );
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
          distanceFilter: _distanceFilterM,
        );
    }
  }

  static Future<bool> _defaultNotificationRequest() async {
    final status = await ph.Permission.notification.request();
    return status.isGranted;
  }
}

@Riverpod(keepAlive: true)
LocationRepository locationRepository(Ref ref) => LocationRepository();
