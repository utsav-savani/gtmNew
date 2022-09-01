// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_passport_issue_country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonPassportIssueCountry _$PersonPassportIssueCountryFromJson(
        Map<String, dynamic> json) =>
    PersonPassportIssueCountry(
      countryId: json['countryId'] as int?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      code3: json['code3'] as String?,
    );

Map<String, dynamic> _$PersonPassportIssueCountryToJson(
        PersonPassportIssueCountry instance) =>
    <String, dynamic>{
      'countryId': instance.countryId,
      'name': instance.name,
      'code': instance.code,
      'code3': instance.code3,
    };
