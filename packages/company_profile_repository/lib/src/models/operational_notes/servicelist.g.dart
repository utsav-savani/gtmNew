// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servicelist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceList _$ServiceListFromJson(Map<String, dynamic> json) => ServiceList(
      category: json['category'] as String,
      service: json['service'] as String,
      serviceCategoryId: json['serviceCategoryId'] as int,
      serviceCode: json['serviceCode'] as String?,
      serviceId: json['serviceId'] as int,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$ServiceListToJson(ServiceList instance) =>
    <String, dynamic>{
      'category': instance.category,
      'service': instance.service,
      'serviceCategoryId': instance.serviceCategoryId,
      'serviceCode': instance.serviceCode,
      'serviceId': instance.serviceId,
      'note': instance.note,
    };
