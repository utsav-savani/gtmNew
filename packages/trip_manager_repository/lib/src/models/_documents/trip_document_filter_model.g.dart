// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_document_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDocumentFilterModel _$TripDocumentFilterModelFromJson(
        Map<String, dynamic> json) =>
    TripDocumentFilterModel(
      tripId: json['tripId'] as int,
      tripScedule: (json['tripScedule'] as List<dynamic>)
          .map((e) => TripDocumentSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      services: (json['services'] as List<dynamic>)
          .map((e) => TripDocumentService.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripDocumentFilterModelToJson(
        TripDocumentFilterModel instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'tripScedule': instance.tripScedule.map((e) => e.toJson()).toList(),
      'services': instance.services.map((e) => e.toJson()).toList(),
    };
