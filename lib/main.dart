import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journey/app/router.dart';
import 'package:journey/app/theme.dart';
import 'package:journey/core/env.dart';
import 'package:journey/features/trips/domain/trip_processor.dart';
import 'package:logger/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load();
  final container = ProviderContainer();
  runApp(
    UncontrolledProviderScope(container: container, child: const JourneyApp()),
  );
  // Trips left `unmatched` (Valhalla unreachable at Stop) are retried on
  // every launch (docs/PLAN.md §4.2). Best-effort, never blocks startup.
  unawaited(
    container.read(tripProcessorProvider).retryUnmatched().catchError((
      Object e,
      StackTrace st,
    ) {
      Logger().w('unmatched retry failed', error: e, stackTrace: st);
      return 0;
    }),
  );
}

class JourneyApp extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Journey',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: router,
    );
  }
}
