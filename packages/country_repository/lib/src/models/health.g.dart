// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Health _$HealthFromJson(Map<String, dynamic> json) => Health(
      countryId: json['countryId'] as int?,
      name: json['name'] as String?,
      mondatoryVaccine: json['mondatoryVaccine'] as String?,
      routineVaccine: json['routineVaccine'] as String?,
      recommendedVaccine: json['recommendedVaccine'] as String?,
      warnings: json['warnings'] as String?,
      cOVIDTesting: json['COVIDTesting'] as String?,
    );

Map<String, dynamic> _$HealthToJson(Health instance) => <String, dynamic>{
      'countryId': instance.countryId,
      'name': instance.name,
      'mondatoryVaccine': instance.mondatoryVaccine,
      'routineVaccine': instance.routineVaccine,
      'recommendedVaccine': instance.recommendedVaccine,
      'warnings': instance.warnings,
      'COVIDTesting': instance.cOVIDTesting,
    };
