import 'package:google_polyline_algorithm/google_polyline_algorithm.dart'
    as gpa;

/// Encode/decode Google polylines at precision 6, as Valhalla uses
/// (docs/PLAN.md §3). Coordinates are `(lat, lon)` records in degrees.
abstract final class Polyline6 {
  static const _precision = 6;

  static String encode(Iterable<({double lat, double lon})> points) =>
      gpa.encodePolyline([
        for (final p in points) [p.lat, p.lon],
      ], accuracyExponent: _precision);

  static List<({double lat, double lon})> decode(String polyline) => [
    for (final c in gpa.decodePolyline(polyline, accuracyExponent: _precision))
      (lat: c[0].toDouble(), lon: c[1].toDouble()),
  ];
}
