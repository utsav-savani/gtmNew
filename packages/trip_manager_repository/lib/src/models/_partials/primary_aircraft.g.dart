// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'primary_aircraft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrimaryAircraft _$PrimaryAircraftFromJson(Map<String, dynamic> json) =>
    PrimaryAircraft(
      aircraftId: json['aircraftId'] as int,
      aircraftType: json['AircraftType'] as String,
      mtow: json['mtow'] as int,
      mtowUnit: json['mtowUnit'] as String,
      registrationNumber: json['registrationNumber'] as String,
    );

Map<String, dynamic> _$PrimaryAircraftToJson(PrimaryAircraft instance) =>
    <String, dynamic>{
      'registrationNumber': instance.registrationNumber,
      'mtow': instance.mtow,
      'mtowUnit': instance.mtowUnit,
      'AircraftType': instance.aircraftType,
      'aircraftId': instance.aircraftId,
    };
