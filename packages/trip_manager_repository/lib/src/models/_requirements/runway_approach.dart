import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'runway_approach.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class RunwayApproach extends Equatable {
  final int airportApproachId;
  final int airportId;
  final String? runwayApproach;

  const RunwayApproach({
    required this.airportApproachId,
    required this.airportId,
    this.runwayApproach,
  });

  RunwayApproach copyWith({
    required int airportApproachId,
    required int airportId,
    String? runwayApproach,
  }) {
    return RunwayApproach(
      airportApproachId: airportApproachId,
      airportId: airportId,
      runwayApproach: runwayApproach,
    );
  }


  @override
  String toString() {
    return runwayApproach??'';
  }

  /// Deserializes the given [JsonMap] into a [RunwayApproach].
  static RunwayApproach fromJson(JsonMap json) =>
      _$RunwayApproachFromJson(json);

  /// Converts this [RunwayApproach] into a [JsonMap].
  JsonMap toJson() => _$RunwayApproachToJson(this);

  @override
  List<Object?> get props => [
        airportApproachId,
        airportId,
        runwayApproach,
      ];
}
