import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journey/app/router.dart';
import 'package:journey/features/trips/data/trip_repository.dart';

/// Newest-first list of saved trips (PLAN.md §2 goal 4).
class TripListScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trips = ref.watch(tripListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Journey')),
      body: trips.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Could not load trips: $e')),
        data: (list) => list.isEmpty
            ? const Center(child: Text('No trips yet. Tap Record to start.'))
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final t = list[i];
                  return ListTile(
                    leading: const Icon(Icons.route),
                    title: Text(t.startedAt.toLocal().toString()),
                    subtitle: Text(
                      '${(t.distanceM / 1000).toStringAsFixed(1)} km',
                    ),
                    onTap: () => AppRoutes.pushTripDetail(context, t.id),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AppRoutes.goRecord(context),
        icon: const Icon(Icons.fiber_manual_record),
        label: const Text('Record'),
      ),
    );
  }
}
