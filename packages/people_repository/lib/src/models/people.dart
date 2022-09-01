import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:people_repository/config/typedef_json.dart';
import 'package:people_repository/src/models/models.dart';

part 'people.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class People extends Equatable {
  final int personId;
  final String? guid;
  final String? name;
  final List<String>? roles;
  final String? nationality;
  final List<String>? customers;
  final List<Passport>? passport;
  final List<Visa>? visa;
  @JsonKey(name: 'PassportDocumentNumber')
  final List<String>? passportDocumentNumber;
  @JsonKey(name: 'VisaDocumentNumber')
  final List<String>? visaDocumentNumber;

  People({
    required this.personId,
    this.guid,
    this.name,
    this.roles,
    this.nationality,
    this.customers,
    this.passport,
    this.visa,
    this.passportDocumentNumber,
    this.visaDocumentNumber,
  });

  People copyWith(
      {required int personId,
      String? name,
      List<String>? roles,
      String? nationality,
      List<String>? customers,
      List<Passport>? passport,
      List<Visa>? visa,
      List<String>? passportDocumentNumber,
      List<String>? visaDocumentNumber}) {
    return People(
      personId: personId,
      name: name,
      roles: roles,
      nationality: nationality,
      customers: customers,
      passport: passport,
      visa: visa,
      passportDocumentNumber: passportDocumentNumber,
      visaDocumentNumber: visaDocumentNumber,
    );
  }

  /// Deserializes the given [JsonMap] into a [People].
  static People fromJson(JsonMap json) => _$PeopleFromJson(json);

  /// Converts this [People] into a [JsonMap].
  JsonMap toJson() => _$PeopleToJson(this);

  @override
  List<Object?> get props => [
        personId,
        name,
        roles,
        nationality,
        customers,
        passport,
        visa,
        passportDocumentNumber,
        visaDocumentNumber,
      ];
}
