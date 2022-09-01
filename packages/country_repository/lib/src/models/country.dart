import 'package:country_repository/config/typedef_json.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Country extends Equatable {
  final int? countryId;
  final String? name;
  final String? countryName;
  final String? code;
  final String? code3;
  final String? currencyCode;
  final String? region;
  final String? capitalCity;
  final String? security;
  final String? emergencyPolice;
  final String? emergencyFire;
  final String? emergencyAmbulance;
  final String? notes;
  // final List<String>? languages;

  const Country({
    this.countryId,
    this.name,
    this.countryName,
    this.code,
    this.code3,
    this.currencyCode,
    this.region,
    this.capitalCity,
    this.emergencyAmbulance,
    this.emergencyFire,
    this.emergencyPolice,
    // this.languages,
    this.notes,
    this.security,
  });

  Country copyWith({
    required int countryId,
    required String name,
    required String code,
    required String code3,
    String? currencyCode,
    String? region,
    String? capitalCity,
    String? security,
    String? emergencyPolice,
    String? emergencyFire,
    String? emergencyAmbulance,
    String? notes,
    // List<String>? languages,
  }) {
    return Country(
      countryId: countryId,
      name: name,
      code: code,
      code3: code3,
      capitalCity: capitalCity,
      currencyCode: currencyCode,
      region: region,
      emergencyAmbulance: emergencyAmbulance,
      emergencyFire: emergencyFire,
      emergencyPolice: emergencyPolice,
      // // languages: languages,
      notes: notes,
      security: security,
    );
  }

  /// Deserializes the given [JsonMap] into a [Country].
  static Country fromJson(JsonMap json) => _$CountryFromJson(json);

  /// Converts this [Country] into a [JsonMap].
  JsonMap toJson() => _$CountryToJson(this);

  @override
  List<Object?> get props => [
        countryId,
        name,
        code,
        code3,
        capitalCity,
        currencyCode,
        region,
        emergencyAmbulance,
        emergencyFire,
        emergencyPolice,
        // languages,
        notes,
        security,
      ];
}
