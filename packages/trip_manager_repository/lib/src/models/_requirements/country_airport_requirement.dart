import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'country_airport_requirement.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class CountryAirportRequirement extends Equatable {
  final String? through;
  final String? leadTime;
  final String? permValidity;
  final bool? fplMatch;
  final bool? reqSpecPermit;
  final bool? docsRequired;
  final bool? isOnline;
  final String? notes;
  final List<String>? flightCategories;
  final List<String>? services;

  const CountryAirportRequirement({
    this.through,
    this.leadTime,
    this.permValidity,
    this.flightCategories,
    this.services,
    this.fplMatch,
    this.reqSpecPermit,
    this.docsRequired,
    this.isOnline,
    this.notes,
  });

  CountryAirportRequirement copyWith({
    String? through,
    String? leadTime,
    String? permValidity,
    bool? fplMatch,
    bool? reqSpecPermit,
    bool? docsRequired,
    bool? isOnline,
    String? notes,
    List<String>? flightCategories,
    List<String>? services,
  }) {
    return CountryAirportRequirement(
      through: through,
      leadTime: leadTime,
      permValidity: permValidity,
      fplMatch: fplMatch,
      reqSpecPermit: reqSpecPermit,
      docsRequired: docsRequired,
      isOnline: isOnline,
      notes: notes,
      flightCategories: flightCategories,
      services: services,
    );
  }

  /// Deserializes the given [JsonMap] into a [CountryAirportRequirement].
  static CountryAirportRequirement fromJson(JsonMap json) =>
      _$CountryAirportRequirementFromJson(json);

  /// Converts this [CountryAirportRequirement] into a [JsonMap].
  JsonMap toJson() => _$CountryAirportRequirementToJson(this);

  @override
  List<Object?> get props => [
        through,
        leadTime,
        permValidity,
        fplMatch,
        reqSpecPermit,
        docsRequired,
        isOnline,
        notes,
        flightCategories,
        services,
      ];
}
