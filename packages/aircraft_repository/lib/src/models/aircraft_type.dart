import 'package:aircraft_repository/config/typedef_json.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aircraft_type.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class AircraftType extends Equatable {
  final int? aircraftTypeId;
  final String fullName;
  final String? iata;
  final String? icao;
  final String? abbreviation;
  final int? category;
  final double? mtow;
  final String? mtowUnit;
  final String? noiseCategory;
  final String? referenceCode;
  final int? runwayFt;
  final int? seatCap;

  const AircraftType({
    required this.aircraftTypeId,
    required this.fullName,
    required this.iata,
    required this.icao,
    this.abbreviation,
    this.category,
    this.mtow,
    this.mtowUnit,
    this.noiseCategory,
    this.referenceCode,
    this.runwayFt,
    this.seatCap,
  });

  AircraftType copyWith({
    int? aircraftTypeId,
    required String fullName,
    String? iata,
    String? icao,
    required String abbreviation,
  }) {
    return AircraftType(
      aircraftTypeId: aircraftTypeId,
      fullName: fullName,
      iata: iata,
      icao: icao,
      abbreviation: abbreviation,
    );
  }

  /// Deserializes the given [JsonMap] into a [AircraftType].
  static AircraftType fromJson(JsonMap json) => _$AircraftTypeFromJson(json);

  /// Converts this [AircraftType] into a [JsonMap].
  JsonMap toJson() => _$AircraftTypeToJson(this);

  @override
  List<Object?> get props =>
      [aircraftTypeId, fullName, iata, icao, abbreviation];
}
