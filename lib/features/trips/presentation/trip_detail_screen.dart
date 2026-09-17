import 'package:flutter/material.dart';

/// Route map, stats and Replay for one trip. Populated in M4/M5.
class TripDetailScreen extends StatelessWidget {
  const new({required this.tripId, super.key});

  final String tripId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trip')),
      body: Center(child: Text('Trip $tripId — detail arrives in M4')),
    );
  }
}
