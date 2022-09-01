// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prefrence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prefrence _$PrefrenceFromJson(Map<String, dynamic> json) => Prefrence(
      priority: json['priority'] as String,
      notes: json['notes'] as String?,
      servicesData: (json['servicesData'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      countryData: (json['countryData'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      flightCategoryData: (json['flightCategoryData'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      flightPurpusesData: (json['flightPurpusesData'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      equipmentsData: (json['equipmentsData'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      countryWithAirport: (json['countryWithAirport'] as List<dynamic>?)
          ?.map((e) => CountryWithAirport.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PrefrenceToJson(Prefrence instance) => <String, dynamic>{
      'priority': instance.priority,
      'notes': instance.notes,
      'servicesData': instance.servicesData,
      'countryData': instance.countryData,
      'flightCategoryData': instance.flightCategoryData,
      'flightPurpusesData': instance.flightPurpusesData,
      'equipmentsData': instance.equipmentsData,
      'countryWithAirport':
          instance.countryWithAirport?.map((e) => e.toJson()).toList(),
    };
