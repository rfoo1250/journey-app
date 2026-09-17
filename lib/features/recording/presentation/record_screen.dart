import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journey/features/recording/data/location_repository.dart';
import 'package:journey/features/recording/domain/recording_controller.dart';
import 'package:journey/features/recording/domain/recording_state.dart';
import 'package:journey/features/recording/presentation/widgets/live_map.dart';
import 'package:journey/features/recording/presentation/widgets/recording_error_view.dart';
import 'package:journey/features/recording/presentation/widgets/recording_status_card.dart';

/// Live map plus Start / Pause / Stop controls and fix stats.
class RecordScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recordingControllerProvider);
    final ctrl = ref.read(recordingControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Record')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: ref.watch(liveMapBuilderProvider)(context),
              ),
            ),
            switch (state) {
              RecordingIdle() => _Controls(
                primary: _Button(
                  Icons.play_arrow,
                  'Start',
                  ctrl.start,
                  key: const Key('start'),
                ),
              ),
              RecordingRequestingPermission() => const _Busy(
                'Requesting location permission…',
              ),
              RecordingActive(
                :final startedAt,
                :final fixCount,
                :final lastFix,
              ) =>
                Column(
                  children: [
                    RecordingStatusCard(
                      startedAt: startedAt,
                      fixCount: fixCount,
                      lastFix: lastFix,
                      paused: false,
                    ),
                    const SizedBox(height: 12),
                    _Controls(
                      primary: _Button(Icons.pause, 'Pause', ctrl.pause),
                      secondary: _Button(Icons.stop, 'Stop', ctrl.stop),
                    ),
                  ],
                ),
              RecordingPaused(
                :final startedAt,
                :final fixCount,
                :final lastFix,
              ) =>
                Column(
                  children: [
                    RecordingStatusCard(
                      startedAt: startedAt,
                      fixCount: fixCount,
                      lastFix: lastFix,
                      paused: true,
                    ),
                    const SizedBox(height: 12),
                    _Controls(
                      primary: _Button(Icons.play_arrow, 'Resume', ctrl.resume),
                      secondary: _Button(Icons.stop, 'Stop', ctrl.stop),
                    ),
                  ],
                ),
              RecordingProcessing() => const _Busy('Saving drive…'),
              RecordingError(:final kind, :final message) => RecordingErrorView(
                kind: kind,
                message: message,
                onRetry: ctrl.start,
                onDismiss: ctrl.dismissError,
                onOpenAppSettings: ref
                    .read(locationRepositoryProvider)
                    .openAppSettings,
                onOpenLocationSettings: ref
                    .read(locationRepositoryProvider)
                    .openLocationSettings,
              ),
            },
          ],
        ),
      ),
    );
  }
}

class _Controls extends StatelessWidget {
  const new({required this.primary, this.secondary});

  final Widget primary;
  final Widget? secondary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: primary),
        if (secondary != null) ...[
          const SizedBox(width: 12),
          Expanded(child: secondary!),
        ],
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const new(this.icon, this.label, this.onPressed, {super.key});

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}

class _Busy extends StatelessWidget {
  const new(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 12),
        Text(label),
      ],
    );
  }
}
