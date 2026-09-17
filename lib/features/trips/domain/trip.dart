import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:journey/core/db/tables.dart' show MatchStatus, TripStatus;

part 'trip.freezed.dart';
part 'trip.g.dart';

/// Immutable domain model for a saved drive (PLAN.md §4.3).
/// Units: metres, seconds, m/s. Times are UTC instants.
@freezed
abstract class Trip with _$Trip {
  const factory({
    required String id,
    required DateTime startedAt,
    required TripStatus status,
    required DateTime createdAt,
    DateTime? endedAt,
    MatchStatus? matchStatus,
    @Default(0) double distanceM,
    @Default(0) int durationS,
    @Default(0) int movingS,
    double? avgSpeedMps,
    double? maxSpeedMps,
    double? startLat,
    double? startLon,
    double? endLat,
    double? endLon,
    String? startPlace,
    String? endPlace,
    String? rawPolyline6,
    String? matchedPolyline6,
  }) = _Trip;

  factory fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
}
