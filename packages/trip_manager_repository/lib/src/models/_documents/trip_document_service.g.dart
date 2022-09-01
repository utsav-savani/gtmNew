// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_document_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDocumentService _$TripDocumentServiceFromJson(Map<String, dynamic> json) =>
    TripDocumentService(
      serviceId: json['serviceId'] as int,
      service: json['service'] as String,
    );

Map<String, dynamic> _$TripDocumentServiceToJson(
        TripDocumentService instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
      'service': instance.service,
    };
