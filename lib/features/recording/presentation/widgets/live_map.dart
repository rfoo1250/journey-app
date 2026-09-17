import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journey/core/env.dart';
import 'package:journey/features/recording/domain/recording_controller.dart';
import 'package:journey/features/recording/domain/recording_state.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_map.g.dart';

/// Builds the live map. Overridden in widget tests, where the MapLibre
/// platform view cannot render (docs/PLAN.md §7).
@riverpod
WidgetBuilder liveMapBuilder(Ref ref) =>
    (_) => const LiveMap();

/// MapLibre map showing the trace recorded so far and a puck at the last fix.
/// The puck is drawn from our own fixes (not MapLibre's location component)
/// so the app runs a single location stream and the puck matches what is
/// saved. Source updates are throttled to 1 Hz (docs/PLAN.md §8).
class LiveMap extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<LiveMap> createState() => _LiveMapState();
}

class _LiveMapState extends ConsumerState<LiveMap> {
  static const _traceSource = 'trace';
  static const _puckSource = 'puck';
  static const _accent = '#1E6FD9';
  static const _kl = LatLng(3.139, 101.687);
  static const _followZoom = 16.0;
  static const _minUpdateGap = Duration(seconds: 1);

  MapLibreMapController? _map;
  var _styleReady = false;
  var _follow = true;
  var _programmaticMove = false;
  var _bearing = 0.0;
  var _lastPush = DateTime.fromMillisecondsSinceEpoch(0);

  @override
  Widget build(BuildContext context) {
    ref.listen(recordingControllerProvider, (_, next) => _onState(next));

    return Stack(
      children: [
        MapLibreMap(
          styleString: Env.mapStyleUrl,
          initialCameraPosition: const CameraPosition(target: _kl, zoom: 11),
          onMapCreated: (c) => _map = c,
          onStyleLoadedCallback: _onStyleLoaded,
          onCameraMove: _onCameraMove,
          compassEnabled: false,
          rotateGesturesEnabled: false,
          tiltGesturesEnabled: false,
          attributionButtonPosition: AttributionButtonPosition.bottomLeft,
        ),
        Positioned(
          right: 12,
          bottom: 12,
          child: FloatingActionButton.small(
            heroTag: null,
            tooltip: _follow ? 'Following' : 'Recenter',
            onPressed: _recenter,
            child: Icon(_follow ? Icons.my_location : Icons.location_searching),
          ),
        ),
      ],
    );
  }

  Future<void> _onStyleLoaded() async {
    final map = _map;
    if (map == null) return;
    await map.addGeoJsonSource(_traceSource, _emptyCollection);
    await map.addLineLayer(
      _traceSource,
      'trace-line',
      const LineLayerProperties(
        lineColor: _accent,
        lineWidth: 5,
        lineOpacity: 0.9,
        lineCap: 'round',
        lineJoin: 'round',
      ),
    );
    await map.addGeoJsonSource(_puckSource, _emptyCollection);
    await map.addCircleLayer(
      _puckSource,
      'puck-halo',
      const CircleLayerProperties(
        circleRadius: 16,
        circleColor: _accent,
        circleOpacity: 0.2,
      ),
    );
    await map.addCircleLayer(
      _puckSource,
      'puck-dot',
      const CircleLayerProperties(
        circleRadius: 7,
        circleColor: _accent,
        circleStrokeColor: '#FFFFFF',
        circleStrokeWidth: 2,
      ),
    );
    _styleReady = true;
    await _push(ref.read(recordingControllerProvider), force: true);
  }

  void _onCameraMove(CameraPosition _) {
    if (!_programmaticMove && _follow) setState(() => _follow = false);
  }

  void _recenter() {
    setState(() => _follow = true);
    unawaited(_push(ref.read(recordingControllerProvider), force: true));
  }

  void _onState(RecordingState state) {
    final force = state is! RecordingActive; // transitions always render
    unawaited(_push(state, force: force));
  }

  Future<void> _push(RecordingState state, {required bool force}) async {
    final map = _map;
    if (map == null || !_styleReady) return;
    final now = DateTime.now();
    if (!force && now.difference(_lastPush) < _minUpdateGap) return;
    _lastPush = now;

    final (trace, lastFix) = switch (state) {
      RecordingActive(:final trace, :final lastFix) => (trace, lastFix),
      RecordingPaused(:final trace, :final lastFix) => (trace, lastFix),
      _ => (const <({double lat, double lon})>[], null),
    };

    await map.setGeoJsonSource(
      _traceSource,
      trace.length < 2 ? _emptyCollection : _lineCollection(trace),
    );
    await map.setGeoJsonSource(
      _puckSource,
      lastFix == null
          ? _emptyCollection
          : _pointCollection(lastFix.latitude, lastFix.longitude),
    );

    if (_follow && lastFix != null) {
      // Keep the last good bearing while stationary (iOS reports -1).
      if (lastFix.speed > 1 && lastFix.heading >= 0) _bearing = lastFix.heading;
      _programmaticMove = true;
      await map.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(lastFix.latitude, lastFix.longitude),
            zoom: _followZoom,
            bearing: _bearing,
          ),
        ),
        duration: const Duration(milliseconds: 800),
      );
      _programmaticMove = false;
    }
  }

  static const _emptyCollection = <String, dynamic>{
    'type': 'FeatureCollection',
    'features': <Object>[],
  };

  static Map<String, dynamic> _lineCollection(
    List<({double lat, double lon})> trace,
  ) => {
    'type': 'FeatureCollection',
    'features': [
      {
        'type': 'Feature',
        'properties': <String, dynamic>{},
        'geometry': {
          'type': 'LineString',
          'coordinates': [
            for (final p in trace) [p.lon, p.lat],
          ],
        },
      },
    ],
  };

  static Map<String, dynamic> _pointCollection(double lat, double lon) => {
    'type': 'FeatureCollection',
    'features': [
      {
        'type': 'Feature',
        'properties': <String, dynamic>{},
        'geometry': {
          'type': 'Point',
          'coordinates': [lon, lat],
        },
      },
    ],
  };
}
