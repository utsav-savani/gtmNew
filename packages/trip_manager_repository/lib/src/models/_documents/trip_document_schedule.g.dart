// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_document_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDocumentSchedule _$TripDocumentScheduleFromJson(
        Map<String, dynamic> json) =>
    TripDocumentSchedule(
      tripsequenceNumber: json['tripsequenceNumber'] as int,
      tripScheduleId: json['tripScheduleId'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$TripDocumentScheduleToJson(
        TripDocumentSchedule instance) =>
    <String, dynamic>{
      'tripsequenceNumber': instance.tripsequenceNumber,
      'tripScheduleId': instance.tripScheduleId,
      'name': instance.name,
    };
