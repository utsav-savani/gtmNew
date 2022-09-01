// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_pob_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripPobDetail _$TripPobDetailFromJson(Map<String, dynamic> json) =>
    TripPobDetail(
      address: json['address'] as String?,
      contractedBy: (json['ContractedBy'] as List<dynamic>?)
          ?.map((e) => PobCustomer.fromJson(e as Map<String, dynamic>))
          .toList(),
      dob: json['dob'] as String?,
      expirationDate: json['expirationDate'] as String?,
      firstMiddleName: json['firstMiddleName'] as String?,
      gender: json['gender'] as String?,
      houseNumber: json['houseNumber'] as String?,
      isCaptain: json['isCaptain'] as bool?,
      isCrew: json['isCrew'] as bool?,
      isOther: json['isOther'] as bool?,
      isPassenger: json['isPassenger'] as bool?,
      isVip: json['isVip'] as bool?,
      issueDate: json['issueDate'] as String?,
      licenseIssuedCountry: json['LicenseIssuedCountry'] == null
          ? null
          : PassportCountry.fromJson(
              json['LicenseIssuedCountry'] as Map<String, dynamic>),
      licenseNumber: json['licenseNumber'] as String?,
      personHasPassportDocument:
          (json['PersonHasPassportDocument'] as List<dynamic>?)
              ?.map((e) => Passport.fromJson(e as Map<String, dynamic>))
              .toList(),
      personAddressCountry: json['PersonAddressCountry'] == null
          ? null
          : PassportCountry.fromJson(
              json['PersonAddressCountry'] as Map<String, dynamic>),
      personBirthCountry: json['PersonBirthCountry'] == null
          ? null
          : PassportCountry.fromJson(
              json['PersonBirthCountry'] as Map<String, dynamic>),
      personId: json['personId'] as int?,
      personMobile: json['PersonMobile'] == null
          ? null
          : PersonMobile.fromJson(json['PersonMobile'] as Map<String, dynamic>),
      street: json['street'] as String?,
      surname: json['surname'] as String?,
      zip: json['zip'] as String?,
    );

Map<String, dynamic> _$TripPobDetailToJson(TripPobDetail instance) =>
    <String, dynamic>{
      'personId': instance.personId,
      'firstMiddleName': instance.firstMiddleName,
      'surname': instance.surname,
      'dob': instance.dob,
      'gender': instance.gender,
      'PersonBirthCountry': instance.personBirthCountry?.toJson(),
      'PersonAddressCountry': instance.personAddressCountry?.toJson(),
      'LicenseIssuedCountry': instance.licenseIssuedCountry?.toJson(),
      'licenseNumber': instance.licenseNumber,
      'issueDate': instance.issueDate,
      'expirationDate': instance.expirationDate,
      'PersonMobile': instance.personMobile?.toJson(),
      'ContractedBy': instance.contractedBy?.map((e) => e.toJson()).toList(),
      'houseNumber': instance.houseNumber,
      'street': instance.street,
      'address': instance.address,
      'zip': instance.zip,
      'isCaptain': instance.isCaptain,
      'isCrew': instance.isCrew,
      'isPassenger': instance.isPassenger,
      'isVip': instance.isVip,
      'isOther': instance.isOther,
      'PersonHasPassportDocument':
          instance.personHasPassportDocument?.map((e) => e.toJson()).toList(),
    };
