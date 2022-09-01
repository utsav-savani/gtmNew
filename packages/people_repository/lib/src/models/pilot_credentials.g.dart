// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pilot_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PilotCredentials _$PilotCredentialsFromJson(Map<String, dynamic> json) =>
    PilotCredentials(
      licenseIssuedCountryId: json['LicenseIssuedCountryId'] as int,
      expirationDate: json['expirationDate'] as String?,
      formId: json['formId'] as int,
      issueDate: json['issueDate'] as String?,
      licenseNumber: json['licenseNumber'] as String,
      ufn: json['ufn'] as bool,
    );

Map<String, dynamic> _$PilotCredentialsToJson(PilotCredentials instance) =>
    <String, dynamic>{
      'LicenseIssuedCountryId': instance.licenseIssuedCountryId,
      'expirationDate': instance.expirationDate,
      'formId': instance.formId,
      'issueDate': instance.issueDate,
      'licenseNumber': instance.licenseNumber,
      'ufn': instance.ufn,
    };
