// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadDocument _$UploadDocumentFromJson(Map<String, dynamic> json) =>
    UploadDocument(
      fileToUpload: (json['fileToUpload'] as List<dynamic>)
          .map((e) => e as Object)
          .toList(),
      aircraftId: json['aircraftId'] as int,
      name: json['name'] as String,
      note: json['note'] as String,
      expireDate: json['expireDate'] as String,
      issueDate: json['issueDate'] as String,
      docTypeId: json['docTypeId'] as int,
      overwrite: json['overwrite'] as bool? ?? false,
      ufn: json['ufn'] as bool,
    );

Map<String, dynamic> _$UploadDocumentToJson(UploadDocument instance) =>
    <String, dynamic>{
      'fileToUpload': instance.fileToUpload,
      'aircraftId': instance.aircraftId,
      'name': instance.name,
      'note': instance.note,
      'issueDate': instance.issueDate,
      'expireDate': instance.expireDate,
      'docTypeId': instance.docTypeId,
      'overwrite': instance.overwrite,
      'ufn': instance.ufn,
    };
