import 'package:country_repository/config/typedef_json.dart';
import 'package:country_repository/src/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'passport_visa.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class PassportVisa extends Equatable {
  final int id;
  final int fromCountryId;
  final int toCountryId;
  final String crewPassport;
  final String crewVISA;
  final String passengerPassport;
  final String passengerVISA;
  final Country originCountry;
  final Country toCountry;

  const PassportVisa({
    required this.id,
    required this.fromCountryId,
    required this.toCountryId,
    required this.crewPassport,
    required this.crewVISA,
    required this.passengerPassport,
    required this.passengerVISA,
    required this.originCountry,
    required this.toCountry,
  });

  PassportVisa copyWith({
    required int id,
    required int fromCountryId,
    required int toCountryId,
    required String crewPassport,
    required String crewVISA,
    required String passengerPassport,
    required String passengerVISA,
    required Country originCountry,
    required Country toCountry,
  }) {
    return PassportVisa(
      id: id,
      fromCountryId: fromCountryId,
      toCountryId: toCountryId,
      crewPassport: crewPassport,
      crewVISA: crewVISA,
      passengerPassport: passengerPassport,
      passengerVISA: passengerVISA,
      originCountry: originCountry,
      toCountry: toCountry,
    );
  }

  /// Deserializes the given [JsonMap] into a [PassportVisa].
  static PassportVisa fromJson(JsonMap json) => _$PassportVisaFromJson(json);

  /// Converts this [PassportVisa] into a [JsonMap].
  JsonMap toJson() => _$PassportVisaToJson(this);

  @override
  List<Object?> get props => [
        id,
        fromCountryId,
        toCountryId,
        crewPassport,
        crewVISA,
        passengerPassport,
        passengerVISA,
        originCountry,
        toCountry,
      ];
}
