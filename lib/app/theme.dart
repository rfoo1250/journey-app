import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const _seed = Color(0xFF1E6FD9);

  static ThemeData light() => _base(Brightness.light);
  static ThemeData dark() => _base(Brightness.dark);

  static ThemeData _base(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
    );
    return ThemeData(colorScheme: scheme, useMaterial3: true);
  }
}
