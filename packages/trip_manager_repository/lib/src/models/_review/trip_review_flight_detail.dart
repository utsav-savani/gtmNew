import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'trip_review_flight_detail.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripReviewFlightDetail extends Equatable {
  final String? depApt;
  final String? arrApt;
  final String? callSign;
  final String? flightCategory;
  final String? purpose;
  final String? sectorSts;
  final String? etd;
  final String? eta;
  final String? etdFormat;

  const TripReviewFlightDetail({
    required this.arrApt,
    required this.callSign,
    required this.depApt,
    required this.eta,
    required this.etd,
    required this.etdFormat,
    required this.flightCategory,
    required this.purpose,
    required this.sectorSts,
  });

  TripReviewFlightDetail copyWith({required String name}) {
    return TripReviewFlightDetail(
      arrApt: arrApt,
      callSign: callSign,
      depApt: depApt,
      eta: eta,
      etd: etd,
      etdFormat: etdFormat,
      flightCategory: flightCategory,
      purpose: purpose,
      sectorSts: sectorSts,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripReviewFlightDetail].
  static TripReviewFlightDetail fromJson(JsonMap json) =>
      _$TripReviewFlightDetailFromJson(json);

  /// Converts this [TripReviewFlightDetail] into a [JsonMap].
  JsonMap toJson() => _$TripReviewFlightDetailToJson(this);

  @override
  List<Object?> get props => [
        arrApt,
        callSign,
        depApt,
        eta,
        etd,
        etdFormat,
        flightCategory,
        purpose,
        sectorSts,
      ];
}
