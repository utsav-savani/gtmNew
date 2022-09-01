// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_operational_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerOperationalNote _$CustomerOperationalNoteFromJson(
        Map<String, dynamic> json) =>
    CustomerOperationalNote(
      customerOperationalNoteId: json['customerOperationalNoteId'] as int,
      note: json['note'] as String,
    );

Map<String, dynamic> _$CustomerOperationalNoteToJson(
        CustomerOperationalNote instance) =>
    <String, dynamic>{
      'customerOperationalNoteId': instance.customerOperationalNoteId,
      'note': instance.note,
    };
