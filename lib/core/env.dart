import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Typed access to `.env` (PLAN.md §3 Config). Keys must also appear in
/// `.env.example`.
abstract final class Env {
  static const _valhallaBaseUrl = 'VALHALLA_BASE_URL';
  static const _mapStyleUrl = 'MAP_STYLE_URL';

  /// Loads `.env`. Missing file is tolerated so tests and fresh clones run;
  /// individual getters then fall back to defaults.
  static Future<void> load() => dotenv.load(isOptional: true);

  static String get valhallaBaseUrl =>
      dotenv.maybeGet(_valhallaBaseUrl) ?? 'http://localhost:8002';

  static String get mapStyleUrl =>
      dotenv.maybeGet(_mapStyleUrl) ??
      'https://tiles.openfreemap.org/styles/liberty';
}
