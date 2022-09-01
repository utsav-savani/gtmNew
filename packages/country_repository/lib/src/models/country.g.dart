// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      countryId: json['countryId'] as int?,
      name: json['name'] as String?,
      countryName: json['countryName'] as String?,
      code: json['code'] as String?,
      code3: json['code3'] as String?,
      currencyCode: json['currencyCode'] as String?,
      region: json['region'] as String?,
      capitalCity: json['capitalCity'] as String?,
      emergencyAmbulance: json['emergencyAmbulance'] as String?,
      emergencyFire: json['emergencyFire'] as String?,
      emergencyPolice: json['emergencyPolice'] as String?,
      notes: json['notes'] as String?,
      security: json['security'] as String?,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'countryId': instance.countryId,
      'name': instance.name,
      'countryName': instance.countryName,
      'code': instance.code,
      'code3': instance.code3,
      'currencyCode': instance.currencyCode,
      'region': instance.region,
      'capitalCity': instance.capitalCity,
      'security': instance.security,
      'emergencyPolice': instance.emergencyPolice,
      'emergencyFire': instance.emergencyFire,
      'emergencyAmbulance': instance.emergencyAmbulance,
      'notes': instance.notes,
    };
