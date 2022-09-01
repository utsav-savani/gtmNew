// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operational_note_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationalNoteService _$OperationalNoteServiceFromJson(
        Map<String, dynamic> json) =>
    OperationalNoteService(
      tripCustomerOperationalNoteId:
          json['tripCustomerOperationalNoteId'] as int?,
      tripId: json['tripId'] as int?,
      note: json['note'] as String,
      category: json['category'] as String?,
      customerOperationalNoteId: json['customerOperationalNoteId'] as int?,
      archived: json['archived'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      creatorId: json['creatorId'] as String?,
      editorId: json['editorId'] as String?,
    );

Map<String, dynamic> _$OperationalNoteServiceToJson(
        OperationalNoteService instance) =>
    <String, dynamic>{
      'tripCustomerOperationalNoteId': instance.tripCustomerOperationalNoteId,
      'tripId': instance.tripId,
      'note': instance.note,
      'category': instance.category,
      'customerOperationalNoteId': instance.customerOperationalNoteId,
      'archived': instance.archived,
      'creatorId': instance.creatorId,
      'editorId': instance.editorId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
