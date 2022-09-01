// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePerson _$CreatePersonFromJson(Map<String, dynamic> json) => CreatePerson(
      firstMiddleName: json['firstMiddleName'] as String,
      surname: json['surname'] as String,
      gender: json['gender'] as String,
      dob: json['dob'] as String,
      birthCountryId: json['birthCountryId'] as int,
      zipNa: json['zipNa'] as bool,
      formId: json['formId'] as int,
      houseNumber: json['houseNumber'] as String?,
      street: json['street'] as String?,
      zip: json['zip'] as String?,
      address: json['address'] as String?,
      contacts: json['Contacts'] == null
          ? null
          : AddContact.fromJson(json['Contacts'] as Map<String, dynamic>),
      birthStateProvId: json['birthStateProvId'] as int?,
      birthCityId: json['birthCityId'] as int?,
      countryId: json['countryId'] as int?,
      cityId: json['cityId'] as int?,
    );

Map<String, dynamic> _$CreatePersonToJson(CreatePerson instance) =>
    <String, dynamic>{
      'firstMiddleName': instance.firstMiddleName,
      'surname': instance.surname,
      'gender': instance.gender,
      'dob': instance.dob,
      'birthCountryId': instance.birthCountryId,
      'zipNa': instance.zipNa,
      'formId': instance.formId,
      'houseNumber': instance.houseNumber,
      'street': instance.street,
      'zip': instance.zip,
      'address': instance.address,
      'Contacts': instance.contacts?.toJson(),
      'birthStateProvId': instance.birthStateProvId,
      'birthCityId': instance.birthCityId,
      'countryId': instance.countryId,
      'cityId': instance.cityId,
    };
