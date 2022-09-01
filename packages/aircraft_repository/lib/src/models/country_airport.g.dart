// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_airport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryAirport _$CountryAirportFromJson(Map<String, dynamic> json) =>
    CountryAirport(
      airportId: json['airportId'] as int,
      city: json['city'] as String?,
      countryId: json['countryId'] as int?,
      countryName: json['countryName'] as String?,
      iata: json['iata'] as String?,
      icao: json['icao'] as String?,
      fullName: json['fullName'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CountryAirportToJson(CountryAirport instance) =>
    <String, dynamic>{
      'airportId': instance.airportId,
      'city': instance.city,
      'countryId': instance.countryId,
      'countryName': instance.countryName,
      'iata': instance.iata,
      'icao': instance.icao,
      'fullName': instance.fullName,
      'name': instance.name,
    };
