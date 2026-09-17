import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journey/features/recording/presentation/widgets/live_map.dart';
import 'package:journey/features/trips/data/trip_repository.dart';
import 'package:journey/features/trips/domain/trip.dart';
import 'package:journey/main.dart';

void main() {
  Widget app() => ProviderScope(
    overrides: [
      tripListProvider.overrideWith((ref) => Stream.value(const <Trip>[])),
      liveMapBuilderProvider.overrideWithValue((_) => const SizedBox()),
    ],
    child: const JourneyApp(),
  );

  testWidgets('boots to trip list and navigates to record', (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.text('No trips yet. Tap Record to start.'), findsOneWidget);

    await tester.tap(find.text('Record'));
    await tester.pumpAndSettle();

    expect(find.text('Start'), findsOneWidget);
  });
}
