// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alternative.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alternative _$AlternativeFromJson(Map<String, dynamic> json) => Alternative(
      airportId: json['airportId'] as int,
      iata: json['iata'] as String?,
      airportFromHours: json['AirportFromHours'] as String?,
      airportToHours: json['AirportToHours'] as String?,
      alternativeAirport: json['AlternativeAirport'] == null
          ? null
          : AlternativeAirport.fromJson(
              json['AlternativeAirport'] as Map<String, dynamic>),
      aoe: json['aoe'] as bool?,
      civil: json['civil'] as bool?,
      customs: json['customs'] as bool?,
      h24: json['H24'] as bool?,
      icao: json['icao'] as String?,
      military: json['military'] as bool?,
      name: json['name'] as String?,
      ppr: json['ppr'] as bool?,
      slots: json['slots'] as bool?,
    );

Map<String, dynamic> _$AlternativeToJson(Alternative instance) =>
    <String, dynamic>{
      'airportId': instance.airportId,
      'iata': instance.iata,
      'icao': instance.icao,
      'name': instance.name,
      'aoe': instance.aoe,
      'civil': instance.civil,
      'military': instance.military,
      'customs': instance.customs,
      'slots': instance.slots,
      'ppr': instance.ppr,
      'H24': instance.h24,
      'AirportFromHours': instance.airportFromHours,
      'AirportToHours': instance.airportToHours,
      'AlternativeAirport': instance.alternativeAirport?.toJson(),
    };
