// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Airport _$AirportFromJson(Map<String, dynamic> json) => Airport(
      airportId: json['airportId'] as int,
      countryId: json['countryId'] as int?,
      name: json['name'] as String,
      iata: json['iata'] as String?,
      icao: json['icao'] as String?,
      h24: json['h24'] as bool?,
      timezone: json['timezone'] as String?,
      city: json['city'] as String?,
      airportFromHours: json['AirportFromHours'] as String?,
      airportToHours: json['AirportToHours'] as String?,
      aoe: json['aoe'] as bool?,
      code: json['code'] as String?,
      code3: json['code3'] as String?,
      countryName: json['countryName'] as String?,
      displayOffset: json['displayOffset'] as String?,
      operatingHours: json['operatingHours'] as String?,
      uASPartnerAgent: json['UASPartnerAgent'] as String?,
      airportCity: json['AirportCity'] == null
          ? null
          : AirportCity.fromJson(json['AirportCity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AirportToJson(Airport instance) => <String, dynamic>{
      'airportId': instance.airportId,
      'countryId': instance.countryId,
      'timezone': instance.timezone,
      'h24': instance.h24,
      'name': instance.name,
      'iata': instance.iata,
      'icao': instance.icao,
      'aoe': instance.aoe,
      'AirportFromHours': instance.airportFromHours,
      'AirportToHours': instance.airportToHours,
      'UASPartnerAgent': instance.uASPartnerAgent,
      'displayOffset': instance.displayOffset,
      'operatingHours': instance.operatingHours,
      'countryName': instance.countryName,
      'code': instance.code,
      'code3': instance.code3,
      'city': instance.city,
      'AirportCity': instance.airportCity?.toJson(),
    };
