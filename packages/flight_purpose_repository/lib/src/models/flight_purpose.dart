import 'package:equatable/equatable.dart';
import 'package:flight_purpose_repository/config/typedef_json.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flight_purpose.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class FlightPurpose extends Equatable {
  final int flightPurposeId;
  final String flightPurpose;

  const FlightPurpose({
    required this.flightPurposeId,
    required this.flightPurpose,
  });

  FlightPurpose copyWith({
    required int flightPurposeId,
    int? customerId,
    required String flightPurpose,
  }) {
    return FlightPurpose(
      flightPurposeId: flightPurposeId,
      flightPurpose: flightPurpose,
    );
  }

  /// Deserializes the given [JsonMap] into a [FlightPurpose].
  static FlightPurpose fromJson(JsonMap json) => _$FlightPurposeFromJson(json);

  /// Converts this [FlightPurpose] into a [JsonMap].
  JsonMap toJson() => _$FlightPurposeToJson(this);

  @override
  List<Object?> get props => [flightPurposeId, flightPurpose];
}
