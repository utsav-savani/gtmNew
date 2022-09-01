// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_poc_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripPOCContact _$TripPOCContactFromJson(Map<String, dynamic> json) =>
    TripPOCContact(
      name: json['Name'] as String,
      priority: json['priority'] as int,
      customercontactId: json['customercontactId'] as int,
      mobiles:
          (json['mobiles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      phones:
          (json['phones'] as List<dynamic>?)?.map((e) => e as String).toList(),
      emails:
          (json['emails'] as List<dynamic>?)?.map((e) => e as String).toList(),
      callRecords: (json['callRecords'] as List<dynamic>?)
          ?.map((e) => TripCallRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripPOCContactToJson(TripPOCContact instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'priority': instance.priority,
      'customercontactId': instance.customercontactId,
      'mobiles': instance.mobiles,
      'phones': instance.phones,
      'emails': instance.emails,
      'callRecords': instance.callRecords?.map((e) => e.toJson()).toList(),
    };
