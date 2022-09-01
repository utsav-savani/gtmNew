// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prefrence_airport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrefrenceAirport _$PrefrenceAirportFromJson(Map<String, dynamic> json) =>
    PrefrenceAirport(
      airportId: json['airportId'] as int,
      id: json['id'] as String?,
      name: json['name'] as String,
      iata: json['iata'] as String?,
      icao: json['icao'] as String?,
    );

Map<String, dynamic> _$PrefrenceAirportToJson(PrefrenceAirport instance) =>
    <String, dynamic>{
      'airportId': instance.airportId,
      'id': instance.id,
      'name': instance.name,
      'iata': instance.iata,
      'icao': instance.icao,
    };
