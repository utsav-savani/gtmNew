import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'primary_aircraft.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class PrimaryAircraft extends Equatable {
  final String registrationNumber;
  final int mtow;
  final String mtowUnit;
  @JsonKey(name: 'AircraftType')
  final String aircraftType;
  final int aircraftId;

  const PrimaryAircraft({
    required this.aircraftId,
    required this.aircraftType,
    required this.mtow,
    required this.mtowUnit,
    required this.registrationNumber,
  });

  PrimaryAircraft copyWith({
    required int aircraftId,
  }) {
    return PrimaryAircraft(
      aircraftId: aircraftId,
      aircraftType: aircraftType,
      mtow: mtow,
      mtowUnit: mtowUnit,
      registrationNumber: registrationNumber,
    );
  }

  /// Deserializes the given [JsonMap] into a [Trip].
  static PrimaryAircraft fromJson(JsonMap json) =>
      _$PrimaryAircraftFromJson(json);

  /// Converts this [Trip] into a [JsonMap].
  JsonMap toJson() => _$PrimaryAircraftToJson(this);

  @override
  String toString() {
    return registrationNumber;
  }

  @override
  List<Object?> get props => [
        aircraftId,
        aircraftType,
        mtow,
        mtowUnit,
        registrationNumber,
      ];
}
