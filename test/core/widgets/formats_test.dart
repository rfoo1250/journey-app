import 'package:flutter_test/flutter_test.dart';
import 'package:journey/core/widgets/formats.dart';

void main() {
  test('km rounds to one decimal', () {
    expect(Formats.km(0), '0.0 km');
    expect(Formats.km(4321), '4.3 km');
    expect(Formats.km(12345.6), '12.3 km');
  });

  test('kmh converts m/s', () {
    expect(Formats.kmh(0), '0 km/h');
    expect(Formats.kmh(27.78), '100 km/h');
  });

  test('duration formats hours and minutes', () {
    expect(Formats.duration(0), '0m 00s');
    expect(Formats.duration(750), '12m 30s');
    expect(Formats.duration(3900), '1h 05m');
  });

  test('dateTime renders local date', () {
    final s = Formats.dateTime(DateTime.utc(2026, 9, 17, 7));
    expect(s, matches(RegExp(r'^17 Sep 2026, \d\d:\d\d$')));
  });
}
