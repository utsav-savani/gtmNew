// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'runway_approach.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RunwayApproach _$RunwayApproachFromJson(Map<String, dynamic> json) =>
    RunwayApproach(
      airportApproachId: json['airportApproachId'] as int,
      airportId: json['airportId'] as int,
      runwayApproach: json['runwayApproach'] as String?,
    );

Map<String, dynamic> _$RunwayApproachToJson(RunwayApproach instance) =>
    <String, dynamic>{
      'airportApproachId': instance.airportApproachId,
      'airportId': instance.airportId,
      'runwayApproach': instance.runwayApproach,
    };
