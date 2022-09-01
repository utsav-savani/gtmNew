import 'package:aircraft_repository/config/typedef_json.dart';
import 'package:aircraft_repository/src/models/aircraft_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aircraft.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Aircraft extends Equatable {
  final int aircraftId;
  final String registrationNumber;
  final int? mtow;
  final String? mtowUnit;
  @JsonKey(name: 'AircraftType')
  final AircraftType? aircraftType;
  final int? regCountryId;

  //TODO: Safi, once nithesh completed the mtowType and mtowvalue then integrate in the modal
  //TODO: Merge Primary aircraft and aircraft

  const Aircraft(
      {required this.aircraftId,
      required this.registrationNumber,
      this.mtow,
      this.mtowUnit,
      this.aircraftType,
      this.regCountryId});

  Aircraft copyWith({
    required int aircraftId,
    required String registrationNumber,
    int? mtow,
    String? mtowUnit,
  }) {
    return Aircraft(
      aircraftId: aircraftId,
      registrationNumber: registrationNumber,
      aircraftType: aircraftType,
      mtow: mtow,
      mtowUnit: mtowUnit,
    );
  }

  /// Deserializes the given [JsonMap] into a [Aircraft].
  static Aircraft fromJson(JsonMap json) => _$AircraftFromJson(json);

  /// Converts this [Aircraft] into a [JsonMap].
  JsonMap toJson() => _$AircraftToJson(this);

  @override
  String toString() {
    if (aircraftType != null) {
      return '${registrationNumber}(${aircraftType!.fullName})';
    }
    return '${registrationNumber}';
  }

  @override
  List<Object?> get props => [
        aircraftId,
        registrationNumber,
        aircraftType,
        mtow,
        mtowUnit,
        regCountryId
      ];
}
