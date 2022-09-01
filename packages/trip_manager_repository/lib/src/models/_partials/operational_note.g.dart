// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operational_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationalNote _$OperationalNoteFromJson(Map<String, dynamic> json) =>
    OperationalNote(
      title: json['title'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OperationalService.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OperationalNoteToJson(OperationalNote instance) =>
    <String, dynamic>{
      'title': instance.title,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
