import 'package:flutter_test/flutter_test.dart';
import 'package:journey/core/geo/distance.dart';
import 'package:journey/core/geo/fix.dart';
import 'package:journey/core/geo/kalman.dart';

import 'fixtures.dart';

void main() {
  test('keeps count, timestamps and metadata', () {
    final drive = straightDrive(seconds: 30, noiseM: 8);
    final out = Kalman.smooth(drive);
    expect(out, hasLength(drive.length));
    for (var i = 0; i < drive.length; i++) {
      expect(out[i].ts, drive[i].ts);
      expect(out[i].accuracyM, drive[i].accuracyM);
      expect(out[i].speedMps, drive[i].speedMps);
    }
  });

  test('reduces noise: smoothed points are closer to the true line', () {
    final truth = straightDrive(seconds: 120);
    final noisy = straightDrive(seconds: 120, noiseM: 8);
    final smoothed = Kalman.smooth(noisy);

    double rmse(List<Fix> xs) {
      var s = 0.0;
      for (var i = 10; i < truth.length; i++) {
        final d = Distance.between(truth[i].point, xs[i].point);
        s += d * d;
      }
      return (s / (truth.length - 10)).abs();
    }

    expect(rmse(smoothed), lessThan(rmse(noisy) * 0.6));
  });

  test('a clean straight line is barely altered', () {
    final truth = straightDrive();
    final out = Kalman.smooth(truth);
    for (var i = 0; i < truth.length; i++) {
      expect(Distance.between(truth[i].point, out[i].point), lessThan(2));
    }
  });

  test('degenerate inputs', () {
    expect(Kalman.smooth([]), isEmpty);
    final one = [fix(0, 3.1, 101.6)];
    expect(Kalman.smooth(one), one);
  });
}
