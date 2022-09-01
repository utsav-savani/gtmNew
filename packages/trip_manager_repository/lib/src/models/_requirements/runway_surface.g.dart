// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'runway_surface.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RunAwaySurface _$RunAwaySurfaceFromJson(Map<String, dynamic> json) =>
    RunAwaySurface(
      airportRunwaySurfaceId: json['airportRunwaySurfaceId'] as int,
      airportRunwayInfoId: json['airportRunwayInfoId'] as int,
      runwaySurface: json['runwaySurface'] as String?,
    );

Map<String, dynamic> _$RunAwaySurfaceToJson(RunAwaySurface instance) =>
    <String, dynamic>{
      'airportRunwaySurfaceId': instance.airportRunwaySurfaceId,
      'airportRunwayInfoId': instance.airportRunwayInfoId,
      'runwaySurface': instance.runwaySurface,
    };
