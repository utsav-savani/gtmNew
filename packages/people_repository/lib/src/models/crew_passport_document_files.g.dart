// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crew_passport_document_files.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CrewPassportDocumentFiles _$CrewPassportDocumentFilesFromJson(
        Map<String, dynamic> json) =>
    CrewPassportDocumentFiles(
      passportDocumentFilesId: json['passportDocumentFilesId'] as int?,
      storedName: json['storedName'] as String?,
      name: json['name'] as String?,
      personPassportDocumentId: json['personPassportDocumentId'] as int?,
    );

Map<String, dynamic> _$CrewPassportDocumentFilesToJson(
        CrewPassportDocumentFiles instance) =>
    <String, dynamic>{
      'passportDocumentFilesId': instance.passportDocumentFilesId,
      'storedName': instance.storedName,
      'name': instance.name,
      'personPassportDocumentId': instance.personPassportDocumentId,
    };
