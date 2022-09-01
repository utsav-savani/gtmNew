// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sequence_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SequenceSchedule _$SequenceScheduleFromJson(Map<String, dynamic> json) =>
    SequenceSchedule(
      type: json['type'] as String?,
      icoa: json['icoa'] as String?,
      date: json['date'] as String?,
      timezone: json['timezone'] as String?,
    );

Map<String, dynamic> _$SequenceScheduleToJson(SequenceSchedule instance) =>
    <String, dynamic>{
      'type': instance.type,
      'icoa': instance.icoa,
      'date': instance.date,
      'timezone': instance.timezone,
    };
