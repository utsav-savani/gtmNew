// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_pob_schedule_main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripPobScheduleMain _$TripPobScheduleMainFromJson(Map<String, dynamic> json) =>
    TripPobScheduleMain(
      persons: (json['persons'] as List<dynamic>)
          .map((e) => TripPobSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      tripOffice:
          TripPobOffice.fromJson(json['tripOffice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TripPobScheduleMainToJson(
        TripPobScheduleMain instance) =>
    <String, dynamic>{
      'persons': instance.persons.map((e) => e.toJson()).toList(),
      'tripOffice': instance.tripOffice.toJson(),
    };
