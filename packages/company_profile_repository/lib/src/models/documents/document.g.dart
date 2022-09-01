// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Documents _$DocumentsFromJson(Map<String, dynamic> json) => Documents(
      documentId: json['documentId'] as int,
      countryId: json['countryId'] as int?,
      name: json['name'] as String,
      expireDate: json['expireDate'] as String?,
      ufn: json['ufn'] as bool?,
      issueDate: json['issueDate'] as String?,
      note: json['note'] as String?,
      documentType:
          DocumentType.fromJson(json['DocumentType'] as Map<String, dynamic>),
      documentFiles: (json['DocumentFiles'] as List<dynamic>)
          .map((e) => DocumentFiles.fromJson(e as Map<String, dynamic>))
          .toList(),
      newExpireDate: json['newExpireDate'] as String?,
      newIssueDate: json['newIssueDate'] as String?,
    );

Map<String, dynamic> _$DocumentsToJson(Documents instance) => <String, dynamic>{
      'documentId': instance.documentId,
      'countryId': instance.countryId,
      'name': instance.name,
      'expireDate': instance.expireDate,
      'ufn': instance.ufn,
      'issueDate': instance.issueDate,
      'note': instance.note,
      'DocumentType': instance.documentType.toJson(),
      'DocumentFiles': instance.documentFiles.map((e) => e.toJson()).toList(),
      'newExpireDate': instance.newExpireDate,
      'newIssueDate': instance.newIssueDate,
    };
