import 'package:country_repository/config/typedef_json.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sanction.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Sanction extends Equatable {
  final String startDate;
  final String? endDate;
  final List<String>? details;
  final List<String>? adopter;
  final bool? sancNone;
  final bool? sancFlights;
  final bool? sancTravel;
  final bool? sancCargo;
  final bool? sancFinancial;
  final bool? sancVesel;
  final bool? sancOther;
  final String? sancOtherNote;
  final String? sancNote;

  const Sanction({
    required this.startDate,
    this.endDate,
    this.details,
    this.adopter,
    this.sancNone,
    this.sancFlights,
    this.sancTravel,
    this.sancCargo,
    this.sancFinancial,
    this.sancVesel,
    this.sancOther,
    this.sancOtherNote,
    this.sancNote,
  });

  Sanction copyWith({
    required String startDate,
    String? endDate,
    List<String>? details,
    List<String>? adopter,
    bool? sancNone,
    bool? sancFlights,
    bool? sancTravel,
    bool? sancCargo,
    bool? sancFinancial,
    bool? sancVesel,
    bool? sancOther,
    String? sancOtherNote,
    String? sancNote,
  }) {
    return Sanction(
      startDate: startDate,
      endDate: endDate,
      details: details,
      adopter: adopter,
      sancNone: sancNone,
      sancFlights: sancFlights,
      sancTravel: sancTravel,
      sancCargo: sancCargo,
      sancFinancial: sancFinancial,
      sancVesel: sancVesel,
      sancOther: sancOther,
      sancOtherNote: sancOtherNote,
      sancNote: sancNote,
    );
  }

  /// Deserializes the given [JsonMap] into a [Sanction].
  static Sanction fromJson(JsonMap json) => _$SanctionFromJson(json);

  /// Converts this [Sanction] into a [JsonMap].
  JsonMap toJson() => _$SanctionToJson(this);

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        details,
        adopter,
        sancNone,
        sancFlights,
        sancTravel,
        sancCargo,
        sancFinancial,
        sancVesel,
        sancOther,
        sancOtherNote,
        sancNote,
      ];
}
