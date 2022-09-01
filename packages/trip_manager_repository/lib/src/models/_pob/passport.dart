import 'package:flutter/material.dart';
import 'package:trip_manager_repository/src/models/_pob/passport_country.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'passport.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Passport extends Equatable {
  final int? personPassportDocumentId;
  final int? personId;
  final String? preference;
  final int? countryId;
  final String? number;
  final String? issueDate;
  final String? expireDate;
  final String? type;
  final bool? isActive;
  final String? nationality;
  @JsonKey(name: 'PersonPassportIssueCountry')
  final PassportCountry? personPassportIssueCountry;

  Passport({
    this.personPassportDocumentId,
    this.personId,
    this.preference,
    this.countryId,
    this.number,
    this.issueDate,
    this.expireDate,
    this.type,
    this.isActive,
    this.nationality,
    this.personPassportIssueCountry,
  });

  Passport copyWith({
    int? personPassportDocumentId,
    int? personId,
    String? preference,
    int? countryId,
    String? number,
    String? issueDate,
    String? expireDate,
    String? type,
    bool? isActive,
    String? nationality,
    PassportCountry? personPassportIssueCountry,
  }) {
    return Passport(
      personPassportDocumentId: personPassportDocumentId,
      personId: personId,
      preference: preference,
      countryId: countryId,
      number: number,
      issueDate: issueDate,
      expireDate: expireDate,
      type: type,
      isActive: isActive,
      nationality: nationality,
      personPassportIssueCountry: personPassportIssueCountry,
    );
  }

  /// Deserializes the given [JsonMap] into a [Passport].
  static Passport fromJson(JsonMap json) => _$PassportFromJson(json);

  /// Converts this [Passport] into a [JsonMap].
  JsonMap toJson() => _$PassportToJson(this);

  @override
  List<Object?> get props => [
        personPassportDocumentId,
        personId,
        preference,
        countryId,
        number,
        issueDate,
        expireDate,
        type,
        isActive,
        nationality,
        personPassportIssueCountry,
      ];
}
