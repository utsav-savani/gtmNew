// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_detail_country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirportDetailCountry _$AirportDetailCountryFromJson(
        Map<String, dynamic> json) =>
    AirportDetailCountry(
      countryId: json['countryId'] as int?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      code3: json['code3'] as String?,
      currencyCode: json['currencyCode'] as String?,
      security: json['security'] as String?,
      emergencyPolice: json['emergencyPolice'] as String?,
      emergencyAmbulance: json['emergencyAmbulance'] as String?,
      emergencyFire: json['emergencyFire'] as String?,
      mondatoryVaccine: json['mondatoryVaccine'] as String?,
      routineVaccine: json['routineVaccine'] as String?,
      recommendedVaccine: json['recommendedVaccine'] as String?,
      warnings: json['warnings'] as String?,
      cOVIDTesting: json['COVIDTesting'] as String?,
      officialLanguages: json['officialLanguages'] as List<dynamic>?,
    );

Map<String, dynamic> _$AirportDetailCountryToJson(
        AirportDetailCountry instance) =>
    <String, dynamic>{
      'countryId': instance.countryId,
      'name': instance.name,
      'code': instance.code,
      'code3': instance.code3,
      'currencyCode': instance.currencyCode,
      'security': instance.security,
      'emergencyPolice': instance.emergencyPolice,
      'emergencyAmbulance': instance.emergencyAmbulance,
      'emergencyFire': instance.emergencyFire,
      'mondatoryVaccine': instance.mondatoryVaccine,
      'routineVaccine': instance.routineVaccine,
      'recommendedVaccine': instance.recommendedVaccine,
      'warnings': instance.warnings,
      'COVIDTesting': instance.cOVIDTesting,
      'officialLanguages': instance.officialLanguages,
    };
