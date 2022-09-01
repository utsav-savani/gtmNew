// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_doc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadDoc _$UploadDocFromJson(Map<String, dynamic> json) => UploadDoc(
      guid: json['guid'] as String,
      id: json['id'] as int,
      personPassportDocumentId: json['personPassportDocumentId'] as int?,
      visaId: json['visaId'] as int?,
      name: json['name'] as String,
      docTypeId: json['docTypeId'] as int,
      prefrence: json['prefrence'] as int?,
      customerId: json['customerId'] as int?,
      number: json['number'] as String,
      issueDate: json['issueDate'] as String,
      expiryDate: json['expiryDate'] as String,
      type: json['type'] as String?,
      isActive: json['isActive'] as bool,
      total: json['total'] as int,
      overwriteoptional: json['overwriteoptional'] as bool,
      countryId: json['countryId'] as int,
      nationality: json['nationality'] as String?,
      documentType: json['documentType'] as String,
    );

Map<String, dynamic> _$UploadDocToJson(UploadDoc instance) => <String, dynamic>{
      'guid': instance.guid,
      'id': instance.id,
      'personPassportDocumentId': instance.personPassportDocumentId,
      'visaId': instance.visaId,
      'name': instance.name,
      'docTypeId': instance.docTypeId,
      'prefrence': instance.prefrence,
      'customerId': instance.customerId,
      'number': instance.number,
      'issueDate': instance.issueDate,
      'expiryDate': instance.expiryDate,
      'type': instance.type,
      'isActive': instance.isActive,
      'total': instance.total,
      'overwriteoptional': instance.overwriteoptional,
      'countryId': instance.countryId,
      'nationality': instance.nationality,
      'documentType': instance.documentType,
    };
