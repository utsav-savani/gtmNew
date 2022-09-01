import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'trip_review_current_service_summary.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripReviewCurrentServiceSummary extends Equatable {
  final String? departure;
  final String? arrival;
  final int? index;
  final String? total;
  final List<TripReviewCurrentServiceDetail>? serviceDetails;

  const TripReviewCurrentServiceSummary({
    this.departure,
    this.arrival,
    this.index,
    this.total,
    this.serviceDetails,
  });

  TripReviewCurrentServiceSummary copyWith({required String name}) {
    return TripReviewCurrentServiceSummary(
      departure: departure,
      arrival: arrival,
      index: index,
      total: total,
      serviceDetails: serviceDetails,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripReviewCurrentServiceSummary].
  static TripReviewCurrentServiceSummary fromJson(JsonMap json) =>
      _$TripReviewCurrentServiceSummaryFromJson(json);

  /// Converts this [TripReviewCurrentServiceSummary] into a [JsonMap].
  JsonMap toJson() => _$TripReviewCurrentServiceSummaryToJson(this);

  @override
  List<Object?> get props => [
        departure,
        arrival,
        index,
        total,
        serviceDetails,
      ];
}
