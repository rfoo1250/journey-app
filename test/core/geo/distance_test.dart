import 'package:flutter_test/flutter_test.dart';
import 'package:journey/core/geo/distance.dart';

void main() {
  const klcc = (lat: 3.15785, lon: 101.71165);
  const klSentral = (lat: 3.13400, lon: 101.68650);

  test('between: KLCC → KL Sentral ≈ 3.8 km', () {
    expect(Distance.between(klcc, klSentral), closeTo(3800, 100));
  });

  test('between is symmetric and zero for identical points', () {
    expect(
      Distance.between(klcc, klSentral),
      Distance.between(klSentral, klcc),
    );
    expect(Distance.between(klcc, klcc), 0);
  });

  test('1 degree of latitude ≈ 111.2 km', () {
    expect(
      Distance.between((lat: 0, lon: 0), (lat: 1, lon: 0)),
      closeTo(111195, 50),
    );
  });

  test('along sums segments; degenerate lines are zero', () {
    const mid = (lat: 3.1459, lon: 101.6991);
    final direct = Distance.between(klcc, klSentral);
    final viaMid = Distance.along([klcc, mid, klSentral]);
    expect(viaMid, greaterThanOrEqualTo(direct));
    expect(
      viaMid,
      closeTo(
        Distance.between(klcc, mid) + Distance.between(mid, klSentral),
        1e-6,
      ),
    );
    expect(Distance.along([]), 0);
    expect(Distance.along([klcc]), 0);
  });
}
