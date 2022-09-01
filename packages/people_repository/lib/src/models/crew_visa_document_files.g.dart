// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crew_visa_document_files.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CrewVisaDocumentFiles _$CrewVisaDocumentFilesFromJson(
        Map<String, dynamic> json) =>
    CrewVisaDocumentFiles(
      visaDocumentFilesId: json['visaDocumentFilesId'] as int?,
      storedName: json['storedName'] as String?,
      name: json['name'] as String?,
      personVisaDocumentId: json['personVisaDocumentId'] as int?,
    );

Map<String, dynamic> _$CrewVisaDocumentFilesToJson(
        CrewVisaDocumentFiles instance) =>
    <String, dynamic>{
      'visaDocumentFilesId': instance.visaDocumentFilesId,
      'storedName': instance.storedName,
      'name': instance.name,
      'personVisaDocumentId': instance.personVisaDocumentId,
    };
