// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateNote _$CreateNoteFromJson(Map<String, dynamic> json) => CreateNote(
      customerId: json['customerId'] as int,
      customerNoteInfo: (json['Customernoteinfo'] as List<dynamic>)
          .map((e) => NoteInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateNoteToJson(CreateNote instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'Customernoteinfo':
          instance.customerNoteInfo.map((e) => e.toJson()).toList(),
    };
