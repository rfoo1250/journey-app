import 'dart:math' as math;

import 'package:journey/core/geo/fix.dart';

/// Synthetic drive helpers shared by geo tests. Real recorded traces live in
/// test/fixtures/ as they are collected (docs/PLAN.md §7).
final t0 = DateTime.utc(2026, 9, 17, 8);

Fix fix(
  int s,
  double lat,
  double lon, {
  double acc = 5,
  double speed = 12,
  double heading = 90,
}) => Fix(
  ts: t0.add(Duration(seconds: s)),
  lat: lat,
  lon: lon,
  accuracyM: acc,
  speedMps: speed,
  headingDeg: heading,
);

/// Straight eastbound drive at ~12 m/s from KLCC, one fix per second, with
/// optional Gaussian position noise (σ metres). Deterministic seed.
List<Fix> straightDrive({int seconds = 60, double noiseM = 0, int seed = 1}) {
  final rnd = math.Random(seed);
  const lat0 = 3.1578;
  const lon0 = 101.7117;
  const mPerDeg = 111320.0;
  double gauss() {
    final u1 = 1 - rnd.nextDouble();
    final u2 = rnd.nextDouble();
    return math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2);
  }

  return [
    for (var s = 0; s <= seconds; s++)
      fix(
        s,
        lat0 + gauss() * noiseM / mPerDeg,
        lon0 + (12.0 * s + gauss() * noiseM) / mPerDeg,
      ),
  ];
}

/// A fix [ms] milliseconds after [base], offset by [dLat] degrees.
Fix fixAfter(Fix base, {required int ms, double dLat = 0, double dLon = 0}) =>
    Fix(
      ts: base.ts.add(Duration(milliseconds: ms)),
      lat: base.lat + dLat,
      lon: base.lon + dLon,
      accuracyM: base.accuracyM,
      speedMps: base.speedMps,
      headingDeg: base.headingDeg,
    );

/// A fix with no accuracy, speed or heading metadata.
Fix bareFix(int s) =>
    Fix(ts: t0.add(Duration(seconds: s)), lat: 3.1, lon: 101.6);
