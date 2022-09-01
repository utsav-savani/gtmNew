// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passport_country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassportCountry _$PassportCountryFromJson(Map<String, dynamic> json) =>
    PassportCountry(
      countryId: json['countryId'] as int?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      code3: json['code3'] as String?,
    );

Map<String, dynamic> _$PassportCountryToJson(PassportCountry instance) =>
    <String, dynamic>{
      'countryId': instance.countryId,
      'name': instance.name,
      'code': instance.code,
      'code3': instance.code3,
    };
