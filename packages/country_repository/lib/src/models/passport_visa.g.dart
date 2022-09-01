// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passport_visa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassportVisa _$PassportVisaFromJson(Map<String, dynamic> json) => PassportVisa(
      id: json['id'] as int,
      fromCountryId: json['fromCountryId'] as int,
      toCountryId: json['toCountryId'] as int,
      crewPassport: json['crewPassport'] as String,
      crewVISA: json['crewVISA'] as String,
      passengerPassport: json['passengerPassport'] as String,
      passengerVISA: json['passengerVISA'] as String,
      originCountry:
          Country.fromJson(json['originCountry'] as Map<String, dynamic>),
      toCountry: Country.fromJson(json['toCountry'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PassportVisaToJson(PassportVisa instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromCountryId': instance.fromCountryId,
      'toCountryId': instance.toCountryId,
      'crewPassport': instance.crewPassport,
      'crewVISA': instance.crewVISA,
      'passengerPassport': instance.passengerPassport,
      'passengerVISA': instance.passengerVISA,
      'originCountry': instance.originCountry.toJson(),
      'toCountry': instance.toCountry.toJson(),
    };
