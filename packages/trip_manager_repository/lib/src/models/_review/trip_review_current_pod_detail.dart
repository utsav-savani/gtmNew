import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'trip_review_current_pod_detail.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripReviewCurrentPOBDetail extends Equatable {
  final String? depApt;
  final String? etd;
  final int? tripsequenceNumber;
  final List<TripReviewCurrentPOBDetailedDetail>? pobDetails;

  const TripReviewCurrentPOBDetail({
    this.depApt,
    this.etd,
    this.tripsequenceNumber,
    this.pobDetails,
  });

  TripReviewCurrentPOBDetail copyWith({required String name}) {
    return TripReviewCurrentPOBDetail(
      depApt: depApt,
      etd: etd,
      tripsequenceNumber: tripsequenceNumber,
      pobDetails: pobDetails,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripReviewCurrentPOBDetail].
  static TripReviewCurrentPOBDetail fromJson(JsonMap json) =>
      _$TripReviewCurrentPOBDetailFromJson(json);

  /// Converts this [TripReviewCurrentPOBDetail] into a [JsonMap].
  JsonMap toJson() => _$TripReviewCurrentPOBDetailToJson(this);

  @override
  List<Object?> get props => [
        depApt,
        etd,
        tripsequenceNumber,
        pobDetails,
      ];
}
