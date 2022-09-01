import 'package:country_repository/config/typedef_json.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flight_requirement.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class FlightRequirement extends Equatable {
  final List<String>? flightCategories;
  final List<String>? services;
  final String? through;
  final String? leadTime;
  final String? permValidity;
  final String? specFormRequired;
  final bool? fplMatch;
  final bool? reqSpecPermit;
  final bool? docsRequired;
  final bool? isOnline;
  final String? notes;

  const FlightRequirement({
    this.docsRequired,
    this.through,
    this.leadTime,
    this.permValidity,
    this.specFormRequired,
    this.fplMatch,
    this.reqSpecPermit,
    this.isOnline,
    this.notes,
    this.flightCategories,
    this.services,
  });

  FlightRequirement copyWith({
    List<String>? flightCategories,
    List<String>? services,
    String? through,
    String? leadTime,
    String? permValidity,
    String? specFormRequired,
    bool? fplMatch,
    bool? reqSpecPermit,
    bool? docsRequired,
    bool? isOnline,
    String? notes,
  }) {
    return FlightRequirement(
      docsRequired: docsRequired,
      through: through,
      leadTime: leadTime,
      permValidity: permValidity,
      specFormRequired: specFormRequired,
      fplMatch: fplMatch,
      reqSpecPermit: reqSpecPermit,
      isOnline: isOnline,
      notes: notes,
      flightCategories: flightCategories,
      services: services,
    );
  }

  /// Deserializes the given [JsonMap] into a [FlightRequirement].
  static FlightRequirement fromJson(JsonMap json) =>
      _$FlightRequirementFromJson(json);

  /// Converts this [FlightRequirement] into a [JsonMap].
  JsonMap toJson() => _$FlightRequirementToJson(this);

  @override
  List<Object?> get props => [
        docsRequired,
        through,
        leadTime,
        permValidity,
        specFormRequired,
        fplMatch,
        reqSpecPermit,
        isOnline,
        notes,
        flightCategories,
        services,
      ];
}
