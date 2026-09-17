import 'package:flutter/material.dart';
import 'package:journey/core/db/tables.dart' show TripStatus;
import 'package:journey/core/widgets/formats.dart';
import 'package:journey/features/trips/domain/trip.dart';

/// One row in the trip list: date, places (when known), distance, duration.
class TripTile extends StatelessWidget {
  const new({required this.trip, required this.onTap, super.key});

  final Trip trip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inProgress = trip.status == TripStatus.inProgress;
    final places = switch ((trip.startPlace, trip.endPlace)) {
      (final String a, final String b) => '$a → $b',
      (final String a, null) => a,
      _ => null,
    };

    return ListTile(
      leading: Icon(inProgress ? Icons.radio_button_checked : Icons.route),
      title: Text(Formats.dateTime(trip.startedAt)),
      subtitle: Text(
        places ??
            (inProgress
                ? 'Recording in progress'
                : '${Formats.km(trip.distanceM)} · '
                      '${Formats.duration(trip.durationS)}'),
      ),
      trailing: inProgress
          ? Chip(
              label: const Text('LIVE'),
              backgroundColor: theme.colorScheme.errorContainer,
              labelStyle: TextStyle(color: theme.colorScheme.onErrorContainer),
              visualDensity: VisualDensity.compact,
            )
          : Text(
              Formats.km(trip.distanceM),
              style: theme.textTheme.titleMedium,
            ),
      onTap: onTap,
    );
  }
}
