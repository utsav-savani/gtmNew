// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notes _$NotesFromJson(Map<String, dynamic> json) => Notes(
      operationalNoteId: json['operationalNoteId'] as int?,
      customerId: json['customerId'] as int,
      serviceId: json['serviceId'] as int,
      service: NoteService.fromJson(
          json['OperationalNotesHasService'] as Map<String, dynamic>),
      customerHasOperationalNotes:
          (json['CustomerHasOperationalNotes'] as List<dynamic>?)
              ?.map((e) =>
                  CustomerOperationalNote.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$NotesToJson(Notes instance) => <String, dynamic>{
      'operationalNoteId': instance.operationalNoteId,
      'customerId': instance.customerId,
      'serviceId': instance.serviceId,
      'CustomerHasOperationalNotes':
          instance.customerHasOperationalNotes?.map((e) => e.toJson()).toList(),
      'OperationalNotesHasService': instance.service.toJson(),
    };
