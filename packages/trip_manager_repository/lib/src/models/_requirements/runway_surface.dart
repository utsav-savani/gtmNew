import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'runway_surface.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class RunAwaySurface extends Equatable {
  final int airportRunwaySurfaceId;
  final int airportRunwayInfoId;
  final String? runwaySurface;

  const RunAwaySurface({
    required this.airportRunwaySurfaceId,
    required this.airportRunwayInfoId,
    this.runwaySurface,
  });

  RunAwaySurface copyWith({
    required int airportRunwaySurfaceId,
    required int airportRunwayInfoId,
    String? runwaySurface,
  }) {
    return RunAwaySurface(
      airportRunwaySurfaceId: airportRunwaySurfaceId,
      airportRunwayInfoId: airportRunwayInfoId,
      runwaySurface: runwaySurface,
    );
  }

  /// Deserializes the given [JsonMap] into a [RunAwaySurface].
  static RunAwaySurface fromJson(JsonMap json) =>
      _$RunAwaySurfaceFromJson(json);

  /// Converts this [RunAwaySurface] into a [JsonMap].
  JsonMap toJson() => _$RunAwaySurfaceToJson(this);

  @override
  List<Object?> get props => [
        airportRunwaySurfaceId,
        airportRunwayInfoId,
        runwaySurface,
      ];
}
