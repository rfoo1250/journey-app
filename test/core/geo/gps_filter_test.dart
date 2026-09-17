import 'package:flutter_test/flutter_test.dart';
import 'package:journey/core/geo/gps_filter.dart';

import 'fixtures.dart';

void main() {
  test('passes a clean trace untouched', () {
    final drive = straightDrive(seconds: 10);
    expect(GpsFilter.apply(drive), drive);
  });

  test('drops accuracy > 30 m', () {
    final bad = fix(1, 3.1, 101.6, acc: 31);
    expect(GpsFilter.apply([fix(0, 3.1, 101.6), bad]), hasLength(1));
    expect(GpsFilter.apply([fix(0, 3.1, 101.6, acc: 30)]), hasLength(1));
  });

  test('drops speed > 60 m/s', () {
    expect(GpsFilter.apply([fix(0, 3.1, 101.6, speed: 61)]), isEmpty);
    expect(GpsFilter.apply([fix(0, 3.1, 101.6, speed: 60)]), hasLength(1));
  });

  test('drops > 150 m jump within 1 s but keeps it when time allows', () {
    final a = fix(0, 3.1000, 101.6);
    final jump900ms = fixAfter(a, ms: 900, dLat: 0.0020); // ~222 m in 0.9 s
    final jump2s = fixAfter(a, ms: 2000, dLat: 0.0020); // same jump, 2 s
    final small900ms = fixAfter(a, ms: 900, dLat: 0.0010); // ~111 m in 0.9 s
    expect(GpsFilter.apply([a, jump900ms]), [a]);
    expect(GpsFilter.apply([a, jump2s]), [a, jump2s]);
    expect(GpsFilter.apply([a, small900ms]), [a, small900ms]);
  });

  test('drops duplicate and out-of-order timestamps', () {
    final a = fix(0, 3.1, 101.6);
    final dup = fix(0, 3.1001, 101.6);
    final earlier = fix(-1, 3.1002, 101.6);
    final later = fix(1, 3.1003, 101.6);
    expect(GpsFilter.apply([a, dup, earlier, later]), [a, later]);
  });

  test('drops cached fixes stamped before the session start', () {
    final cached = fix(-5, 3.1, 101.6);
    final live = fix(1, 3.1, 101.6);
    expect(GpsFilter.apply([cached, live], sessionStart: t0), [live]);
    expect(GpsFilter.apply([cached, live]), [cached, live]);
  });

  test('null accuracy/speed are not filtered', () {
    final f = bareFix(0);
    expect(GpsFilter.apply([f]), [f]);
  });
}
