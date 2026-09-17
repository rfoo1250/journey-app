import 'dart:math' as math;

import 'package:journey/core/geo/fix.dart';

/// Light 2-D constant-velocity Kalman smoother (docs/PLAN.md §4.2).
///
/// Works in a local east/north metre frame anchored at the first fix, uses
/// each fix's reported accuracy as measurement noise, and returns fixes with
/// smoothed positions and the **original timestamps and metadata**.
abstract final class Kalman {
  /// Assumed acceleration noise, m/s². Higher = trusts measurements more.
  static const defaultProcessNoise = 3.0;

  /// Fallback measurement σ when a fix has no accuracy, metres.
  static const defaultAccuracyM = 10.0;

  static List<Fix> smooth(
    List<Fix> fixes, {
    double processNoise = defaultProcessNoise,
  }) {
    if (fixes.length < 2) return List.of(fixes);

    final origin = fixes.first;
    const mPerDegLat = 111320.0;
    final mPerDegLon = 111320.0 * math.cos(origin.lat * math.pi / 180);
    double east(Fix f) => (f.lon - origin.lon) * mPerDegLon;
    double north(Fix f) => (f.lat - origin.lat) * mPerDegLat;

    // State [x, y, vx, vy]; covariance P (4×4).
    var x = <double>[east(origin), north(origin), 0, 0];
    final a0 = origin.accuracyM ?? defaultAccuracyM;
    var p = _diag([a0 * a0, a0 * a0, 100, 100]);

    final out = <Fix>[origin];
    for (var i = 1; i < fixes.length; i++) {
      final f = fixes[i];
      final dt = f.ts.difference(fixes[i - 1].ts).inMilliseconds / 1000.0;
      if (dt <= 0) {
        out.add(f);
        continue;
      }

      // Predict.
      x = [x[0] + x[2] * dt, x[1] + x[3] * dt, x[2], x[3]];
      final ft = _transition(dt);
      p = _add(
        _mul(_mul(ft, p), _transpose(ft)),
        _processCov(dt, processNoise),
      );

      // Update with position measurement.
      final r = f.accuracyM ?? defaultAccuracyM;
      final rr = r * r;
      final z = [east(f), north(f)];
      final s00 = p[0][0] + rr;
      final s11 = p[1][1] + rr;
      final s01 = p[0][1];
      final det = s00 * s11 - s01 * s01;
      final si = [
        [s11 / det, -s01 / det],
        [-s01 / det, s00 / det],
      ];
      // K = P Hᵀ S⁻¹ where H picks x,y → P[:,0:2] · S⁻¹
      final k = List.generate(
        4,
        (r) => [
          p[r][0] * si[0][0] + p[r][1] * si[1][0],
          p[r][0] * si[0][1] + p[r][1] * si[1][1],
        ],
      );
      final y0 = z[0] - x[0];
      final y1 = z[1] - x[1];
      x = List.generate(4, (r) => x[r] + k[r][0] * y0 + k[r][1] * y1);
      // P = (I − K H) P
      final ikh = _identity(4);
      for (var r = 0; r < 4; r++) {
        ikh[r][0] -= k[r][0];
        ikh[r][1] -= k[r][1];
      }
      p = _mul(ikh, p);

      out.add(
        f.copyWith(
          lat: origin.lat + x[1] / mPerDegLat,
          lon: origin.lon + x[0] / mPerDegLon,
        ),
      );
    }
    return out;
  }

  static List<List<double>> _transition(double dt) => [
    [1, 0, dt, 0],
    [0, 1, 0, dt],
    [0, 0, 1, 0],
    [0, 0, 0, 1],
  ];

  static List<List<double>> _processCov(double dt, double q) {
    final q2 = q * q;
    final dt2 = dt * dt;
    final dt3 = dt2 * dt;
    final dt4 = dt3 * dt;
    return [
      [dt4 / 4 * q2, 0, dt3 / 2 * q2, 0],
      [0, dt4 / 4 * q2, 0, dt3 / 2 * q2],
      [dt3 / 2 * q2, 0, dt2 * q2, 0],
      [0, dt3 / 2 * q2, 0, dt2 * q2],
    ];
  }

  static List<List<double>> _diag(List<double> d) => List.generate(
    d.length,
    (r) => List.generate(d.length, (c) => r == c ? d[r] : 0.0),
  );

  static List<List<double>> _identity(int n) =>
      _diag(List<double>.filled(n, 1));

  static List<List<double>> _transpose(List<List<double>> m) => List.generate(
    m[0].length,
    (c) => List.generate(m.length, (r) => m[r][c]),
  );

  static List<List<double>> _mul(List<List<double>> a, List<List<double>> b) =>
      List.generate(
        a.length,
        (r) => List.generate(b[0].length, (c) {
          var s = 0.0;
          for (var k = 0; k < b.length; k++) {
            s += a[r][k] * b[k][c];
          }
          return s;
        }),
      );

  static List<List<double>> _add(List<List<double>> a, List<List<double>> b) =>
      List.generate(
        a.length,
        (r) => List.generate(a[0].length, (c) => a[r][c] + b[r][c]),
      );
}
