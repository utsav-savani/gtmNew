import 'package:airport_repository/config/typedef_json.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'airport_country.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class AirportCountry extends Equatable {
  final int? countryId;
  final String? name;
  final String? code;
  final String? code3;
  final String? currencyCode;
  final String? security;
  final String? emergencyPolice;
  final String? emergencyAmbulance;
  final String? emergencyFire;
  final String? mondatoryVaccine;
  final String? routineVaccine;
  final String? recommendedVaccine;
  final String? warnings;
  final String? notes;
  @JsonKey(name: 'COVIDTesting')
  final String? covidTesting;
  final List<String>? officialLanguages;

  const AirportCountry({
    this.countryId,
    this.name,
    this.code,
    this.code3,
    this.currencyCode,
    this.security,
    this.emergencyPolice,
    this.emergencyAmbulance,
    this.emergencyFire,
    this.mondatoryVaccine,
    this.routineVaccine,
    this.recommendedVaccine,
    this.warnings,
    this.notes,
    this.covidTesting,
    this.officialLanguages,
  });

  AirportCountry copyWith({
    required int countryId,
    required String name,
    required String code,
    required String code3,
    String? currencyCode,
    String? security,
    String? emergencyPolice,
    String? emergencyAmbulance,
    String? emergencyFire,
    String? mondatoryVaccine,
    String? routineVaccine,
    String? recommendedVaccine,
    String? warnings,
    String? notes,
    String? covidTesting,
    List<String>? officialLanguages,
  }) {
    return AirportCountry(
      countryId: countryId,
      name: name,
      code: code,
      code3: code3,
      currencyCode: currencyCode,
      security: security,
      emergencyPolice: emergencyPolice,
      emergencyAmbulance: emergencyAmbulance,
      emergencyFire: emergencyFire,
      mondatoryVaccine: mondatoryVaccine,
      routineVaccine: routineVaccine,
      recommendedVaccine: recommendedVaccine,
      warnings: warnings,
      notes: notes,
      covidTesting: covidTesting,
      officialLanguages: officialLanguages,
    );
  }

  /// Deserializes the given [JsonMap] into a [AirportCountry].
  static AirportCountry fromJson(JsonMap json) => _$AirportCountryFromJson(json);

  /// Converts this [AirportCountry] into a [JsonMap].
  JsonMap toJson() => _$AirportCountryToJson(this);

  @override
  List<Object?> get props => [
        countryId,
        name,
        code,
        code3,
        currencyCode,
        security,
        emergencyPolice,
        emergencyAmbulance,
        emergencyFire,
        mondatoryVaccine,
        routineVaccine,
        recommendedVaccine,
        warnings,
        notes,
        covidTesting,
        officialLanguages,
      ];
}
