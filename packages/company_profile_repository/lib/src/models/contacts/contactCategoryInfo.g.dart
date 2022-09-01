// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contactCategoryInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactCategoryInfo _$ContactCategoryInfoFromJson(Map<String, dynamic> json) =>
    ContactCategoryInfo(
      json['contactCategoryId'] as int,
      json['Category'] as String,
    );

Map<String, dynamic> _$ContactCategoryInfoToJson(
        ContactCategoryInfo instance) =>
    <String, dynamic>{
      'contactCategoryId': instance.contactCategoryId,
      'Category': instance.category,
    };
