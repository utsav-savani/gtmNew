// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentType _$DocumentTypeFromJson(Map<String, dynamic> json) => DocumentType(
      docTypeId: json['docTypeId'] as int,
      name: json['name'] as String,
      model: json['model'] as String?,
    );

Map<String, dynamic> _$DocumentTypeToJson(DocumentType instance) =>
    <String, dynamic>{
      'docTypeId': instance.docTypeId,
      'name': instance.name,
      'model': instance.model,
    };
