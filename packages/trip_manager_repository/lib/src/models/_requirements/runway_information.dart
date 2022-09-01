import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';
import 'package:trip_manager_repository/src/models/_requirements/runway_surface.dart';

part 'runway_information.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class RunwayInformation extends Equatable {
  final int airportRunwayInfoId;
  final int airportId;
  @JsonKey(name: 'RWYID')
  final String? rWYID;
  final String? runwayLength;
  final String? runwayWidth;
  @JsonKey(name: 'PCN')
  final String? pCN;
  @JsonKey(name: 'RunwaySurface')
  final List<RunAwaySurface>? runwaySurface;

  const RunwayInformation({
    required this.airportRunwayInfoId,
    required this.airportId,
    this.rWYID,
    this.runwayLength,
    this.runwayWidth,
    this.pCN,
    this.runwaySurface,
  });

  RunwayInformation copyWith({
    required int airportRunwayInfoId,
    required int airportId,
    String? rWYID,
    String? runwayLength,
    String? runwayWidth,
    String? pCN,
    List<RunAwaySurface>? runwaySurface,
  }) {
    return RunwayInformation(
      airportRunwayInfoId: airportRunwayInfoId,
      airportId: airportId,
      rWYID: rWYID,
      runwayLength: runwayLength,
      runwayWidth: runwayWidth,
      pCN: pCN,
      runwaySurface: runwaySurface,
    );
  }

  /// Deserializes the given [JsonMap] into a [RunwayInformation].
  static RunwayInformation fromJson(JsonMap json) =>
      _$RunwayInformationFromJson(json);

  /// Converts this [RunwayInformation] into a [JsonMap].
  JsonMap toJson() => _$RunwayInformationToJson(this);

  @override
  List<Object?> get props => [
        airportRunwayInfoId,
        airportId,
        rWYID,
        runwayLength,
        runwayWidth,
        pCN,
        runwaySurface,
      ];
}
