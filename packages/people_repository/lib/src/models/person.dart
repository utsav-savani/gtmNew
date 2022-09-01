import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:aircraft_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:people_repository/people_repository.dart';
import 'package:people_repository/src/models/person_contact.dart';

part 'person.g.dart';

@JsonSerializable(explicitToJson: true)
class Person {
  late int personId;
  late String firstMiddleName;
  late String? surname;
  late String dob;
  late String gender;
  int? birthCountryId;
  int? birthStateProvId;
  int? birthCityId;
  String? guid;
  String? houseNumber;
  String? street;
  String? address;
  int? cityId;
  int? stateId;
  int? countryId;
  String? zip;
  late bool zipNa;
  late bool isCaptain;
  late bool isCrew;
  late bool isVip;
  late bool isPassenger;
  late bool isOther;
  String? licenseNumber;
  @JsonKey(name: "LicenseIssuedCountryId")
  int? licenseIssuedCountryId;
  String? issueDate;
  String? expirationDate;
  late bool ufn;
  @JsonKey(name: 'PersonHasMobile')
  List<PersonContact>? personHasMobile;
  @JsonKey(name: 'PersonHasEmail')
  List<PersonContact>? personHasEmail;
  @JsonKey(name: 'PersonHasPhone')
  List<PersonContact>? personHasPhone;
  @JsonKey(name: 'ContractedBy')
  List<Customers>? contractedBy;
  @JsonKey(name: 'PersonHasPassportDocument')
  List<Passport>? personHasPassportDocument;
  @JsonKey(name: 'PersonHasVisaDocument')
  List<Visa>? personHasVisaDocument;

  static Person fromJson(JsonMap json) => _$PersonFromJson(json);
  JsonMap toJson() => _$PersonToJson(this);
}
