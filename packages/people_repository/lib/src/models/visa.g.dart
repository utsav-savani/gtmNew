// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Visa _$VisaFromJson(Map<String, dynamic> json) => Visa(
      personVisaDocumentId: json['personVisaDocumentId'] as int?,
      personId: json['personId'] as int?,
      countryId: json['countryId'] as int?,
      number: json['number'] as String?,
      issueDate: json['issueDate'] as String?,
      expireDate: json['expireDate'] as String?,
      isActive: json['isActive'] as bool?,
      crewVisaDocumentFiles: (json['CrewVisaDocumentFiles'] as List<dynamic>?)
          ?.map(
              (e) => CrewVisaDocumentFiles.fromJson(e as Map<String, dynamic>))
          .toList(),
      personVisaIssueCountry: json['PersonVisaIssueCountry'] == null
          ? null
          : PersonPassportIssueCountry.fromJson(
              json['PersonVisaIssueCountry'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VisaToJson(Visa instance) => <String, dynamic>{
      'personVisaDocumentId': instance.personVisaDocumentId,
      'personId': instance.personId,
      'countryId': instance.countryId,
      'number': instance.number,
      'issueDate': instance.issueDate,
      'expireDate': instance.expireDate,
      'isActive': instance.isActive,
      'CrewVisaDocumentFiles':
          instance.crewVisaDocumentFiles?.map((e) => e.toJson()).toList(),
      'PersonVisaIssueCountry': instance.personVisaIssueCountry?.toJson(),
    };
