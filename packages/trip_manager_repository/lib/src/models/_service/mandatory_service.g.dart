// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mandatory_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MandatoryService _$MandatoryServiceFromJson(Map<String, dynamic> json) =>
    MandatoryService(
      serviceId: json['serviceId'] as int?,
      service: json['service'] as String?,
      serviceCategoryId: json['serviceCategoryId'] as int?,
    );

Map<String, dynamic> _$MandatoryServiceToJson(MandatoryService instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
      'service': instance.service,
      'serviceCategoryId': instance.serviceCategoryId,
    };
