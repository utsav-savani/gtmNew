// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Passport _$PassportFromJson(Map<String, dynamic> json) => Passport(
      personPassportDocumentId: json['personPassportDocumentId'] as int?,
      personId: json['personId'] as int?,
      preference: json['preference'] as String?,
      countryId: json['countryId'] as int?,
      number: json['number'] as String?,
      issueDate: json['issueDate'] as String?,
      expireDate: json['expireDate'] as String?,
      type: json['type'] as String?,
      isActive: json['isActive'] as bool?,
      nationality: json['nationality'] as String?,
      personPassportIssueCountry: json['PersonPassportIssueCountry'] == null
          ? null
          : PersonPassportIssueCountry.fromJson(
              json['PersonPassportIssueCountry'] as Map<String, dynamic>),
      crewPassportDocumentFiles:
          (json['CrewPassportDocumentFiles'] as List<dynamic>?)
              ?.map((e) =>
                  CrewPassportDocumentFiles.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$PassportToJson(Passport instance) => <String, dynamic>{
      'personPassportDocumentId': instance.personPassportDocumentId,
      'personId': instance.personId,
      'preference': instance.preference,
      'countryId': instance.countryId,
      'number': instance.number,
      'issueDate': instance.issueDate,
      'expireDate': instance.expireDate,
      'type': instance.type,
      'isActive': instance.isActive,
      'nationality': instance.nationality,
      'PersonPassportIssueCountry':
          instance.personPassportIssueCountry?.toJson(),
      'CrewPassportDocumentFiles':
          instance.crewPassportDocumentFiles?.map((e) => e.toJson()).toList(),
    };
