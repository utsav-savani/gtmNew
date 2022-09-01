import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'alternative_airport.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class AlternativeAirport extends Equatable {
  final int primaryAirportId;
  final int airportId;

  const AlternativeAirport({
    required this.primaryAirportId,
    required this.airportId,
  });

  AlternativeAirport copyWith({
    required int primaryAirportId,
    required int airportId,
  }) {
    return AlternativeAirport(
      primaryAirportId: primaryAirportId,
      airportId: airportId,
    );
  }

  /// Deserializes the given [JsonMap] into a [AlternativeAirport].
  static AlternativeAirport fromJson(JsonMap json) =>
      _$AlternativeAirportFromJson(json);

  /// Converts this [AlternativeAirport] into a [JsonMap].
  JsonMap toJson() => _$AlternativeAirportToJson(this);

  @override
  List<Object?> get props => [
        primaryAirportId,
        airportId,
      ];
}
