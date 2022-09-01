// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_detail_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDetailService _$CategoryDetailServiceFromJson(
        Map<String, dynamic> json) =>
    CategoryDetailService(
      serviceId: json['serviceId'] as int,
      name: json['name'] as String,
      isDefault: json['isDefault'] as bool,
    );

Map<String, dynamic> _$CategoryDetailServiceToJson(
        CategoryDetailService instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
      'name': instance.name,
      'isDefault': instance.isDefault,
    };
