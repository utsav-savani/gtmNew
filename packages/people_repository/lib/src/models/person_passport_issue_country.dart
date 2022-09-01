import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:people_repository/config/typedef_json.dart';

part 'person_passport_issue_country.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class PersonPassportIssueCountry extends Equatable {
  final int? countryId;
  final String? name;
  final String? code;
  final String? code3;

  PersonPassportIssueCountry({this.countryId, this.name, this.code, this.code3});

  PersonPassportIssueCountry copyWith(
    int? countryId,
    String? name,
    String? code,
    String? code3,
  ) =>
      PersonPassportIssueCountry(
        countryId: countryId ?? this.countryId,
        name: name ?? this.name,
        code: code ?? this.code,
        code3: code3 ?? this.code3,
      );

  /// Deserializes the given [JsonMap] into a [PersonPassportIssueCountry].
  static PersonPassportIssueCountry fromJson(JsonMap json) => _$PersonPassportIssueCountryFromJson(json);

  /// Converts this [PersonPassportIssueCountry] into a [JsonMap].
  JsonMap toJson() => _$PersonPassportIssueCountryToJson(this);

  @override
  List<Object?> get props => [];
}
