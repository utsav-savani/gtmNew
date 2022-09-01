import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:people_repository/config/typedef_json.dart';
import 'package:people_repository/src/models/models.dart';

part 'visa.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Visa extends Equatable {
  final int? personVisaDocumentId;
  final int? personId;
  final int? countryId;
  final String? number;
  final String? issueDate;
  final String? expireDate;
  final bool? isActive;
  @JsonKey(name: 'CrewVisaDocumentFiles')
  final List<CrewVisaDocumentFiles>? crewVisaDocumentFiles;
  @JsonKey(name: 'PersonVisaIssueCountry')
  final PersonPassportIssueCountry? personVisaIssueCountry;

  Visa(
      {this.personVisaDocumentId,
      this.personId,
      this.countryId,
      this.number,
      this.issueDate,
      this.expireDate,
      this.isActive,
      this.crewVisaDocumentFiles,
      this.personVisaIssueCountry});

  Visa copyWith({
    int? personVisaDocumentId,
    int? personId,
    int? countryId,
    String? number,
    String? issueDate,
    String? expireDate,
    bool? isActive,
    List<CrewVisaDocumentFiles>? crewVisaDocumentFiles,
    PersonPassportIssueCountry? personVisaIssueCountry,
  }) =>
      Visa(
        countryId: countryId ?? this.countryId,
        expireDate: expireDate ?? this.expireDate,
        isActive: isActive ?? this.isActive,
        issueDate: issueDate ?? this.issueDate,
        number: number ?? this.number,
        personId: personId ?? this.personId,
        personVisaDocumentId: personVisaDocumentId ?? this.personVisaDocumentId,
        personVisaIssueCountry: personVisaIssueCountry ?? this.personVisaIssueCountry,
        crewVisaDocumentFiles: crewVisaDocumentFiles ?? this.crewVisaDocumentFiles,
      );

  /// Deserializes the given [JsonMap] into a [Visa].
  static Visa fromJson(JsonMap json) => _$VisaFromJson(json);

  /// Converts this [Visa] into a [JsonMap].
  JsonMap toJson() => _$VisaToJson(this);

  @override
  List<Object?> get props => [
        personVisaDocumentId,
        personId,
        countryId,
        number,
        issueDate,
        expireDate,
        isActive,
        crewVisaDocumentFiles,
        personVisaIssueCountry
      ];
}
