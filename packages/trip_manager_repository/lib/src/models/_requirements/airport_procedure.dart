import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'airport_procedure.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class AirportProcedure extends Equatable {
  final int id;
  final int airportId;
  final String? businessType;
  final String? type;
  final String? notes;

  const AirportProcedure({
    required this.id,
    required this.airportId,
    this.businessType,
    this.type,
    this.notes,
  });

  AirportProcedure copyWith({
    required int id,
    required int airportId,
    String? businessType,
    String? type,
    String? notes,
  }) {
    return AirportProcedure(
      id: id,
      airportId: airportId,
      businessType: businessType,
      type: type,
      notes: notes,
    );
  }

  /// Deserializes the given [JsonMap] into a [AirportProcedure].
  static AirportProcedure fromJson(JsonMap json) =>
      _$AirportProcedureFromJson(json);

  /// Converts this [AirportProcedure] into a [JsonMap].
  JsonMap toJson() => _$AirportProcedureToJson(this);

  @override
  List<Object?> get props => [
        id,
        airportId,
        businessType,
        type,
        notes,
      ];
}
