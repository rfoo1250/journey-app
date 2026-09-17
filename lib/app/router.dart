import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:journey/features/recording/presentation/record_screen.dart';
import 'package:journey/features/trips/presentation/trip_detail_screen.dart';
import 'package:journey/features/trips/presentation/trip_list_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

/// Typed route table. Screens navigate via these helpers, never raw strings.
abstract final class AppRoutes {
  static const trips = '/';
  static const record = '/record';
  static const tripDetail = '/trips/:id';

  static String tripDetailPath(String id) => '/trips/$id';

  static void goTrips(BuildContext context) => context.go(trips);
  static void goRecord(BuildContext context) => context.go(record);
  static void pushTripDetail(BuildContext context, String id) =>
      context.push(tripDetailPath(id));
}

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.trips,
    routes: [
      GoRoute(
        path: AppRoutes.trips,
        builder: (context, state) => const TripListScreen(),
        routes: [
          GoRoute(
            path: 'trips/:id',
            builder: (context, state) =>
                TripDetailScreen(tripId: state.pathParameters['id']!),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.record,
        builder: (context, state) => const RecordScreen(),
      ),
    ],
  );
}
