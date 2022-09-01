// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person()
  ..personId = json['personId'] as int
  ..firstMiddleName = json['firstMiddleName'] as String
  ..surname = json['surname'] as String?
  ..dob = json['dob'] as String
  ..gender = json['gender'] as String
  ..birthCountryId = json['birthCountryId'] as int?
  ..birthStateProvId = json['birthStateProvId'] as int?
  ..birthCityId = json['birthCityId'] as int?
  ..guid = json['guid'] as String?
  ..houseNumber = json['houseNumber'] as String?
  ..street = json['street'] as String?
  ..address = json['address'] as String?
  ..cityId = json['cityId'] as int?
  ..stateId = json['stateId'] as int?
  ..countryId = json['countryId'] as int?
  ..zip = json['zip'] as String?
  ..zipNa = json['zipNa'] as bool
  ..isCaptain = json['isCaptain'] as bool
  ..isCrew = json['isCrew'] as bool
  ..isVip = json['isVip'] as bool
  ..isPassenger = json['isPassenger'] as bool
  ..isOther = json['isOther'] as bool
  ..licenseNumber = json['licenseNumber'] as String?
  ..licenseIssuedCountryId = json['LicenseIssuedCountryId'] as int?
  ..issueDate = json['issueDate'] as String?
  ..expirationDate = json['expirationDate'] as String?
  ..ufn = json['ufn'] as bool
  ..personHasMobile = (json['PersonHasMobile'] as List<dynamic>?)
      ?.map((e) => PersonContact.fromJson(e as Map<String, dynamic>))
      .toList()
  ..personHasEmail = (json['PersonHasEmail'] as List<dynamic>?)
      ?.map((e) => PersonContact.fromJson(e as Map<String, dynamic>))
      .toList()
  ..personHasPhone = (json['PersonHasPhone'] as List<dynamic>?)
      ?.map((e) => PersonContact.fromJson(e as Map<String, dynamic>))
      .toList()
  ..contractedBy = (json['ContractedBy'] as List<dynamic>?)
      ?.map((e) => Customers.fromJson(e as Map<String, dynamic>))
      .toList()
  ..personHasPassportDocument =
      (json['PersonHasPassportDocument'] as List<dynamic>?)
          ?.map((e) => Passport.fromJson(e as Map<String, dynamic>))
          .toList()
  ..personHasVisaDocument = (json['PersonHasVisaDocument'] as List<dynamic>?)
      ?.map((e) => Visa.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'personId': instance.personId,
      'firstMiddleName': instance.firstMiddleName,
      'surname': instance.surname,
      'dob': instance.dob,
      'gender': instance.gender,
      'birthCountryId': instance.birthCountryId,
      'birthStateProvId': instance.birthStateProvId,
      'birthCityId': instance.birthCityId,
      'guid': instance.guid,
      'houseNumber': instance.houseNumber,
      'street': instance.street,
      'address': instance.address,
      'cityId': instance.cityId,
      'stateId': instance.stateId,
      'countryId': instance.countryId,
      'zip': instance.zip,
      'zipNa': instance.zipNa,
      'isCaptain': instance.isCaptain,
      'isCrew': instance.isCrew,
      'isVip': instance.isVip,
      'isPassenger': instance.isPassenger,
      'isOther': instance.isOther,
      'licenseNumber': instance.licenseNumber,
      'LicenseIssuedCountryId': instance.licenseIssuedCountryId,
      'issueDate': instance.issueDate,
      'expirationDate': instance.expirationDate,
      'ufn': instance.ufn,
      'PersonHasMobile':
          instance.personHasMobile?.map((e) => e.toJson()).toList(),
      'PersonHasEmail':
          instance.personHasEmail?.map((e) => e.toJson()).toList(),
      'PersonHasPhone':
          instance.personHasPhone?.map((e) => e.toJson()).toList(),
      'ContractedBy': instance.contractedBy?.map((e) => e.toJson()).toList(),
      'PersonHasPassportDocument':
          instance.personHasPassportDocument?.map((e) => e.toJson()).toList(),
      'PersonHasVisaDocument':
          instance.personHasVisaDocument?.map((e) => e.toJson()).toList(),
    };
