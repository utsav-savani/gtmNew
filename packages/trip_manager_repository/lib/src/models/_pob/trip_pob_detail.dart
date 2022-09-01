import 'package:flutter/material.dart';
import 'package:trip_manager_repository/src/models/_pob/passport_country.dart';
import 'package:trip_manager_repository/src/models/_pob/person_mobile.dart';
import 'package:trip_manager_repository/src/models/_pob/pob_customer.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'trip_pob_detail.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripPobDetail extends Equatable {
  final int? personId;
  final String? firstMiddleName;
  final String? surname;
  final String? dob;
  final String? gender;
  @JsonKey(name: 'PersonBirthCountry')
  final PassportCountry? personBirthCountry;
  @JsonKey(name: 'PersonAddressCountry')
  final PassportCountry? personAddressCountry;
  @JsonKey(name: 'LicenseIssuedCountry')
  final PassportCountry? licenseIssuedCountry;
  final String? licenseNumber;
  final String? issueDate;
  final String? expirationDate;
  @JsonKey(name: 'PersonMobile')
  final PersonMobile? personMobile;
  @JsonKey(name: 'ContractedBy')
  final List<PobCustomer>? contractedBy;
  final String? houseNumber;
  final String? street;
  final String? address;
  final String? zip;
  final bool? isCaptain;
  final bool? isCrew;
  final bool? isPassenger;
  final bool? isVip;
  final bool? isOther;
  @JsonKey(name: 'PersonHasPassportDocument')
  final List<Passport>? personHasPassportDocument;

  const TripPobDetail({
    this.address,
    this.contractedBy,
    this.dob,
    this.expirationDate,
    this.firstMiddleName,
    this.gender,
    this.houseNumber,
    this.isCaptain,
    this.isCrew,
    this.isOther,
    this.isPassenger,
    this.isVip,
    this.issueDate,
    this.licenseIssuedCountry,
    this.licenseNumber,
    this.personHasPassportDocument,
    this.personAddressCountry,
    this.personBirthCountry,
    this.personId,
    this.personMobile,
    this.street,
    this.surname,
    this.zip,
  });

  TripPobDetail copyWith({
    int? personId,
    String? firstMiddleName,
    String? surname,
    String? dob,
    String? gender,
    PassportCountry? personBirthCountry,
    PassportCountry? personAddressCountry,
    PassportCountry? licenseIssuedCountry,
    String? licenseNumber,
    String? issueDate,
    String? expirationDate,
    PersonMobile? personMobile,
    List<PobCustomer>? contractedBy,
    String? houseNumber,
    String? street,
    String? address,
    String? zip,
    bool? isCaptain,
    bool? isCrew,
    bool? isPassenger,
    bool? isVip,
    bool? isOther,
    List<Passport>? personHasPassportDocument,
  }) {
    return TripPobDetail(
      address: address,
      contractedBy: contractedBy,
      dob: dob,
      expirationDate: expirationDate,
      firstMiddleName: firstMiddleName,
      gender: gender,
      houseNumber: houseNumber,
      isCaptain: isCaptain,
      isCrew: isCrew,
      isOther: isOther,
      isPassenger: isPassenger,
      isVip: isVip,
      issueDate: issueDate,
      licenseIssuedCountry: licenseIssuedCountry,
      licenseNumber: licenseNumber,
      personHasPassportDocument: personHasPassportDocument,
      personAddressCountry: personAddressCountry,
      personBirthCountry: personBirthCountry,
      personId: personId,
      personMobile: personMobile,
      street: street,
      surname: surname,
      zip: zip,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripPobDetail].
  static TripPobDetail fromJson(JsonMap json) => _$TripPobDetailFromJson(json);

  /// Converts this [TripPobDetail] into a [JsonMap].
  JsonMap toJson() => _$TripPobDetailToJson(this);

  @override
  List<Object?> get props => [
        address,
        contractedBy,
        dob,
        expirationDate,
        firstMiddleName,
        gender,
        houseNumber,
        isCaptain,
        isCrew,
        isOther,
        isPassenger,
        isVip,
        issueDate,
        licenseIssuedCountry,
        licenseNumber,
        personHasPassportDocument,
        personAddressCountry,
        personBirthCountry,
        personId,
        personMobile,
        street,
        surname,
        zip,
      ];
}
