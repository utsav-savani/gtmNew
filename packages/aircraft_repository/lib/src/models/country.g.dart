// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      countryId: json['countryId'] as int,
      name: json['name'] as String,
      countryName: json['countryName'] as String?,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'countryId': instance.countryId,
      'name': instance.name,
      'countryName': instance.countryName,
    };
