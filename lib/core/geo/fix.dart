/// A single GPS fix, independent of any plugin type so `core/geo` stays pure
/// (docs/PLAN.md §6). Units: metres, seconds, m/s, degrees; [ts] is UTC.
class Fix {
  const new({
    required this.ts,
    required this.lat,
    required this.lon,
    this.accuracyM,
    this.speedMps,
    this.headingDeg,
    this.altitudeM,
  });

  final DateTime ts;
  final double lat;
  final double lon;
  final double? accuracyM;
  final double? speedMps;

  /// Course over ground. Platforms report a negative value when unknown
  /// (iOS gives -1 while stationary); use [heading] for a null-safe view.
  final double? headingDeg;
  final double? altitudeM;

  /// [headingDeg] normalised: null when unknown or out of range.
  double? get heading {
    final h = headingDeg;
    if (h == null || h < 0 || h > 360) return null;
    return h % 360;
  }

  ({double lat, double lon}) get point => (lat: lat, lon: lon);

  Fix copyWith({double? lat, double? lon}) => Fix(
    ts: ts,
    lat: lat ?? this.lat,
    lon: lon ?? this.lon,
    accuracyM: accuracyM,
    speedMps: speedMps,
    headingDeg: headingDeg,
    altitudeM: altitudeM,
  );

  @override
  String toString() =>
      'Fix(${ts.toIso8601String()} $lat,$lon ±$accuracyM ${speedMps}m/s)';
}
