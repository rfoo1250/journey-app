import 'package:flutter/material.dart';
import 'package:journey/features/recording/domain/recording_state.dart';

/// Graceful denial / failure UI with the one action that can fix it.
class RecordingErrorView extends StatelessWidget {
  const new({
    required this.kind,
    required this.onRetry,
    required this.onDismiss,
    required this.onOpenAppSettings,
    required this.onOpenLocationSettings,
    this.message,
    super.key,
  });

  final RecordingErrorKind kind;
  final String? message;
  final VoidCallback onRetry;
  final VoidCallback onDismiss;
  final VoidCallback onOpenAppSettings;
  final VoidCallback onOpenLocationSettings;

  @override
  Widget build(BuildContext context) {
    final (title, body, action) = switch (kind) {
      RecordingErrorKind.permissionDenied => (
        'Location permission needed',
        'Journey can only record a drive with access to your location. '
            'Nothing leaves this device.',
        FilledButton(onPressed: onRetry, child: const Text('Try again')),
      ),
      RecordingErrorKind.permissionDeniedForever => (
        'Location is blocked',
        'Allow location for Journey in system settings, then come back.',
        FilledButton(
          onPressed: onOpenAppSettings,
          child: const Text('Open app settings'),
        ),
      ),
      RecordingErrorKind.locationServiceDisabled => (
        'Location services are off',
        'Turn on location services to record a drive.',
        FilledButton(
          onPressed: onOpenLocationSettings,
          child: const Text('Open location settings'),
        ),
      ),
      RecordingErrorKind.streamFailure => (
        'GPS stopped',
        message ?? 'The location stream failed unexpectedly.',
        FilledButton(onPressed: onRetry, child: const Text('Try again')),
      ),
    };

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_off, size: 56),
          const SizedBox(height: 16),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(body, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          action,
          TextButton(onPressed: onDismiss, child: const Text('Dismiss')),
        ],
      ),
    );
  }
}
