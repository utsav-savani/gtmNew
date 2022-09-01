// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_service_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripServiceSchedule _$TripServiceScheduleFromJson(Map<String, dynamic> json) =>
    TripServiceSchedule(
      eTA: json['ETA'] as String?,
      eTATBA: json['ETATBA'] as bool?,
      eTD: json['ETD'] as String?,
      eTDTBA: json['ETDTBA'] as bool?,
      isOverFlight: json['isOverFlight'] as bool?,
      tripOverflyId: json['tripOverflyId'] as int?,
      name: json['name'] as String?,
      timezone: json['timezone'] as String?,
      tripScheduleId: json['tripScheduleId'] as int?,
      airportId: json['airportId'] as int?,
      flightCategoryId: json['flightCategoryId'] as int?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => TripService.fromJson(e as Map<String, dynamic>))
          .toList(),
      countryId: json['countryId'] as int?,
      mandatoryServicesList: (json['mandatoryServicesList'] as List<dynamic>?)
          ?.map((e) => MandatoryService.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripServiceScheduleToJson(
        TripServiceSchedule instance) =>
    <String, dynamic>{
      'tripScheduleId': instance.tripScheduleId,
      'airportId': instance.airportId,
      'countryId': instance.countryId,
      'flightCategoryId': instance.flightCategoryId,
      'ETA': instance.eTA,
      'ETD': instance.eTD,
      'ETATBA': instance.eTATBA,
      'ETDTBA': instance.eTDTBA,
      'name': instance.name,
      'timezone': instance.timezone,
      'isOverFlight': instance.isOverFlight,
      'tripOverflyId': instance.tripOverflyId,
      'services': instance.services?.map((e) => e.toJson()).toList(),
      'mandatoryServicesList':
          instance.mandatoryServicesList?.map((e) => e.toJson()).toList(),
    };
