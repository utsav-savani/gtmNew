// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_airport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseAirport _$BaseAirportFromJson(Map<String, dynamic> json) => BaseAirport(
      json['airportId'] as int,
      json['name'] as String,
      json['iata'] as String?,
      json['icao'] as String?,
    );

Map<String, dynamic> _$BaseAirportToJson(BaseAirport instance) =>
    <String, dynamic>{
      'airportId': instance.airportId,
      'name': instance.name,
      'iata': instance.iata,
      'icao': instance.icao,
    };
