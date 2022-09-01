import 'package:airport_repository/airport_repository.dart';
import 'package:airport_repository/config/typedef_json.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'airport.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Airport extends Equatable {
  final int airportId;
  final int? countryId;
  final String? timezone;
  final bool? h24;
  final String name;
  final String? iata;
  final String? icao;
  final bool? aoe;
  @JsonKey(name: 'AirportFromHours')
  final String? airportFromHours;
  @JsonKey(name: 'AirportToHours')
  final String? airportToHours;
  @JsonKey(name: 'UASPartnerAgent')
  final String? uASPartnerAgent;
  final String? displayOffset;
  final String? operatingHours;
  final String? countryName;
  final String? code;
  final String? code3;
  final String? city;
  @JsonKey(name: 'AirportCity')
  final AirportCity? airportCity;

  const Airport({
    required this.airportId,
    this.countryId,
    required this.name,
    this.iata,
    this.icao,
    this.h24,
    this.timezone,
    this.city,
    this.airportFromHours,
    this.airportToHours,
    this.aoe,
    this.code,
    this.code3,
    this.countryName,
    this.displayOffset,
    this.operatingHours,
    this.uASPartnerAgent,
    this.airportCity,
  });

  Airport copyWith({
    required int airportId,
    int? countryId,
    required String name,
    bool? aoe,
    String? fullName,
    String? iata,
    bool? h24,
    String? icao,
    String? timezone,
    String? airportFromHours,
    String? airportToHours,
    String? uASPartnerAgent,
    String? countryName,
    String? code,
    String? code3,
    String? displayOffset,
    String? operatingHours,
    String? city,
    AirportCity? airportCity,
  }) {
    return Airport(
      airportId: airportId,
      countryId: countryId,
      name: name,
      aoe: aoe,
      iata: iata,
      h24: h24,
      icao: icao,
      timezone: timezone,
      airportFromHours: airportFromHours,
      airportToHours: airportToHours,
      uASPartnerAgent: uASPartnerAgent,
      countryName: countryName,
      code: code,
      code3: code3,
      city: city,
      displayOffset: displayOffset,
      operatingHours: operatingHours,
      airportCity: airportCity,
    );
  }

  /// Deserializes the given [JsonMap] into a [Airport].
  static Airport fromJson(JsonMap json) => _$AirportFromJson(json);

  /// Converts this [Airport] into a [JsonMap].
  JsonMap toJson() => _$AirportToJson(this);

  @override
  List<Object?> get props => [
        airportId,
        countryId,
        name,
        aoe,
        iata,
        icao,
        timezone,
        airportFromHours,
        airportToHours,
        uASPartnerAgent,
        countryName,
        code,
        code3,
        city,
        displayOffset,
        operatingHours,
        city,
        airportCity
      ];
}
