// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_call_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripCallRecord _$TripCallRecordFromJson(Map<String, dynamic> json) =>
    TripCallRecord(
      contactType: json['Contact Type'] as String,
      medium: json['Medium'] as String,
      info: json['Info'] as String,
      purposes: (json['purposes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$TripCallRecordToJson(TripCallRecord instance) =>
    <String, dynamic>{
      'Contact Type': instance.contactType,
      'Medium': instance.medium,
      'Info': instance.info,
      'purposes': instance.purposes,
    };
