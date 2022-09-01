// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_airport_requirement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryAirportRequirement _$CountryAirportRequirementFromJson(
        Map<String, dynamic> json) =>
    CountryAirportRequirement(
      through: json['through'] as String?,
      leadTime: json['leadTime'] as String?,
      permValidity: json['permValidity'] as String?,
      flightCategories: (json['flightCategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      fplMatch: json['fplMatch'] as bool?,
      reqSpecPermit: json['reqSpecPermit'] as bool?,
      docsRequired: json['docsRequired'] as bool?,
      isOnline: json['isOnline'] as bool?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$CountryAirportRequirementToJson(
        CountryAirportRequirement instance) =>
    <String, dynamic>{
      'through': instance.through,
      'leadTime': instance.leadTime,
      'permValidity': instance.permValidity,
      'fplMatch': instance.fplMatch,
      'reqSpecPermit': instance.reqSpecPermit,
      'docsRequired': instance.docsRequired,
      'isOnline': instance.isOnline,
      'notes': instance.notes,
      'flightCategories': instance.flightCategories,
      'services': instance.services,
    };
