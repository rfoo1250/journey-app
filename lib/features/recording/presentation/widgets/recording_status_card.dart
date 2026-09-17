import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// Live stats while recording or paused: elapsed time, fix count, last fix.
class RecordingStatusCard extends StatelessWidget {
  const new({
    required this.startedAt,
    required this.fixCount,
    required this.paused,
    this.lastFix,
    super.key,
  });

  final DateTime startedAt;
  final int fixCount;
  final bool paused;
  final Position? lastFix;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fix = lastFix;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  paused ? Icons.pause_circle : Icons.fiber_manual_record,
                  color: paused ? theme.colorScheme.outline : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  paused ? 'Paused' : 'Recording',
                  style: theme.textTheme.titleMedium,
                ),
                const Spacer(),
                _Elapsed(since: startedAt),
              ],
            ),
            const SizedBox(height: 12),
            _Stat(label: 'Fixes', value: '$fixCount'),
            if (fix != null) ...[
              _Stat(
                label: 'Position',
                value:
                    '${fix.latitude.toStringAsFixed(5)}, '
                    '${fix.longitude.toStringAsFixed(5)}',
              ),
              _Stat(
                label: 'Accuracy',
                value: '±${fix.accuracy.toStringAsFixed(0)} m',
              ),
              _Stat(
                label: 'Speed',
                value: '${(fix.speed * 3.6).toStringAsFixed(0)} km/h',
              ),
            ] else
              const _Stat(label: 'Position', value: 'Waiting for GPS…'),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const new({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(label, style: theme.textTheme.bodyMedium),
          ),
          Text(
            value,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

/// hh:mm:ss since [since], ticking once a second.
class _Elapsed extends StatelessWidget {
  const new({required this.since});

  final DateTime since;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: Stream<int>.periodic(const Duration(seconds: 1), (i) => i),
      builder: (context, _) {
        final d = DateTime.now().toUtc().difference(since);
        String two(int n) => n.toString().padLeft(2, '0');
        return Text(
          '${two(d.inHours)}:${two(d.inMinutes % 60)}:${two(d.inSeconds % 60)}',
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
        );
      },
    );
  }
}
