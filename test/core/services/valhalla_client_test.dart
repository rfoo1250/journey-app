import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journey/core/geo/polyline6.dart';
import 'package:journey/core/result.dart';
import 'package:journey/core/services/valhalla_client.dart';
import 'package:logger/logger.dart';

import '../geo/fixtures.dart';

/// Scripted HTTP adapter: each call pops the next scripted outcome.
class ScriptedAdapter implements HttpClientAdapter {
  new(this.script);
  final List<Object> script; // ResponseBody | DioExceptionType
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final next = script.removeAt(0);
    if (next is DioExceptionType) {
      throw DioException(requestOptions: options, type: next);
    }
    return next as ResponseBody;
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody json(Object body, {int status = 200}) => ResponseBody.fromString(
  jsonEncode(body),
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

final List<({double lat, double lon})> matchedPts = [
  (lat: 3.1390, lon: 101.6869),
  (lat: 3.1412, lon: 101.6905),
  (lat: 3.1450, lon: 101.6950),
];
Map<String, dynamic> okBody() => {
  'trip': {
    'legs': [
      {'shape': Polyline6.encode(matchedPts)},
    ],
    'summary': {'length': 2.21},
    'status': 0,
  },
};

void main() {
  setUpAll(() => Logger.level = Level.off);

  (ValhallaClient, ScriptedAdapter) client(List<Object> script) {
    final adapter = ScriptedAdapter(script);
    final dio = Dio(BaseOptions(baseUrl: 'http://valhalla.test'))
      ..httpClientAdapter = adapter;
    return (ValhallaClient(dio: dio, retryDelay: Duration.zero), adapter);
  }

  test('sends shape with time/heading and parses the matched route', () async {
    final (c, adapter) = client([json(okBody())]);
    final drive = straightDrive(seconds: 3);

    final r = await c.traceRoute(drive, gpsAccuracyM: 7.4);

    final route = (r as Ok<MatchedRoute>).value;
    expect(route.lengthM, closeTo(2210, 0.01));
    expect(route.points, hasLength(3));
    expect(route.points.first.lat, closeTo(3.1390, 1e-6));
    expect(route.polyline6, Polyline6.encode(matchedPts));

    final req = adapter.requests.single;
    expect(req.path, '/trace_route');
    final body = req.data as Map<String, dynamic>;
    expect(body['shape_match'], 'map_snap');
    expect(body['costing'], 'auto');
    final shape = body['shape'] as List<dynamic>;
    expect(shape, hasLength(4));
    final first = shape.first as Map<String, dynamic>;
    expect(first['time'], drive.first.ts.millisecondsSinceEpoch ~/ 1000);
    expect(first['heading'], 90);
    final opts = body['trace_options'] as Map<String, dynamic>;
    expect(opts['gps_accuracy'], 7);
    expect(opts['search_radius'], 50);
  });

  test('omits heading when unknown', () async {
    final (c, adapter) = client([json(okBody())]);
    await c.traceRoute([bareFix(0), bareFix(1)]);
    final shape =
        (adapter.requests.single.data as Map<String, dynamic>)['shape']
            as List<dynamic>;
    expect((shape.first as Map<String, dynamic>).containsKey('heading'), false);
  });

  test('rejects fewer than 2 points without a request', () async {
    final (c, adapter) = client([]);
    final r = await c.traceRoute([bareFix(0)]);
    expect(r.errorOrNull, isA<InvalidInputError>());
    expect(adapter.requests, isEmpty);
  });

  test('retries timeouts and connection errors, then succeeds', () async {
    final (c, adapter) = client([
      DioExceptionType.connectionTimeout,
      DioExceptionType.connectionError,
      json(okBody()),
    ]);
    final r = await c.traceRoute(straightDrive(seconds: 2));
    expect(r.isOk, isTrue);
    expect(adapter.requests, hasLength(3));
  });

  test('gives up after maxAttempts with NetworkError', () async {
    final (c, adapter) = client([
      DioExceptionType.connectionError,
      DioExceptionType.connectionError,
      DioExceptionType.connectionError,
    ]);
    final r = await c.traceRoute(straightDrive(seconds: 2));
    final err = r.errorOrNull! as NetworkError;
    expect(err.statusCode, isNull);
    expect(err.message, contains('unreachable'));
    expect(adapter.requests, hasLength(3));
  });

  test('4xx is not retried and carries the status', () async {
    final (c, adapter) = client([
      json({'error': 'No route found', 'error_code': 442}, status: 400),
    ]);
    final r = await c.traceRoute(straightDrive(seconds: 2));
    final err = r.errorOrNull! as NetworkError;
    expect(err.statusCode, 400);
    expect(adapter.requests, hasLength(1));
  });

  test('5xx is retried', () async {
    final (c, adapter) = client([
      json({'error': 'boom'}, status: 503),
      json(okBody()),
    ]);
    final r = await c.traceRoute(straightDrive(seconds: 2));
    expect(r.isOk, isTrue);
    expect(adapter.requests, hasLength(2));
  });

  test('malformed body → ParseError', () async {
    final (c, _) = client([
      json({'trip': <String, dynamic>{}}),
    ]);
    final r = await c.traceRoute(straightDrive(seconds: 2));
    expect(r.errorOrNull, isA<ParseError>());
  });
}
