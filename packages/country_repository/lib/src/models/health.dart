import 'package:country_repository/config/typedef_json.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'health.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Health extends Equatable {
  final int? countryId;
  final String? name;
  final String? mondatoryVaccine;
  final String? routineVaccine;
  final String? recommendedVaccine;
  final String? warnings;
  @JsonKey(name: 'COVIDTesting')
  final String? cOVIDTesting;

  const Health({
    required this.countryId,
    required this.name,
    this.mondatoryVaccine,
    this.routineVaccine,
    this.recommendedVaccine,
    this.warnings,
    this.cOVIDTesting,
  });

  Health copyWith({
    required int countryId,
    required String name,
    String? mondatoryVaccine,
    String? routineVaccine,
    String? recommendedVaccine,
    String? warnings,
    String? cOVIDTesting,
  }) {
    return Health(
      countryId: countryId,
      name: name,
      mondatoryVaccine: mondatoryVaccine,
      routineVaccine: routineVaccine,
      recommendedVaccine: recommendedVaccine,
      warnings: warnings,
      cOVIDTesting: cOVIDTesting,
    );
  }

  /// Deserializes the given [JsonMap] into a [Health].
  static Health fromJson(JsonMap json) => _$HealthFromJson(json);

  /// Converts this [Health] into a [JsonMap].
  JsonMap toJson() => _$HealthToJson(this);

  @override
  List<Object?> get props => [
        countryId,
        name,
        mondatoryVaccine,
        routineVaccine,
        recommendedVaccine,
        warnings,
        cOVIDTesting,
      ];
}
