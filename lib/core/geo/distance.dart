import 'dart:math' as math;

/// Great-circle distances in metres (docs/PLAN.md §4.2).
abstract final class Distance {
  static const earthRadiusM = 6371008.8;

  /// Haversine distance between two points in degrees.
  static double between(
    ({double lat, double lon}) a,
    ({double lat, double lon}) b,
  ) {
    final dLat = _rad(b.lat - a.lat);
    final dLon = _rad(b.lon - a.lon);
    final h =
        math.pow(math.sin(dLat / 2), 2) +
        math.cos(_rad(a.lat)) *
            math.cos(_rad(b.lat)) *
            math.pow(math.sin(dLon / 2), 2);
    return 2 * earthRadiusM * math.asin(math.sqrt(h));
  }

  /// Sum of segment lengths along [line]. Zero for fewer than two points.
  static double along(List<({double lat, double lon})> line) {
    var total = 0.0;
    for (var i = 1; i < line.length; i++) {
      total += between(line[i - 1], line[i]);
    }
    return total;
  }

  static double _rad(double deg) => deg * math.pi / 180;
}
