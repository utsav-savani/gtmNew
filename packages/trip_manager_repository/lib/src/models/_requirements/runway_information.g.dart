// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'runway_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RunwayInformation _$RunwayInformationFromJson(Map<String, dynamic> json) =>
    RunwayInformation(
      airportRunwayInfoId: json['airportRunwayInfoId'] as int,
      airportId: json['airportId'] as int,
      rWYID: json['RWYID'] as String?,
      runwayLength: json['runwayLength'] as String?,
      runwayWidth: json['runwayWidth'] as String?,
      pCN: json['PCN'] as String?,
      runwaySurface: (json['RunwaySurface'] as List<dynamic>?)
          ?.map((e) => RunAwaySurface.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RunwayInformationToJson(RunwayInformation instance) =>
    <String, dynamic>{
      'airportRunwayInfoId': instance.airportRunwayInfoId,
      'airportId': instance.airportId,
      'RWYID': instance.rWYID,
      'runwayLength': instance.runwayLength,
      'runwayWidth': instance.runwayWidth,
      'PCN': instance.pCN,
      'RunwaySurface': instance.runwaySurface?.map((e) => e.toJson()).toList(),
    };
