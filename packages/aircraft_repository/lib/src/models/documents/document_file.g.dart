// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentFile _$DocumentFileFromJson(Map<String, dynamic> json) => DocumentFile(
      documentFilesId: json['documentFilesId'] as int,
      storedName: json['storedName'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$DocumentFileToJson(DocumentFile instance) =>
    <String, dynamic>{
      'documentFilesId': instance.documentFilesId,
      'storedName': instance.storedName,
      'name': instance.name,
    };
