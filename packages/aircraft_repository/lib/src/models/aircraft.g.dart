// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aircraft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Aircraft _$AircraftFromJson(Map<String, dynamic> json) => Aircraft(
      aircraftId: json['aircraftId'] as int,
      registrationNumber: json['registrationNumber'] as String,
      mtow: json['mtow'] as int?,
      mtowUnit: json['mtowUnit'] as String?,
      aircraftType: json['AircraftType'] == null
          ? null
          : AircraftType.fromJson(json['AircraftType'] as Map<String, dynamic>),
      regCountryId: json['regCountryId'] as int?,
    );

Map<String, dynamic> _$AircraftToJson(Aircraft instance) => <String, dynamic>{
      'aircraftId': instance.aircraftId,
      'registrationNumber': instance.registrationNumber,
      'mtow': instance.mtow,
      'mtowUnit': instance.mtowUnit,
      'AircraftType': instance.aircraftType?.toJson(),
      'regCountryId': instance.regCountryId,
    };
