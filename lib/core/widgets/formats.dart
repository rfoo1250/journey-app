/// Presentation-only unit formatting (docs/PLAN.md §6: metres/seconds/m/s
/// internally, km / km/h / local time only here).
abstract final class Formats {
  static String km(double metres) => '${(metres / 1000).toStringAsFixed(1)} km';

  static String kmh(double mps) => '${(mps * 3.6).toStringAsFixed(0)} km/h';

  /// `1h 05m` or `12m 30s`.
  static String duration(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    if (h > 0) return '${h}h ${m.toString().padLeft(2, '0')}m';
    return '${m}m ${s.toString().padLeft(2, '0')}s';
  }

  /// Local date and time, e.g. `17 Sep 2026, 15:04`.
  static String dateTime(DateTime utc) {
    final l = utc.toLocal();
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hh = l.hour.toString().padLeft(2, '0');
    final mm = l.minute.toString().padLeft(2, '0');
    return '${l.day} ${months[l.month - 1]} ${l.year}, $hh:$mm';
  }
}
