// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_service_main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripServiceMain _$TripServiceMainFromJson(Map<String, dynamic> json) =>
    TripServiceMain(
      objectEqualityChecker: json['objectEqualityChecker'] as String?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => TripService.fromJson(e as Map<String, dynamic>))
          .toList(),
      schedule: (json['schedule'] as List<dynamic>?)
          ?.map((e) => TripServiceSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      mondatoryServices: (json['mondatoryServices'] as List<dynamic>?)
          ?.map((e) => MandatoryService.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripServiceMainToJson(TripServiceMain instance) =>
    <String, dynamic>{
      'objectEqualityChecker': instance.objectEqualityChecker,
      'services': instance.services?.map((e) => e.toJson()).toList(),
      'schedule': instance.schedule?.map((e) => e.toJson()).toList(),
      'mondatoryServices':
          instance.mondatoryServices?.map((e) => e.toJson()).toList(),
    };
