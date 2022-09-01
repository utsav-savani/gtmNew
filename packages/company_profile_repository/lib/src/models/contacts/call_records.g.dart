// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_records.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CallRecord _$CallRecordFromJson(Map<String, dynamic> json) => CallRecord(
      json['contactCategoryId'] as int,
      json['CustomerContactId'] as int,
      json['CustomerContactTypeId'] as int,
      json['Contact Type'] as String,
      json['Medium'] as String,
      json['Info'] as String,
      (json['Purpose'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CallRecordToJson(CallRecord instance) =>
    <String, dynamic>{
      'contactCategoryId': instance.contactCategoryId,
      'CustomerContactId': instance.customerContactId,
      'CustomerContactTypeId': instance.customerContactTypeId,
      'Contact Type': instance.contactType,
      'Medium': instance.medium,
      'Info': instance.info,
      'Purpose': instance.purpose,
    };
