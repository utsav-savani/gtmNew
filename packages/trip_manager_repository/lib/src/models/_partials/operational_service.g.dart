// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operational_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationalService _$OperationalServiceFromJson(Map<String, dynamic> json) =>
    OperationalService(
      serviceId: json['serviceId'] as int?,
      serviceCategoryId: json['serviceCategoryId'] as int?,
      service: json['service'] as String?,
      notes: (json['notes'] as List<dynamic>?)
          ?.map(
              (e) => OperationalNoteService.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OperationalServiceToJson(OperationalService instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
      'serviceCategoryId': instance.serviceCategoryId,
      'service': instance.service,
      'notes': instance.notes?.map((e) => e.toJson()).toList(),
    };
