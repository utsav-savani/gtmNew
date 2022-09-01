import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:people_repository/config/typedef_json.dart';
import 'package:people_repository/src/models/models.dart';

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
  final PersonPassportIssueCountry? personPassportIssueCountry;
  @JsonKey(name: 'CrewPassportDocumentFiles')
  final List<CrewPassportDocumentFiles>? crewPassportDocumentFiles;

  Passport(
      {this.personPassportDocumentId,
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
      this.crewPassportDocumentFiles});

  Passport copyWith(
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
    PersonPassportIssueCountry? personPassportIssueCountry,
    List<CrewPassportDocumentFiles>? crewPassportDocumentFiles,
  ) =>
      Passport(
        countryId: countryId ?? this.countryId,
        crewPassportDocumentFiles:
            crewPassportDocumentFiles ?? this.crewPassportDocumentFiles,
        expireDate: expireDate ?? this.expireDate,
        isActive: isActive ?? this.isActive,
        issueDate: issueDate ?? this.issueDate,
        nationality: nationality ?? this.nationality,
        number: number ?? this.number,
        personId: personId ?? this.personId,
        personPassportDocumentId:
            personPassportDocumentId ?? this.personPassportDocumentId,
        personPassportIssueCountry:
            personPassportIssueCountry ?? this.personPassportIssueCountry,
        preference: preference ?? this.preference,
        type: type ?? this.type,
      );

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
        crewPassportDocumentFiles
      ];
}
