// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteInfo _$NoteInfoFromJson(Map<String, dynamic> json) => NoteInfo(
      serviceId: json['serviceId'] as int,
      note: json['note'] as String,
    );

Map<String, dynamic> _$NoteInfoToJson(NoteInfo instance) => <String, dynamic>{
      'serviceId': instance.serviceId,
      'note': instance.note,
    };
