import 'package:flutter_test/flutter_test.dart';
import 'package:journey/core/geo/polyline6.dart';

void main() {
  // KLCC → Bukit Bintang, from SETUP.md §7.3 test shape.
  const pts = [
    (lat: 3.1390, lon: 101.6869),
    (lat: 3.1412, lon: 101.6905),
    (lat: 3.1450, lon: 101.6950),
  ];

  test('round-trips at 1e-6 precision', () {
    final decoded = Polyline6.decode(Polyline6.encode(pts));
    expect(decoded, hasLength(3));
    for (var i = 0; i < pts.length; i++) {
      expect(decoded[i].lat, closeTo(pts[i].lat, 1e-6));
      expect(decoded[i].lon, closeTo(pts[i].lon, 1e-6));
    }
  });

  test('precision 6 differs from precision 5 encoding', () {
    // At precision 5 the first coordinate 3.13900 encodes to a shorter string.
    expect(Polyline6.encode(pts), isNot(equals('_p~iF~ps|U_ulLnnqC_mqNvxq`@')));
  });

  test('empty input', () {
    expect(Polyline6.encode(const []), isEmpty);
    expect(Polyline6.decode(''), isEmpty);
  });
}
