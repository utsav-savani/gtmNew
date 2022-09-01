// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceCategory _$ServiceCategoryFromJson(Map<String, dynamic> json) =>
    ServiceCategory(
      serviceCategoryId: json['serviceCategoryId'] as int,
      name: json['name'] as String,
      serviceCategoryParentId: json['serviceCategoryParentId'] as int?,
      childServiceCategory: (json['ChildServiceCategory'] as List<dynamic>?)
          ?.map((e) => ServiceCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      service: (json['Service'] as List<dynamic>?)
          ?.map(
              (e) => CategoryDetailService.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceCategoryToJson(ServiceCategory instance) =>
    <String, dynamic>{
      'serviceCategoryId': instance.serviceCategoryId,
      'name': instance.name,
      'serviceCategoryParentId': instance.serviceCategoryParentId,
      'ChildServiceCategory':
          instance.childServiceCategory?.map((e) => e.toJson()).toList(),
      'Service': instance.service?.map((e) => e.toJson()).toList(),
    };
