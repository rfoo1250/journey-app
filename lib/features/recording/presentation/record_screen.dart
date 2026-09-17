import 'package:flutter/material.dart';

/// Start/Stop recording UI. Wired to the state machine in M1/M2.
class RecordScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.directions_car, size: 64),
            const SizedBox(height: 16),
            const Text('Live map arrives in M2'),
            const SizedBox(height: 24),
            FilledButton.icon(
              // TODO(M1): drive RecordingController.start()
              onPressed: null,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
