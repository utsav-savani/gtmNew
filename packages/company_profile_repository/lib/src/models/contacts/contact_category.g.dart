// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactCategory _$ContactCategoryFromJson(Map<String, dynamic> json) =>
    ContactCategory(
      contactcategoryType: json['contactcategoryType'] as int,
      content:
          (json['content'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ContactCategoryToJson(ContactCategory instance) =>
    <String, dynamic>{
      'contactcategoryType': instance.contactcategoryType,
      'content': instance.content,
    };
