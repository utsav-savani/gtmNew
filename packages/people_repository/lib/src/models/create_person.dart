import 'package:json_annotation/json_annotation.dart';
import 'package:people_repository/config/typedef_json.dart';
import 'package:people_repository/src/models/add_contact.dart';
part 'create_person.g.dart';

@JsonSerializable(explicitToJson: true)
class CreatePerson {
  final String firstMiddleName;
  final String surname;
  final String gender;
  final String dob;
  final int birthCountryId;
  final bool zipNa;
  final int formId;
  final String? houseNumber;
  final String? street;
  final String? zip;
  final String? address;
  @JsonKey(name: 'Contacts')
  final AddContact? contacts;
  final int? birthStateProvId;
  final int? birthCityId;
  final int? countryId;
  final int? cityId;

  CreatePerson(
      {required this.firstMiddleName,
      required this.surname,
      required this.gender,
      required this.dob,
      required this.birthCountryId,
      required this.zipNa,
      required this.formId,
      this.houseNumber,
      this.street,
      this.zip,
      this.address,
      this.contacts,
      this.birthStateProvId,
      this.birthCityId,
      this.countryId,
      this.cityId});

  static CreatePerson fromJson(JsonMap json) => _$CreatePersonFromJson(json);
  JsonMap toJson() => _$CreatePersonToJson(this);
}
