// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customerContactTypeInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerContactTypeInfo _$CustomerContactTypeInfoFromJson(
        Map<String, dynamic> json) =>
    CustomerContactTypeInfo(
      json['customercontactTypeId'] as int,
      json['customercontactId'] as int,
      (json['ContactTypeInfo'] as List<dynamic>)
          .map((e) => ContactTypeInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerContactTypeInfoToJson(
        CustomerContactTypeInfo instance) =>
    <String, dynamic>{
      'customercontactTypeId': instance.customercontactTypeId,
      'customercontactId': instance.customercontactId,
      'ContactTypeInfo':
          instance.contactTypeInfo.map((e) => e.toJson()).toList(),
    };
