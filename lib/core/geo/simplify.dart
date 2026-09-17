import 'package:journey/core/geo/fix.dart';
import 'package:turf/turf.dart' as turf;

/// Douglas-Peucker wrapper over turf (docs/PLAN.md §4.2). Keeps a subset of
/// the original fixes, so timestamps and metadata survive.
abstract final class Simplify {
  static const defaultEpsilonM = 3.0;

  /// Metres → degrees of latitude. Near the equator (Klang Valley ≈ 3° N)
  /// a degree of longitude is within 0.2 % of this, so one factor suffices.
  static const double _degPerM = 1 / 111320.0;

  static List<Fix> rdp(List<Fix> fixes, {double epsilonM = defaultEpsilonM}) {
    if (fixes.length <= 2) return List.of(fixes);

    final line = turf.Feature<turf.LineString>(
      geometry: turf.LineString(
        coordinates: [for (final f in fixes) turf.Position(f.lon, f.lat)],
      ),
    );
    final simplified = turf.simplify(
      line,
      tolerance: epsilonM * _degPerM,
      highestQuality: true,
    );

    // Map kept coordinates back to their fixes (first match wins).
    final byCoord = <(double, double), Fix>{};
    for (final f in fixes) {
      byCoord.putIfAbsent((f.lon, f.lat), () => f);
    }
    return [
      for (final c in simplified.geometry!.coordinates)
        byCoord[(c.lng.toDouble(), c.lat.toDouble())]!,
    ];
  }
}
