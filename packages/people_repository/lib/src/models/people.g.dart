// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

People _$PeopleFromJson(Map<String, dynamic> json) => People(
      personId: json['personId'] as int,
      guid: json['guid'] as String?,
      name: json['name'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      nationality: json['nationality'] as String?,
      customers: (json['customers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      passport: (json['passport'] as List<dynamic>?)
          ?.map((e) => Passport.fromJson(e as Map<String, dynamic>))
          .toList(),
      visa: (json['visa'] as List<dynamic>?)
          ?.map((e) => Visa.fromJson(e as Map<String, dynamic>))
          .toList(),
      passportDocumentNumber: (json['PassportDocumentNumber'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      visaDocumentNumber: (json['VisaDocumentNumber'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PeopleToJson(People instance) => <String, dynamic>{
      'personId': instance.personId,
      'guid': instance.guid,
      'name': instance.name,
      'roles': instance.roles,
      'nationality': instance.nationality,
      'customers': instance.customers,
      'passport': instance.passport?.map((e) => e.toJson()).toList(),
      'visa': instance.visa?.map((e) => e.toJson()).toList(),
      'PassportDocumentNumber': instance.passportDocumentNumber,
      'VisaDocumentNumber': instance.visaDocumentNumber,
    };
