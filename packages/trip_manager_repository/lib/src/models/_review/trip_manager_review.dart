import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'trip_manager_review.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripManagerReview extends Equatable {
  final String? tripNumber;
  final int? officeId;
  final String? customer;
  final String? operator;
  final String? createdBy;
  final String? requested;
  final String? reference;
  final String? acReg;
  final String? acType;
  final String? mtow;
  final String? timeFormat;
  final String? fileName;
  final List<TripReviewSubaircraft> subAircrafts;
  final List<TripReviewFlightDetail> flightDetails;
  final List<TripReviewCurrentServiceSummary> currentServiceSummary;
  final List<TripReviewCurrentPOBDetail> currentPOBDetails;

  const TripManagerReview({
    required this.tripNumber,
    required this.acReg,
    required this.acType,
    required this.createdBy,
    required this.customer,
    required this.mtow,
    required this.officeId,
    required this.operator,
    required this.reference,
    required this.requested,
    this.timeFormat,
    required this.subAircrafts,
    required this.flightDetails,
    required this.currentServiceSummary,
    required this.currentPOBDetails,
    this.fileName,
  });

  TripManagerReview copyWith({
    required String tripNumber,
    required String acReg,
    required String acType,
    required String createdBy,
    required String customer,
    required String mtow,
    required int officeId,
    required String operator,
    required String reference,
    required String requested,
    String? timeFormat,
    required List<TripReviewSubaircraft> subAircrafts,
    required List<TripReviewFlightDetail> flightDetails,
    required List<TripReviewCurrentServiceSummary> currentServiceSummary,
    required List<TripReviewCurrentPOBDetail> currentPOBDetails,
    String? fileName,
  }) {
    return TripManagerReview(
      tripNumber: tripNumber,
      acReg: acReg,
      acType: acType,
      createdBy: createdBy,
      customer: customer,
      mtow: mtow,
      officeId: officeId,
      operator: operator,
      reference: reference,
      requested: requested,
      timeFormat: timeFormat,
      subAircrafts: subAircrafts,
      flightDetails: flightDetails,
      currentServiceSummary: currentServiceSummary,
      currentPOBDetails: currentPOBDetails,
      fileName: fileName,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripManagerReview].
  static TripManagerReview fromJson(JsonMap json) =>
      _$TripManagerReviewFromJson(json);

  /// Converts this [TripManagerReview] into a [JsonMap].
  JsonMap toJson() => _$TripManagerReviewToJson(this);

  @override
  List<Object?> get props => [
        tripNumber,
        acReg,
        acType,
        createdBy,
        customer,
        mtow,
        officeId,
        operator,
        reference,
        requested,
        subAircrafts,
        flightDetails,
        currentServiceSummary,
        currentPOBDetails,
        fileName,
      ];
}
