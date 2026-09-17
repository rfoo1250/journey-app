import 'package:journey/core/geo/distance.dart';
import 'package:journey/core/geo/fix.dart';

/// Sanity filter for raw fixes (docs/PLAN.md §4.2):
/// drop accuracy > 30 m, speed > 60 m/s, implausible jumps (> 150 m in < 1 s),
/// duplicate timestamps, and fixes stamped before the session started
/// (iOS hands out a cached last-known position on subscribe).
abstract final class GpsFilter {
  static const maxAccuracyM = 30.0;
  static const maxSpeedMps = 60.0;
  static const jumpDistanceM = 150.0;
  static const jumpWindow = Duration(seconds: 1);

  static List<Fix> apply(Iterable<Fix> raw, {DateTime? sessionStart}) {
    final out = <Fix>[];
    for (final f in raw) {
      if (sessionStart != null && f.ts.isBefore(sessionStart)) continue;
      final acc = f.accuracyM;
      if (acc != null && acc > maxAccuracyM) continue;
      final spd = f.speedMps;
      if (spd != null && spd > maxSpeedMps) continue;

      final prev = out.lastOrNull;
      if (prev != null) {
        final dt = f.ts.difference(prev.ts);
        if (dt <= Duration.zero) continue; // duplicate or out-of-order stamp
        if (dt < jumpWindow &&
            Distance.between(prev.point, f.point) > jumpDistanceM) {
          continue;
        }
      }
      out.add(f);
    }
    return out;
  }
}
