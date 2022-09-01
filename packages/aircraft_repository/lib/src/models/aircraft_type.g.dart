// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aircraft_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AircraftType _$AircraftTypeFromJson(Map<String, dynamic> json) => AircraftType(
      aircraftTypeId: json['aircraftTypeId'] as int?,
      fullName: json['fullName'] as String,
      iata: json['iata'] as String?,
      icao: json['icao'] as String?,
      abbreviation: json['abbreviation'] as String?,
      category: json['category'] as int?,
      mtow: (json['mtow'] as num?)?.toDouble(),
      mtowUnit: json['mtowUnit'] as String?,
      noiseCategory: json['noiseCategory'] as String?,
      referenceCode: json['referenceCode'] as String?,
      runwayFt: json['runwayFt'] as int?,
      seatCap: json['seatCap'] as int?,
    );

Map<String, dynamic> _$AircraftTypeToJson(AircraftType instance) =>
    <String, dynamic>{
      'aircraftTypeId': instance.aircraftTypeId,
      'fullName': instance.fullName,
      'iata': instance.iata,
      'icao': instance.icao,
      'abbreviation': instance.abbreviation,
      'category': instance.category,
      'mtow': instance.mtow,
      'mtowUnit': instance.mtowUnit,
      'noiseCategory': instance.noiseCategory,
      'referenceCode': instance.referenceCode,
      'runwayFt': instance.runwayFt,
      'seatCap': instance.seatCap,
    };
