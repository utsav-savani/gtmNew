// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aircraft_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AircraftDetails _$AircraftDetailsFromJson(Map<String, dynamic> json) =>
    AircraftDetails(
      json['aircraftId'] as int,
      json['registrationNumber'] as String?,
      json['AircraftType'] == null
          ? null
          : AircraftType.fromJson(json['AircraftType'] as Map<String, dynamic>),
      json['regCountryId'] as int?,
      (json['Customers'] as List<dynamic>)
          .map((e) => Customers.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['BaseAirport'] == null
          ? null
          : BaseAirport.fromJson(json['BaseAirport'] as Map<String, dynamic>),
      json['icao'] as String,
      json['noiseCategory'] as String?,
      json['category'] as int?,
      json['runwayFt'] as int?,
      json['referenceCode'] as String?,
      json['remark'] as String?,
      (json['Operators'] as List<dynamic>?)
          ?.map((e) => Customers.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['Country'] == null
          ? null
          : Country.fromJson(json['Country'] as Map<String, dynamic>),
      json['seatCap'] as int?,
      json['iata'] as String?,
      (json['mtow'] as num?)?.toDouble(),
      json['mtowUnit'] as String?,
    );

Map<String, dynamic> _$AircraftDetailsToJson(AircraftDetails instance) =>
    <String, dynamic>{
      'aircraftId': instance.aircraftId,
      'registrationNumber': instance.registrationNumber,
      'AircraftType': instance.aircraftType?.toJson(),
      'regCountryId': instance.regCountryId,
      'Customers': instance.customers.map((e) => e.toJson()).toList(),
      'BaseAirport': instance.baseAirport?.toJson(),
      'icao': instance.icao,
      'noiseCategory': instance.noiseCategory,
      'runwayFt': instance.runwayFt,
      'category': instance.category,
      'referenceCode': instance.referenceCode,
      'remark': instance.remark,
      'Operators': instance.operators?.map((e) => e.toJson()).toList(),
      'Country': instance.country?.toJson(),
      'seatCap': instance.seatCap,
      'iata': instance.iata,
      'mtow': instance.mtow,
      'mtowUnit': instance.mtowUnit,
    };
