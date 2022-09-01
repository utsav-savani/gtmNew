// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToCountry _$ToCountryFromJson(Map<String, dynamic> json) => ToCountry(
      countryId: json['countryId'] as int,
      name: json['name'] as String,
      code3: json['code3'] as String,
    );

Map<String, dynamic> _$ToCountryToJson(ToCountry instance) => <String, dynamic>{
      'countryId': instance.countryId,
      'name': instance.name,
      'code3': instance.code3,
    };
