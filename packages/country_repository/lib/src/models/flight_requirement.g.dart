// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_requirement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightRequirement _$FlightRequirementFromJson(Map<String, dynamic> json) =>
    FlightRequirement(
      docsRequired: json['docsRequired'] as bool?,
      through: json['through'] as String?,
      leadTime: json['leadTime'] as String?,
      permValidity: json['permValidity'] as String?,
      specFormRequired: json['specFormRequired'] as String?,
      fplMatch: json['fplMatch'] as bool?,
      reqSpecPermit: json['reqSpecPermit'] as bool?,
      isOnline: json['isOnline'] as bool?,
      notes: json['notes'] as String?,
      flightCategories: (json['flightCategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FlightRequirementToJson(FlightRequirement instance) =>
    <String, dynamic>{
      'flightCategories': instance.flightCategories,
      'services': instance.services,
      'through': instance.through,
      'leadTime': instance.leadTime,
      'permValidity': instance.permValidity,
      'specFormRequired': instance.specFormRequired,
      'fplMatch': instance.fplMatch,
      'reqSpecPermit': instance.reqSpecPermit,
      'docsRequired': instance.docsRequired,
      'isOnline': instance.isOnline,
      'notes': instance.notes,
    };
