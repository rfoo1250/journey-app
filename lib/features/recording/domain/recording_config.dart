import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recording_config.g.dart';

/// Tunables for the recording pipeline (docs/PLAN.md §4.1). Overridden in
/// tests to make flushing deterministic.
class RecordingConfig {
  const new({
    this.flushEvery = 20,
    this.flushInterval = const Duration(seconds: 10),
  });

  /// Flush buffered fixes to `trip_points` after this many points…
  final int flushEvery;

  /// …or after this long, whichever comes first (≤ 10 s lost on a crash).
  final Duration flushInterval;
}

@Riverpod(keepAlive: true)
RecordingConfig recordingConfig(Ref ref) => const RecordingConfig();
