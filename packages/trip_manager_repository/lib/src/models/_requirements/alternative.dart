import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';
import 'package:trip_manager_repository/src/models/_requirements/alternative_airport.dart';

part 'alternative.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Alternative extends Equatable {
  final int airportId;
  final String? iata;
  final String? icao;
  final String? name;
  final bool? aoe;
  final bool? civil;
  final bool? military;
  final bool? customs;
  final bool? slots;
  final bool? ppr;
  @JsonKey(name: 'H24')
  final bool? h24;
  @JsonKey(name: 'AirportFromHours')
  final String? airportFromHours;
  @JsonKey(name: 'AirportToHours')
  final String? airportToHours;
  @JsonKey(name: 'AlternativeAirport')
  final AlternativeAirport? alternativeAirport;

  const Alternative({
    required this.airportId,
    this.iata,
    this.airportFromHours,
    this.airportToHours,
    this.alternativeAirport,
    this.aoe,
    this.civil,
    this.customs,
    this.h24,
    this.icao,
    this.military,
    this.name,
    this.ppr,
    this.slots,
  });

  Alternative copyWith({
    required int airportId,
    String? iata,
    String? icao,
    String? name,
    bool? aoe,
    bool? civil,
    bool? military,
    bool? customs,
    bool? slots,
    bool? ppr,
    bool? h24,
    String? airportFromHours,
    String? airportToHours,
    AlternativeAirport? alternativeAirport,
  }) {
    return Alternative(
      airportId: airportId,
      iata: iata,
      icao: icao,
      name: name,
      aoe: aoe,
      civil: civil,
      military: military,
      customs: customs,
      slots: slots,
      ppr: ppr,
      h24: h24,
      airportFromHours: airportFromHours,
      airportToHours: airportToHours,
      alternativeAirport: alternativeAirport,
    );
  }

  /// Deserializes the given [JsonMap] into a [Alternative].
  static Alternative fromJson(JsonMap json) => _$AlternativeFromJson(json);

  /// Converts this [Alternative] into a [JsonMap].
  JsonMap toJson() => _$AlternativeToJson(this);

  @override
  List<Object?> get props => [
        airportId,
        iata,
        icao,
        name,
        aoe,
        civil,
        military,
        customs,
        slots,
        ppr,
        h24,
        airportFromHours,
        airportToHours,
        alternativeAirport,
      ];
}
