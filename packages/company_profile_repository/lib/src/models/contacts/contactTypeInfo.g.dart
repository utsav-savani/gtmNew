// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contactTypeInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactTypeInfo _$ContactTypeInfoFromJson(Map<String, dynamic> json) =>
    ContactTypeInfo(
      json['contactcategorycontentId'] as int,
      json['customercontactTypeId'] as int,
      json['contactCategoryId'] as int,
      json['content'] as String,
      ContactCategoryInfo.fromJson(
          json['ContactCategoryInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContactTypeInfoToJson(ContactTypeInfo instance) =>
    <String, dynamic>{
      'contactcategorycontentId': instance.contactcategorycontentId,
      'customercontactTypeId': instance.customercontactTypeId,
      'contactCategoryId': instance.contactCategoryId,
      'content': instance.content,
      'ContactCategoryInfo': instance.contactCategoryInfo.toJson(),
    };
