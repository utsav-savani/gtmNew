// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactInfo _$ContactInfoFromJson(Map<String, dynamic> json) => ContactInfo(
      purposes: (json['Purposes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => ContactCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      medium: json['medium'] as String?,
    );

Map<String, dynamic> _$ContactInfoToJson(ContactInfo instance) =>
    <String, dynamic>{
      'Purposes': instance.purposes,
      'category': instance.category?.map((e) => e.toJson()).toList(),
      'medium': instance.medium,
    };
