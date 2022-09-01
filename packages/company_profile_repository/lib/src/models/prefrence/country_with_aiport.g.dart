// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_with_aiport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryWithAirport _$CountryWithAirportFromJson(Map<String, dynamic> json) =>
    CountryWithAirport(
      countryId: json['countryId'] as int,
      id: json['id'] as String?,
      name: json['name'] as String,
      region: json['region'] as String?,
      airports: (json['airports'] as List<dynamic>?)
          ?.map((e) => PrefrenceAirport.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountryWithAirportToJson(CountryWithAirport instance) =>
    <String, dynamic>{
      'countryId': instance.countryId,
      'id': instance.id,
      'name': instance.name,
      'region': instance.region,
      'airports': instance.airports?.map((e) => e.toJson()).toList(),
    };
