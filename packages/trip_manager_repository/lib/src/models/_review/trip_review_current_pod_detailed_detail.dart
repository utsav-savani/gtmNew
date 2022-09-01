import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'trip_review_current_pod_detailed_detail.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripReviewCurrentPOBDetailedDetail extends Equatable {
  final String? surName;
  final String? givenName;
  final String? dob;
  final String? passport;
  final String? nationality;
  final String? type;

  const TripReviewCurrentPOBDetailedDetail({
    this.surName,
    this.givenName,
    this.dob,
    this.passport,
    this.nationality,
    this.type,
  });

  TripReviewCurrentPOBDetailedDetail copyWith({required String name}) {
    return TripReviewCurrentPOBDetailedDetail(
      surName: surName,
      givenName: givenName,
      dob: dob,
      passport: passport,
      nationality: nationality,
      type: type,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripReviewCurrentPOBDetailedDetail].
  static TripReviewCurrentPOBDetailedDetail fromJson(JsonMap json) =>
      _$TripReviewCurrentPOBDetailedDetailFromJson(json);

  /// Converts this [TripReviewCurrentPOBDetailedDetail] into a [JsonMap].
  JsonMap toJson() => _$TripReviewCurrentPOBDetailedDetailToJson(this);

  @override
  List<Object?> get props => [
        surName,
        givenName,
        dob,
        passport,
        nationality,
        type,
      ];
}
