import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'airport_detail_country.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class AirportDetailCountry extends Equatable {
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
  @JsonKey(name: 'COVIDTesting')
  final String? cOVIDTesting;
  final List<dynamic>? officialLanguages;

  const AirportDetailCountry({
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
    this.cOVIDTesting,
    this.officialLanguages,
  });

  AirportDetailCountry copyWith({
    int? countryId,
    String? name,
    String? code,
    String? code3,
    String? currencyCode,
    String? security,
    String? emergencyPolice,
    String? emergencyAmbulance,
    String? emergencyFire,
    String? mondatoryVaccine,
    String? routineVaccine,
    String? recommendedVaccine,
    String? warnings,
    String? cOVIDTesting,
    List<dynamic>? officialLanguages,
  }) {
    return AirportDetailCountry(
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
      cOVIDTesting: cOVIDTesting,
      officialLanguages: officialLanguages,
    );
  }

  /// Deserializes the given [JsonMap] into a [AirportDetailCountry].
  static AirportDetailCountry fromJson(JsonMap json) =>
      _$AirportDetailCountryFromJson(json);

  /// Converts this [AirportDetailCountry] into a [JsonMap].
  JsonMap toJson() => _$AirportDetailCountryToJson(this);

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
        cOVIDTesting,
        officialLanguages,
      ];
}
