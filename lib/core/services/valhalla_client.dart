import 'dart:async';

import 'package:dio/dio.dart';
import 'package:journey/core/env.dart';
import 'package:journey/core/geo/fix.dart';
import 'package:journey/core/geo/polyline6.dart';
import 'package:journey/core/result.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'valhalla_client.g.dart';

/// Result of a successful `trace_route` map match.
class MatchedRoute {
  const new({
    required this.polyline6,
    required this.points,
    required this.lengthM,
  });

  /// Precision-6 encoded matched geometry (first leg).
  final String polyline6;

  /// Decoded [polyline6].
  final List<({double lat, double lon})> points;

  /// Length reported by Valhalla, metres.
  final double lengthM;
}

/// Thin client for the self-hosted Valhalla server (docs/PLAN.md §4.2).
/// `trace_route` with `map_snap`; timestamps and headings are sent so the
/// HMM matcher can use them. Retries transient failures with backoff.
class ValhallaClient {
  new({
    Dio? dio,
    String? baseUrl,
    Logger? log,
    this.maxAttempts = 3,
    this.retryDelay = const Duration(milliseconds: 500),
  }) : _dio =
           dio ??
           Dio(
             BaseOptions(
               baseUrl: baseUrl ?? Env.valhallaBaseUrl,
               connectTimeout: const Duration(seconds: 5),
               receiveTimeout: const Duration(seconds: 20),
               sendTimeout: const Duration(seconds: 5),
             ),
           ),
       _log = log ?? Logger();

  final Dio _dio;
  final Logger _log;
  final int maxAttempts;
  final Duration retryDelay;

  static const minPoints = 2;

  /// Snaps [shape] to the road network. [gpsAccuracyM] should be the median
  /// accuracy of the (filtered) trace.
  Future<Result<MatchedRoute>> traceRoute(
    List<Fix> shape, {
    double gpsAccuracyM = 10,
    double searchRadiusM = 50,
  }) async {
    if (shape.length < minPoints) {
      return const Result.err(
        InvalidInputError('Need at least 2 points to match a route'),
      );
    }

    final body = {
      'shape': [
        for (final f in shape)
          {
            'lat': f.lat,
            'lon': f.lon,
            'time': f.ts.millisecondsSinceEpoch ~/ 1000,
            if (f.heading != null) 'heading': f.heading!.round(),
          },
      ],
      'costing': 'auto',
      'shape_match': 'map_snap',
      'trace_options': {
        'search_radius': searchRadiusM.round(),
        'gps_accuracy': gpsAccuracyM.clamp(1, 100).round(),
        'interpolation_distance': 10,
      },
      'directions_type': 'none',
    };

    DioException? last;
    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        final res = await _dio.post<Map<String, dynamic>>(
          '/trace_route',
          data: body,
        );
        return _parse(res.data);
      } on DioException catch (e) {
        last = e;
        if (!_isRetryable(e) || attempt == maxAttempts) break;
        _log.w('valhalla attempt $attempt failed: ${e.type}; retrying');
        await Future<void>.delayed(retryDelay * attempt);
      }
    }
    final status = last?.response?.statusCode;
    _log.e('valhalla trace_route failed', error: last);
    return Result.err(
      NetworkError(
        status == null
            ? 'Map-matching server unreachable'
            : 'Map-matching server returned $status',
        statusCode: status,
        cause: last,
      ),
    );
  }

  static bool _isRetryable(DioException e) => switch (e.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.connectionError => true,
    DioExceptionType.badResponse => (e.response?.statusCode ?? 0) >= 500,
    _ => false,
  };

  static Result<MatchedRoute> _parse(Map<String, dynamic>? json) {
    try {
      final trip = json!['trip'] as Map<String, dynamic>;
      final legs = trip['legs'] as List<dynamic>;
      final shape = (legs.first as Map<String, dynamic>)['shape'] as String;
      final summary = trip['summary'] as Map<String, dynamic>;
      final lengthKm = (summary['length'] as num).toDouble();
      final points = Polyline6.decode(shape);
      if (points.length < 2) {
        return const Result.err(ParseError('Matched shape has < 2 points'));
      }
      return Result.ok(
        MatchedRoute(
          polyline6: shape,
          points: points,
          lengthM: lengthKm * 1000,
        ),
      );
    } on Object catch (e) {
      return Result.err(
        ParseError('Unexpected map-matching response', cause: e),
      );
    }
  }
}

@Riverpod(keepAlive: true)
ValhallaClient valhallaClient(Ref ref) => ValhallaClient();
