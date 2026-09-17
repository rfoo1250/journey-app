import 'package:flutter_test/flutter_test.dart';
import 'package:journey/core/geo/distance.dart';
import 'package:journey/core/geo/simplify.dart';

import 'fixtures.dart';

void main() {
  test('straight line collapses to its endpoints', () {
    final drive = straightDrive();
    final out = Simplify.rdp(drive);
    expect(out, [drive.first, drive.last]);
  });

  test('noisy line keeps far fewer points and stays within ε of the input', () {
    // Noise σ below ε: most points fall within the corridor and are dropped.
    final drive = straightDrive(seconds: 120, noiseM: 2);
    final out = Simplify.rdp(drive);
    expect(out.length, lessThan(drive.length ~/ 2));
    expect(out.first, drive.first);
    expect(out.last, drive.last);
    // Every kept point is an original fix (timestamps preserved).
    for (final f in out) {
      expect(drive, contains(f));
    }
    // Simplified length is close to the original.
    final lenIn = Distance.along([for (final f in drive) f.point]);
    final lenOut = Distance.along([for (final f in out) f.point]);
    expect(lenOut, closeTo(lenIn, lenIn * 0.2));
  });

  test('a real corner is preserved', () {
    final east = straightDrive(seconds: 30);
    final last = east.last;
    final north = [
      for (var s = 1; s <= 30; s++)
        fix(30 + s, last.lat + 12.0 * s / 111320, last.lon),
    ];
    final out = Simplify.rdp([...east, ...north]);
    expect(out, hasLength(3));
    expect(out[1], last);
  });

  test('two or fewer points are returned as-is', () {
    final two = straightDrive(seconds: 1);
    expect(Simplify.rdp(two), two);
    expect(Simplify.rdp([]), isEmpty);
  });
}
