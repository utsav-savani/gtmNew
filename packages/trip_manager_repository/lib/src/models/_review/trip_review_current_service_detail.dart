import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'trip_review_current_service_detail.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripReviewCurrentServiceDetail extends Equatable {
  final String? serviceType;
  final String? location;
  final String? seq;
  final String? countryOrLoc;
  final String? on;
  final String? payment;
  final String? through;
  final String? billable;

  const TripReviewCurrentServiceDetail({
    this.serviceType,
    this.location,
    this.seq,
    this.countryOrLoc,
    this.on,
    this.payment,
    this.through,
    this.billable,
  });

  TripReviewCurrentServiceDetail copyWith({required String name}) {
    return TripReviewCurrentServiceDetail(
      serviceType: serviceType,
      location: location,
      seq: seq,
      countryOrLoc: countryOrLoc,
      on: on,
      payment: payment,
      through: through,
      billable: billable,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripReviewCurrentServiceDetail].
  static TripReviewCurrentServiceDetail fromJson(JsonMap json) =>
      _$TripReviewCurrentServiceDetailFromJson(json);

  /// Converts this [TripReviewCurrentServiceDetail] into a [JsonMap].
  JsonMap toJson() => _$TripReviewCurrentServiceDetailToJson(this);

  @override
  List<Object?> get props => [
        serviceType,
        location,
        seq,
        countryOrLoc,
        on,
        payment,
        through,
        billable,
      ];
}
