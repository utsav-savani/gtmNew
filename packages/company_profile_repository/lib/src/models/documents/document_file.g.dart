// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentFiles _$DocumentFilesFromJson(Map<String, dynamic> json) =>
    DocumentFiles(
      documentFilesId: json['documentFilesId'] as int,
      storedName: json['storedName'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$DocumentFilesToJson(DocumentFiles instance) =>
    <String, dynamic>{
      'documentFilesId': instance.documentFilesId,
      'storedName': instance.storedName,
      'name': instance.name,
    };
