// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alert _$AlertFromJson(Map<String, dynamic> json) => Alert(
      alertId: json['alertId'] as int,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String?,
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      type: (json['type'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AlertToJson(Alert instance) => <String, dynamic>{
      'alertId': instance.alertId,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'category': instance.category,
      'type': instance.type,
    };
