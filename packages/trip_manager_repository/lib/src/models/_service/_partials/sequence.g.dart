// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sequence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sequence _$SequenceFromJson(Map<String, dynamic> json) => Sequence(
      name: json['name'] as String?,
      isUTC: json['isUTC'] as bool?,
      schedules: (json['schedules'] as List<dynamic>?)
          ?.map((e) => SequenceSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SequenceToJson(Sequence instance) => <String, dynamic>{
      'name': instance.name,
      'isUTC': instance.isUTC,
      'schedules': instance.schedules?.map((e) => e.toJson()).toList(),
    };
